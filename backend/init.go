package main

import (
	"backend/mysqlc"
	"database/sql"
	"fmt"
	"github.com/joho/godotenv"
)

var env = initEnv()
var database = initDb()

func initEnv() map[string]string {
	if env, err := godotenv.Read(".env"); err != nil {
		return nil
	} else {
		return env
	}
}

func initDb() *mysqlc.Queries {
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s",
		env["DB_USER"],
		env["DB_PASS"],
		env["DB_HOST"],
		env["DB_PORT"],
		env["DB_NAME"],
	)
	if db, err := sql.Open("mysql", dsn); err != nil {
		return nil
	} else {
		return mysqlc.New(db)
	}
}
