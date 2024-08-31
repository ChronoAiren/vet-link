package pets

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
