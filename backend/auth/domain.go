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
			user.Role,
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

func (s *Service) registerClinic(ctx context.Context, r RegisterClinicRequest) (int, *mysqlc.ClinicRow) {
	code, user := s.register(ctx, r.User)
	if code != http.StatusOK || user == nil {
		return http.StatusBadRequest, nil
	}
	if result, err := s.store.CreateClinic(ctx, mysqlc.CreateClinicParams{
		UserID:     user.ID,
		Name:       r.Name,
		Location:   r.Location,
		BusinessNo: r.BusinessNo,
	}); err != nil {
		return http.StatusBadRequest, nil
	} else if clinicID, err := result.LastInsertId(); err != nil {
		return http.StatusBadRequest, nil
	} else if clinic, err := s.store.Clinic(ctx, uint32(clinicID)); err != nil {
		return http.StatusBadRequest, nil
	} else {
		return http.StatusOK, &clinic
	}
}
