package petowners

import (
	my "backend/framework"
	"backend/services/users/users"
	"github.com/stephenafamo/bob"
)

func (s *Service) handleReadAll(c *my.Context, data my.ResultChan, err my.ErrorChan) {
	if userSlice, e := users.ListUsers(c, s.Store); e != nil {
		err <- e
	} else {
		var dtoSlice []users.UserResponse
		for _, user := range userSlice {
			dtoSlice = append(dtoSlice, users.UserResponse{
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
	params := new(users.CreateRequest)
	if e := c.Api.Bind(params); e != nil {
		err <- e
	} else if e = s.Store.Transact(c.GetContext(), func(tx *bob.Tx) error {
		user, e := users.InsertUser(c, tx, params)
		if e != nil {
			return e
		}
		data <- user
		return nil
	}); e != nil {
		err <- e
	}
}
