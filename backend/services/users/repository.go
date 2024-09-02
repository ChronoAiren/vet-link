package users

import (
	my "backend/framework"
	. "backend/generated/models"
	g "backend/globals"
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

func InsertUser(c *my.Context, exec bob.Executor, req InsertUserRequest) (*UserResponse, error) {
	params := req.GetInsertUserParams()
	if inserted, e := Users.Insert(c.GetContext(), exec, &UserSetter{
		GivenName:  omit.From(params.GivenName),
		FamilyName: omit.From(params.FamilyName),
		Email:      omit.From(params.Email),
		Password:   omit.From(params.Password),
		RoleID:     omit.From(params.RoleID),
	}); e != nil {
		return nil, e
	} else if retrieved, e := Users.Query(
		c.GetContext(), exec,
		SelectWhere.Users.Email.EQ(inserted.Email),
		PreloadUserRole(),
	).One(); e != nil {
		return nil, e
	} else {
		return &UserResponse{
			ID:         retrieved.ID,
			Email:      retrieved.Email,
			FamilyName: retrieved.FamilyName,
			GivenName:  retrieved.GivenName,
			Role:       retrieved.R.Role.Description,
		}, nil
	}
}

type InsertUserRequest interface {
	GetInsertUserParams() InsertUserParams
}

type InsertUserParams struct {
	Email      string `json:"email" param:"email" query:"email" form:"email"`
	Password   string `json:"password" param:"password" query:"password" form:"password"`
	FamilyName string `json:"familyName" param:"familyName" query:"familyName" form:"familyName"`
	GivenName  string `json:"givenName" param:"givenName" query:"givenName" form:"givenName"`
	RoleID     uint8  `json:"roleId,omitempty" param:"roleId" query:"roleId" form:"roleId"`
}

type CreateRequest struct {
	Email      string `json:"email" param:"email" query:"email" form:"email"`
	Password   string `json:"password" param:"password" query:"password" form:"password"`
	FamilyName string `json:"familyName" param:"familyName" query:"familyName" form:"familyName"`
	GivenName  string `json:"givenName" param:"givenName" query:"givenName" form:"givenName"`
	RoleID     uint8  `json:"roleId,omitempty" param:"roleId" query:"roleId" form:"roleId"`
}

func (r *CreateRequest) GetInsertUserParams() InsertUserParams {
	return InsertUserParams{
		Email:      r.Email,
		Password:   r.Password,
		FamilyName: r.FamilyName,
		GivenName:  r.GivenName,
		RoleID:     g.RoleDefault,
	}
}

type UserResponse struct {
	ID         uint32 `json:"id"`
	Email      string `json:"email"`
	FamilyName string `json:"familyName"`
	GivenName  string `json:"givenName"`
	Role       string `json:"role,omitempty"`
}

type LoginRequest struct {
	Email    string `json:"email" param:"email" query:"email" form:"email"`
	Password string `json:"password" param:"password" query:"password" form:"password"`
}
