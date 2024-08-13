package main

import (
	"backend/auth"
	_ "github.com/go-sql-driver/mysql"
	"github.com/labstack/echo/v4"
)

func run() error {
	backend := echo.New()

	authSvc := auth.New(database, backend)
	authSvc.AddRoutes()

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
