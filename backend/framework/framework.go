package framework

import (
	"backend/store"
	"context"
	"github.com/labstack/echo/v4"
)

type Framework struct {
	Database *store.Store
	Api      *echo.Echo
}

type Service interface {
	Inject(db *store.Store, api *echo.Echo)
	Serve()
}

func (f Framework) RegisterServices(services ...Service) {
	for _, service := range services {
		service.Inject(f.Database, f.Api)
		service.Serve()
	}
}

func New(e *echo.Echo, db store.Store) *Framework {
	return &Framework{
		Database: &db,
		Api:      e,
	}
}

type Context struct {
	Api echo.Context
}

func NewContext(c echo.Context) *Context {
	return &Context{Api: c}
}

func (c *Context) GetContext() context.Context {
	return c.Api.Request().Context()
}

func Bind[T any](c *Context) (*T, error) {
	param := new(T)
	err := c.Api.Bind(&param)
	return param, err
}
