package main

import (
	"backend/framework"
	. "backend/globals"
	"backend/services/pets"
	"backend/services/users"
	"backend/services/users/employees"
	"backend/services/users/employees/receptionist"
	"backend/services/users/employees/veterinarian"
	"backend/services/users/owners/clinicowners"
	"backend/services/users/owners/petowners"
	"backend/store"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"gopkg.in/yaml.v3"
	"net/http"
	"os"
)

func run() (err error) {
	var d *store.Store
	d, err = store.NewDatabase(env.Dsn)
	if err != nil {
		return
	}

	f := framework.New(echo.New(), *d)
	f.Api.Use(middleware.CORS())
	f.Api.Use(middleware.RequestLoggerWithConfig(middleware.RequestLoggerConfig{
		LogStatus: true, LogURI: true, LogMethod: true, LogRemoteIP: true,
		LogValuesFunc: func(c echo.Context, v middleware.RequestLoggerValues) error {
			color := Elvis(v.Status == http.StatusOK, Green, Red)
			fmt.Printf(
				Colorize(Yellow, "%-15s")+Colorize(color, " %3d")+" %6s %s\n",
				v.RemoteIP, v.Status, v.Method, v.URI,
			)
			return nil
		},
	}))
	f.RegisterServices(
		// User-related services
		users.New(),
		petowners.New(),
		clinicowners.New(),
		// Staff-related services
		employees.New(),
		receptionist.New(),
		veterinarian.New(),
		// Pet-related services
		pets.New(),
	)

	err = f.Api.Start(env.Port)
	return
}

func init() {
	if file, err := os.ReadFile("backend.yaml"); err != nil {
		panic(err)
	} else if err = yaml.Unmarshal(file, &env); err != nil {
		panic(err)
	}
}

func main() {
	if err := run(); err != nil {
		panic(err)
	}
}

type Environment struct {
	Dsn  string `yaml:"dsn"`
	Port string `yaml:"port"`
}

var env Environment
