package users

import (
	"backend/store"
	"github.com/labstack/echo/v4"
)

type Service struct {
	Store *store.Store
	Api   *echo.Echo
}

func New() *Service { return &Service{} }

func (s *Service) Inject(db *store.Store, api *echo.Echo) {
	s.Store = db
	s.Api = api
}

func (s *Service) Serve() {
	s.Api.GET("/users", s.listUsers)
	s.Api.POST("/users", s.createUser)
}
