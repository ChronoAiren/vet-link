package users

import (
	my "backend/framework"
	. "backend/generated/models"
	"backend/store"
	"github.com/aarondl/opt/omit"
	"github.com/stephenafamo/bob"
	"github.com/stephenafamo/bob/dialect/mysql/dialect"
)

func ListUsers(c *my.Context, db *bob.DB, args ...bob.Mod[*dialect.SelectQuery]) ([]UserResponse, error) {
	if users, err := Users.Query(c.GetContext(), db, PreloadUserRole()).All(); err != nil {
		return nil, err
	} else {
		var userDTOs []UserResponse
		for _, user := range users {
			userDTOs = append(userDTOs, UserResponse{
				Email:      user.Email,
				FamilyName: user.FamilyName,
				GivenName:  user.GivenName,
				Role:       user.R.Role.Description,
			})
		}
		return userDTOs, nil
	}
}

func InsertUser(echo *my.Context, s *store.Store, roleID uint8) (u *User, err error) {
	params := new(InsertUserRequest)
	if err = echo.Api.Bind(params); err != nil {
		return
	}
	params.RoleID = roleID
	err = s.Transact(echo.GetContext(), func(tx *bob.Tx) error {
		u, err = Users.Insert(echo.GetContext(), tx, &UserSetter{
			GivenName:  omit.From(params.GivenName),
			FamilyName: omit.From(params.FamilyName),
			Email:      omit.From(params.Email),
			Password:   omit.From(params.Password),
			RoleID:     omit.From(params.RoleID),
		})
		return err
	})
	return
}

type InsertUserRequest struct {
	Email      string `json:"Email" path:"Email" query:"Email" form:"Email"`
	Password   string `json:"Password" path:"Password" query:"Password" form:"Password"`
	FamilyName string `json:"FamilyName" path:"FamilyName" query:"FamilyName" form:"FamilyName"`
	GivenName  string `json:"GivenName" path:"GivenName" query:"GivenName" form:"GivenName"`
	RoleID     uint8  `json:"RoleID,omitempty" path:"RoleID" query:"RoleID" form:"RoleID"`
}

type UserResponse struct {
	Email      string
	FamilyName string
	GivenName  string
	Role       string
}
