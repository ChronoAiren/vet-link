package auth

import (
	"backend/mysqlc"
	"context"
	"net/http"
)

func (s *Service) login(ctx context.Context, r LoginRequest) (int, *UserDTO) {
	if user, err := s.store.GetUserByEmail(ctx, r.Email); err != nil {
		return http.StatusNotFound, nil
	} else if user.Password != r.Password {
		return http.StatusUnauthorized, nil
	} else {
		return http.StatusOK, &UserDTO{
			user.ID,
			user.GivenName,
			user.FamilyName,
			user.Email,
			&user.UserRole,
		}
	}
}

func (s *Service) register(ctx context.Context, r RegisterRequest) (int, *UserDTO) {
	if _, err := s.store.CreateUser(ctx, mysqlc.CreateUserParams{
		GivenName:  r.GivenName,
		FamilyName: r.FamilyName,
		Email:      r.Credentials.Email,
		Password:   r.Credentials.Password,
	}); err != nil {
		return http.StatusBadRequest, nil
	}
	return s.login(ctx, r.Credentials)
}

type Role uint8

const (
	RoleAdmin uint8 = 1 + iota
	RoleDefault
	RoleClinicOwner
)

func (s *Service) registerClinic(ctx context.Context, r RegisterClinicRequest) (int, *ClinicDTO) {
	if _, err := s.store.CreateUser(ctx, mysqlc.CreateUserParams{
		GivenName:  r.User.GivenName,
		FamilyName: r.User.FamilyName,
		Email:      r.User.Credentials.Email,
		Password:   r.User.Credentials.Password,
		RoleID:     RoleClinicOwner,
	}); err != nil {
		return http.StatusBadRequest, nil
	} else if _, user := s.login(ctx, r.User.Credentials); user == nil {
		return http.StatusBadRequest, nil
	}
	if result, err := s.store.CreateClinic(ctx, mysqlc.CreateClinicParams{
		UserID:     r.UserID,
		Name:       r.Name,
		Location:   r.Location,
		BusinessNo: r.BusinessNo,
	}); err != nil {
		return http.StatusBadRequest, nil
	} else if id, err := result.LastInsertId(); err != nil {
		return http.StatusBadRequest, nil
	} else if clinic, err := s.store.GetClinic(ctx, uint32(id)); err != nil {
		return http.StatusBadRequest, nil
	} else {
		return http.StatusOK, &ClinicDTO{
			clinic.ID,
			clinic.Name,
			clinic.Location,
			clinic.BusinessNo,
			UserDTO{
				clinic.User.ID,
				clinic.User.GivenName,
				clinic.User.FamilyName,
				clinic.User.Email,
				&clinic.UserRole,
			},
		}
	}
}
