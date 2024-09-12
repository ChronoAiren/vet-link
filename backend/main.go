package main

import (
	"backend/framework"
	"backend/services/pets"
	"backend/services/users"
	"backend/services/users/employees"
	"backend/services/users/employees/receptionist"
	"backend/services/users/employees/veterinarian"
	"backend/services/users/owners/clinicowners"
	"backend/services/users/owners/petowners"
	"backend/store"
	_ "github.com/go-sql-driver/mysql"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"gopkg.in/yaml.v3"
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
	f.Api.GET("/test", func(c echo.Context) error {
		return c.String(200, "Hello, World!")
	})

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
