package clinicowners

import (
	my "backend/framework"
	. "backend/generated/models"
	g "backend/globals"
	"backend/services/users"
	"github.com/aarondl/opt/omit"
	"github.com/stephenafamo/bob"
	"github.com/stephenafamo/bob/dialect/mysql/dialect"
	"log"
)

func (s *Service) handleReadAll(c *my.Context, data my.ResultChan, err my.ErrorChan) {
	type clinicResponse struct {
		ID         uint32             `json:"id"`
		ClinicName string             `json:"clinicName"`
		Location   string             `json:"location"`
		BusinessNo string             `json:"businessNo"`
		Owner      users.UserResponse `json:"owner"`
	}
	params := new(ListClinicOwnersRequest)
	if e := c.Api.Bind(params); e != nil {
		err <- e
		return
	}
	var args []bob.Mod[*dialect.SelectQuery]
	if params.Verified != nil {
		args = append(args, SelectWhere.Users.RoleID.EQ(
			g.Elvis(*params.Verified,
				g.RoleClinicOwner,
				g.RoleUnverifiedClinicOwner,
			),
		))
	}
	if clinics, e := ListClinics(c, s.Store, args...); e != nil {
		err <- e
	} else {
		var dtoSlice []clinicResponse
		for _, clinic := range clinics {
			dtoSlice = append(dtoSlice, clinicResponse{
				ID:         clinic.ID,
				ClinicName: clinic.Name,
				Location:   clinic.Location,
				BusinessNo: clinic.BusinessNo,
				Owner: users.UserResponse{
					ID:         clinic.UserID,
					Email:      clinic.R.User.Email,
					FamilyName: clinic.R.User.FamilyName,
					GivenName:  clinic.R.User.GivenName,
				},
			})
		}
		data <- dtoSlice
	}
}

func (s *Service) handleCreate(c *my.Context, data my.ResultChan, err my.ErrorChan) {
	params := new(CreateRequest)
	if e := c.Api.Bind(params); e != nil {
		err <- e
	} else if e = s.Store.Transact(c.GetContext(), func(tx *bob.Tx) error {
		if user, e := users.InsertUser(c, tx, params); e != nil {
			return e
		} else {
			params.User = user
			clinic, e := InsertClinic(c, tx, params)
			if e != nil {
				return e
			}
			data <- clinic
		}
		return nil
	}); e != nil {
		err <- e
	}
}

func (s *Service) handleVerify(c *my.Context, data my.ResultChan, err my.ErrorChan) {
	log.Println("verify endpoint called")
	params := new(VerifyRequest)
	log.Println(c.Api.Path())
	if e := c.Api.Bind(params); e != nil {
		err <- e
	} else if e = s.Store.Transact(c.GetContext(), func(tx *bob.Tx) error {
		log.Println(params.Id)
		if clinic, e := Clinics.Query(c.GetContext(), tx,
			SelectWhere.Clinics.ID.EQ(params.Id),
			PreloadClinicUser(),
		).One(); e != nil {
			return e
		} else if e = clinic.R.User.Update(c.GetContext(), tx, &UserSetter{
			RoleID: omit.From(g.RoleClinicOwner),
		}); e != nil {
			log.Println(clinic)
			return e
		} else {
			data <- ClinicResponse{
				ID:         clinic.ID,
				ClinicName: clinic.Name,
				Location:   clinic.Location,
				BusinessNo: clinic.BusinessNo,
				Owner: users.UserResponse{
					ID:         clinic.UserID,
					Email:      clinic.R.User.Email,
					FamilyName: clinic.R.User.FamilyName,
					GivenName:  clinic.R.User.GivenName,
				},
			}
			return nil
		}
	}); e != nil {
		err <- e
	}
}
