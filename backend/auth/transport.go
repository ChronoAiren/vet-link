package auth

import (
	"context"
	"errors"
	"github.com/labstack/echo/v4"
	"net/http"
)

func (s *Service) RegisterRoutes() {
	s.serve.POST("login", func(c echo.Context) error {
		req := new(LoginRequest)
		if err := c.Bind(req); err != nil {
			return err
		}
		ctx := c.Request().Context()
		return s.handleLogin(c, ctx, req)
	})
	s.serve.POST("register/pet-owner", func(c echo.Context) error {
		req := new(RegisterPetOwnerRequest)
		if err := c.Bind(req); err != nil {
			return err
		}
		ctx := c.Request().Context()
		return s.handleRegisterPetOwner(c, ctx, req)
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

func (s *Service) handleRegisterPetOwner(c echo.Context, ctx context.Context, req *RegisterPetOwnerRequest) error {
	code, user := s.registerPetOwner(ctx, *req)
	if user == nil {
		return errors.New("internal server error")
	}
	switch code {
	case http.StatusOK:
		loginReq := LoginRequest{req.Email, req.Password}
		return s.handleLogin(c, ctx, &loginReq)
	case http.StatusConflict:
		return c.String(http.StatusConflict, "Email already taken")
	default:
		return c.String(http.StatusBadGateway, "Having connection issues")
	}
}
