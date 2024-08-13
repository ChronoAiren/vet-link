package auth

import (
	"context"
	"errors"
	"github.com/labstack/echo/v4"
	"net/http"
)

func (s *Service) AddRoutes() {
	s.serve.GET("/users", func(c echo.Context) error {
		ctx := c.Request().Context()
		if users, err := s.store.ListUsers(ctx); err != nil {
			return err
		} else {
			var usersDTO []UserDTO
			for _, user := range users {
				usersDTO = append(usersDTO, UserDTO{
					user.ID,
					user.GivenName,
					user.FamilyName,
					user.Email,
					user.Role,
				})
			}
			return c.JSONPretty(http.StatusOK, usersDTO, "  ")
		}
	})
	s.serve.GET("/clinics", func(c echo.Context) error {
		ctx := c.Request().Context()
		if clinics, err := s.store.ListClinics(ctx); err != nil {
			return err
		} else {
			return c.JSONPretty(http.StatusOK, clinics, "  ")
		}
	})
	s.serve.POST("/login", func(c echo.Context) error {
		req := new(LoginRequest)
		if err := c.Bind(req); err != nil {
			return err
		}
		ctx := c.Request().Context()
		return s.handleLogin(c, ctx, req)
	})
	s.serve.POST("/register", func(c echo.Context) error {
		req := new(RegisterRequest)
		if err := c.Bind(req); err != nil {
			return err
		}
		ctx := c.Request().Context()
		return s.handleRegister(c, ctx, req)
	})
	s.serve.POST("/register/clinic", func(c echo.Context) error {
		req := new(RegisterClinicRequest)
		if err := c.Bind(req); err != nil {
			return err
		}
		ctx := c.Request().Context()
		return s.handleRegisterClinic(c, ctx, req)
	})
}

func (s *Service) handleLogin(c echo.Context, ctx context.Context, req *LoginRequest) error {
	code, user := s.login(ctx, *req)
	switch code {
	case http.StatusOK:
		return c.JSON(http.StatusOK, user)
	case http.StatusUnauthorized:
		return c.String(http.StatusUnauthorized, "Wrong password")
	case http.StatusNotFound:
		return c.String(http.StatusNotFound, "User not found")
	default:
		return c.String(http.StatusBadGateway, "Having connection issues")
	}
}

func (s *Service) handleRegister(c echo.Context, ctx context.Context, req *RegisterRequest) error {
	code, _ := s.register(ctx, *req)
	switch code {
	case http.StatusOK:
		return s.handleLogin(c, ctx, &req.Credentials)
	default:
		return c.String(http.StatusBadGateway, "Having connection issues")
	}
}

func (s *Service) handleRegisterClinic(c echo.Context, ctx context.Context, req *RegisterClinicRequest) error {
	genericError := errors.New("bad request")
	if _, user := s.register(ctx, req.User); user == nil {
		return genericError
	} else {
		req.UserID = user.ID
	}
	if code, clinic := s.registerClinic(ctx, *req); clinic == nil {
		return genericError
	} else {
		switch code {
		case http.StatusOK:
			return c.JSON(http.StatusOK, clinic)
		default:
			return c.String(http.StatusBadGateway, "Having connection issues")
		}
	}
}
