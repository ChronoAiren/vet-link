-- name: GetUserByEmail :one
SELECT * FROM users WHERE email = ? LIMIT 1;

-- name: CreateUser :execresult
INSERT INTO users (given_name, family_name, email, password) VALUES (?, ?, ?, ?);

-- name: ListUsers :many
SELECT * FROM users;
