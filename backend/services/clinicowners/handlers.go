package clinicowners

import (
	my "backend/framework"
	. "backend/generated/models"
	g "backend/globals"
	"backend/services/users"
	"github.com/labstack/echo/v4"
	"net/http"
)

func (s *Service) listClinicOwners(c echo.Context) (err error) {
	clinicsChan := make(chan []ClinicResponse)
	errChan := make(chan error)
	go func() {
		ctx := my.NewContext(c)
		var clinicSlice ClinicSlice
		req := new(ListClinicOwnersRequest)
		if err = c.Bind(req); err != nil {
			errChan <- err
			return
		}
		if req.Verified != nil {
			if *req.Verified {
				if clinicSlice, err = ListClinics(ctx, s.Store,
					SelectWhere.Users.RoleID.EQ(g.RoleClinicOwner),
				); err != nil {
					errChan <- err
					return
				}
			} else if clinicSlice, err = ListClinics(ctx, s.Store,
				SelectWhere.Users.RoleID.EQ(g.RoleUnverifiedClinicOwner),
			); err != nil {
				errChan <- err
				return
			}
		} else {
			if clinicSlice, err = ListClinics(ctx, s.Store); err != nil {
				errChan <- err
				return
			}
		}
		var clinicsDTO []ClinicResponse
		for _, clinic := range clinicSlice {
			clinicsDTO = append(clinicsDTO, ClinicResponse{
				ID:         clinic.ID,
				ClinicName: clinic.Name,
				Location:   clinic.Location,
				BusinessNo: clinic.BusinessNo,
				User: users.UserResponse{
					ID:         clinic.UserID,
					Email:      clinic.R.User.Email,
					FamilyName: clinic.R.User.FamilyName,
					GivenName:  clinic.R.User.GivenName,
				},
			})
		}
		clinicsChan <- clinicsDTO
	}()
	select {
	case clinics := <-clinicsChan:
		return c.JSON(http.StatusOK, clinics)
	case err := <-errChan:
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}
}

func (s *Service) createClinicOwner(c echo.Context) (err error) {
	errChan := make(chan error)
	go func() {
		ctx := my.NewContext(c)
		if _, err := users.InsertUser(ctx, s.Store, g.RoleDefault); err != nil {
			errChan <- err
		}
	}()
	select {
	case err := <-errChan:
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	default:
		return c.String(http.StatusCreated, "User and Clinic created")
	}
}
