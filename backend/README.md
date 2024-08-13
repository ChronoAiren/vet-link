### Environment Variables

-----
After checking out the branch with GoLang as backend, create a .env file with the following fields:
1) DB_USER
2) DB_PASS
3) DB_HOST (e.g., *localhost*)
4) DB_NAME (e.g., *vetlink*)
5) DB_PORT (e.g., *3306*)
6) BE_PORT (e.g., *1323*)

### Install GoLang

-----
Make sure to have GoLang installed
1) Download the installer from https://go.dev/doc/install
2) Verify installation, via this command `go version`

### SQL Code Generator

-----
To use SQL code-gen for Go, install sqlc via this command:
````
go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest
````


Immediately after, run `sqlc generate` in the root directory of the project and repeatedly after making changes to the project's .sql files


### Live Reloading

-----
For hot reloading when making then saving changes, install air:
````
go install github.com/air-verse/air@latest
````
and run `air` in the root directory of the project