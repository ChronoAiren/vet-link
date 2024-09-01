package users

import (
	my "backend/framework"
	. "backend/generated/models"
	"backend/store"
	"github.com/aarondl/opt/omit"
	"github.com/stephenafamo/bob"
	"github.com/stephenafamo/bob/dialect/mysql/dialect"
)

func ListUsers(c *my.Context, s *store.Store, args ...bob.Mod[*dialect.SelectQuery]) (UserSlice, error) {
	return Users.Query(c.GetContext(), s.Db,
		append(args, PreloadUserRole())...,
	).All()
}

func InsertUser(c *my.Context, s *store.Store, roleID uint8) (u *User, err error) {
	params := new(InsertUserRequest)
	if err = c.Api.Bind(params); err == nil {
		err = s.Transact(c.GetContext(), func(tx *bob.Tx) error {
			u, err = Users.Insert(c.GetContext(), tx, &UserSetter{
				GivenName:  omit.From(params.GivenName),
				FamilyName: omit.From(params.FamilyName),
				Email:      omit.From(params.Email),
				Password:   omit.From(params.Password),
				RoleID:     omit.From(roleID),
			})
			return err
		})
	}
	return
}

type InsertUserRequest struct {
	Email      string `json:"email" path:"email" query:"email" form:"email"`
	Password   string `json:"password" path:"password" query:"password" form:"password"`
	FamilyName string `json:"familyName" path:"familyName" query:"familyName" form:"familyName"`
	GivenName  string `json:"givenName" path:"givenName" query:"givenName" form:"givenName"`
	RoleID     uint8  `json:"roleId,omitempty" path:"roleId" query:"roleId" form:"roleId"`
}

type UserResponse struct {
	ID         uint32 `json:"id"`
	Email      string `json:"email"`
	FamilyName string `json:"familyName"`
	GivenName  string `json:"givenName"`
	Role       string `json:"role,omitempty"`
}

type LoginUserRequest struct {
	Email    string `json:"email" path:"email" query:"email" form:"email"`
	Password string `json:"password" path:"password" query:"password" form:"password"`
}
