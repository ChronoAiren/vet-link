### Environment Variables

-----
After checking out the branch with GoLang as backend, create a `backend.yaml` file with the following fields:
1) dsn (e.g., *user:password@tcp(127.0.0.1:3306)/dbname*)
2) port (e.g., *8080*)

### Install GoLang

-----
Make sure to have GoLang installed
1) Download the installer from https://go.dev/doc/install
2) Verify installation, via this command `go version`

### (Optional) SQL Code Generation

-----
*Note: Please contact the backend team for the latest database backup file for importing to your local instance.*

To use database-first SQL code generation, create a `bobgen.yaml` file in the root directory file, with these fields (feel free to personalize `dsn` field):

````yaml
mysql:
    dsn: "user:password@tcp(127.0.0.1:3306)/dbname"
    output: "generated/models"
````

Then, make sure your MySQL Service is running and your local database is up-to-date, before running this command:

````go
go run github.com/stephenafamo/bob/gen/bobgen-mysql@latest
````


### Live Reloading

-----
For hot reloading when making then saving changes, run this command in the root directory of the project:
````go
go run github.com/air-verse/air@latest
````