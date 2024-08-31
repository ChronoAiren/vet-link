package globals

import (
	"errors"
	"github.com/labstack/echo/v4"
	"net/http"
)

var Errors = [3]error{
	errors.New("env parsing failed"),
	errors.New("db connection failed"),
	echo.NewHTTPError(http.StatusBadRequest),
}

const (
	RoleDefault uint8 = 2 + iota
	RoleClinicOwner
	RoleUnverifiedClinicOwner
)
