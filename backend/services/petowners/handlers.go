package petowners

import (
	my "backend/framework"
	. "backend/generated/models"
	g "backend/globals"
	"backend/services/users"
	"github.com/labstack/echo/v4"
	"net/http"
)

func (s *Service) listPetOwners(c echo.Context) (err error) {
	usersChan := make(chan []users.UserResponse)
	errChan := make(chan error)
	go func() {
		userSlice, err := users.ListUsers(
			my.NewContext(c), s.Store.Db,
			SelectWhere.Users.RoleID.EQ(g.RoleDefault),
		)
		if err != nil {
			errChan <- err
			return
		}
		usersChan <- userSlice
	}()
	select {
	case userSlice := <-usersChan:
		return c.JSON(http.StatusOK, userSlice) // Optimized JSON response
	case err := <-errChan:
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}
}

func (s *Service) createPetOwner(c echo.Context) (err error) {
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
		return c.String(http.StatusCreated, "User created")
	}
}
