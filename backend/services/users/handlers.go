package users

import (
	my "backend/framework"
	. "backend/generated/models"
	g "backend/globals"
)

func (s *Service) handleReadAll(c *my.Context, data chan<- interface{}, err chan<- error) {
	if users, e := ListUsers(c, s.Store); e != nil {
		err <- e
	} else {
		var dtoSlice []UserResponse
		for _, user := range users {
			dtoSlice = append(dtoSlice, UserResponse{
				ID:         user.ID,
				Email:      user.Email,
				FamilyName: user.FamilyName,
				GivenName:  user.GivenName,
				Role:       user.R.Role.Description,
			})
		}
		data <- dtoSlice
	}
}

func (s *Service) handleCreate(c *my.Context, data chan<- interface{}, err chan<- error) {
	if inserted, e := InsertUser(c, s.Store, g.RoleDefault); e != nil {
		err <- e
	} else if retrieved, e := Users.Query(
		c.GetContext(), s.Store.Db,
		SelectWhere.Users.Email.EQ(inserted.Email),
		PreloadUserRole(),
	).One(); e != nil {
		err <- e
	} else {
		data <- UserResponse{
			ID:         retrieved.ID,
			Email:      retrieved.Email,
			FamilyName: retrieved.FamilyName,
			GivenName:  retrieved.GivenName,
			Role:       retrieved.R.Role.Description,
		}
	}
}

func (s *Service) handleLogin(c *my.Context, data chan<- interface{}, err chan<- error) {
	req := new(LoginUserRequest)
	if e := c.Api.Bind(req); e != nil {
		err <- e
	} else if user, e := Users.Query(
		c.GetContext(), s.Store.Db,
		SelectWhere.Users.Email.EQ(req.Email),
		SelectWhere.Users.Password.EQ(req.Password),
		PreloadUserRole(),
	).One(); e != nil {
		err <- e
	} else if user != nil {
		data <- UserResponse{
			ID:         user.ID,
			Email:      user.Email,
			FamilyName: user.FamilyName,
			GivenName:  user.GivenName,
			Role:       user.R.Role.Description,
		}
	}
}
