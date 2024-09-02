package users

import (
	my "backend/framework"
	. "backend/generated/models"
	"github.com/stephenafamo/bob"
)

func (s *Service) handleReadAll(c *my.Context, data my.ResultChan, err my.ErrorChan) {
	if users, e := Users.Query(c.GetContext(), s.Store.Db, PreloadUserRole()).All(); e != nil {
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

func (s *Service) handleCreate(c *my.Context, data my.ResultChan, err my.ErrorChan) {
	params := new(CreateRequest)
	if e := c.Api.Bind(params); e != nil {
		err <- e
	} else if e = s.Store.Transact(c.GetContext(), func(tx *bob.Tx) error {
		user, e := InsertUser(c, tx, params)
		if e != nil {
			return e
		}
		data <- user
		return nil
	}); e != nil {
		err <- e
	}
}

func (s *Service) handleLogin(c *my.Context, data my.ResultChan, err my.ErrorChan) {
	req := new(LoginRequest)
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
