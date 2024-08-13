package auth

import (
	"backend/mysqlc"
	"github.com/labstack/echo/v4"
)

type Service struct {
	store *mysqlc.Queries
	serve *echo.Echo
}

func New(store *mysqlc.Queries, serve *echo.Echo) *Service {
	return &Service{store, serve}
}

type LoginRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type RegisterPetOwnerRequest struct {
	Email      string `json:"email"`
	Password   string `json:"password"`
	GivenName  string `json:"first_name"`
	FamilyName string `json:"last_name"`
}
