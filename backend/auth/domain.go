package auth

import (
	"backend/mysqlc"
	"context"
	"net/http"
)

func (s *Service) login(ctx context.Context, r LoginRequest) (int, *mysqlc.User) {
	user, err := s.store.GetUserByEmail(ctx, r.Email)
	if err != nil {
		return http.StatusNotFound, nil
	}
	if user.Password != r.Password {
		return http.StatusUnauthorized, nil
	}
	return http.StatusOK, &user
}

func (s *Service) registerPetOwner(ctx context.Context, r RegisterPetOwnerRequest) (int, *mysqlc.User) {
	if existingUser, err := s.store.GetUserByEmail(ctx, r.Email); err != nil {
		return http.StatusInternalServerError, nil
	} else if existingUser.Email == r.Email {
		return http.StatusConflict, nil
	}
	if result, err := s.store.CreateUser(ctx, mysqlc.CreateUserParams{
		GivenName:  r.GivenName,
		FamilyName: r.FamilyName,
		Email:      r.Email,
		Password:   r.Password,
	}); err != nil {
		return http.StatusInternalServerError, nil
	} else if rows, err := result.RowsAffected(); rows == 0 || err != nil {
		return http.StatusConflict, nil
	}
	return s.login(ctx, LoginRequest{
		Email:    r.Email,
		Password: r.Password,
	})
}
