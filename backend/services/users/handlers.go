package users

import (
	my "backend/framework"
	_ "backend/generated/models"
	g "backend/globals"
	"github.com/labstack/echo/v4"
	"net/http"
)

func (s *Service) listUsers(c echo.Context) (err error) {
	usersChan := make(chan []UserResponse)
	errChan := make(chan error)
	go func() {
		users, err := ListUsers(my.NewContext(c), s.Store.Db)
		if err != nil {
			errChan <- err
			return
		}
		usersChan <- users
	}()
	select {
	case users := <-usersChan:
		return c.JSON(http.StatusOK, users) // Optimized JSON response
	case err := <-errChan:
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}
}

func (s *Service) createUser(c echo.Context) error {
	errChan := make(chan error)
	go func() {
		ctx := my.NewContext(c)
		if _, err := InsertUser(ctx, s.Store, g.RoleDefault); err != nil {
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
