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
	Email    string
	Password string
}

type RegisterRequest struct {
	Credentials LoginRequest
	GivenName   string
	FamilyName  string
}

type RegisterClinicRequest struct {
	User       RegisterRequest
	UserID     uint32
	Name       string
	Location   string
	BusinessNo string
}

type UserDTO struct {
	ID         uint32
	GivenName  string
	FamilyName string
	Email      string
	Role       *string `json:"Role,omitempty"`
}

type ClinicDTO struct {
	ID         uint32
	Name       string
	Location   string
	BusinessNo string
	User       UserDTO `json:"Owner"`
}
