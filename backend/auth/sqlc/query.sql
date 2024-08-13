-- noinspection SqlResolveForFile

-- name: GetUserByEmail :one
SELECT users.*, roles.description AS role
FROM users JOIN roles ON roles.id = users.role_id
WHERE email = ?;

-- name: CreateUser :execresult
INSERT INTO users (given_name, family_name, email, password, role_id)
VALUES (?, ?, ?, ?, ?);

-- name: ListUsers :many
SELECT users.*, roles.description AS role
FROM users JOIN roles ON roles.id = users.role_id;

-- name: CreateClinic :execresult
INSERT INTO clinics (user_id, name, location, business_no)
VALUES (?, ?, ?, ?);

-- name: ListClinics :many
SELECT clinics.*, sqlc.embed(users)
FROM clinics JOIN users ON users.id = user_id;

-- name: GetClinic :one
SELECT clinics.*, sqlc.embed(users)
FROM clinics JOIN users ON users.id = user_id
WHERE user_id = ?;

-- name: GetClinicByBusinessNo :one
SELECT * FROM clinics WHERE business_no = ?;
