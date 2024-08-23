package main

import (
	"backend/auth"
	"backend/pets"
	_ "github.com/go-sql-driver/mysql"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func run() error {
	backend := echo.New()
	backend.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowOrigins: []string{"*"},
		AllowMethods: []string{echo.GET, echo.POST, echo.PUT, echo.DELETE},
		AllowHeaders: []string{echo.HeaderOrigin, echo.HeaderContentType, echo.HeaderAccept},
	}))

	authSvc := auth.New(database, backend)
	authSvc.AddRoutes()

	petsSvc := pets.New(database, backend)
	petsSvc.AddRoutes()

	address := ":" + env["BE_PORT"]
	if err := backend.Start(address); err != nil {
		return err
	}
	return nil
}

func main() {
	if env == nil {
		panic("env not found")
	}
	if err := run(); err != nil {
		panic(err)
	}
}
