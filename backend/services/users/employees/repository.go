package employees

import (
	my "backend/framework"
	"backend/generated/models"
	"backend/services/users"
	"github.com/aarondl/opt/omit"
	"github.com/stephenafamo/bob"
)

func InsertUser(c *my.Context, exec bob.Executor, req users.InsertUserRequest) (*users.UserResponse, error) {
	params := req.GetInsertUserParams()
	if inserted, e := models.Users.Insert(c.GetContext(), exec, &models.UserSetter{
		GivenName:  omit.From(params.GivenName),
		FamilyName: omit.From(params.FamilyName),
		Email:      omit.From(params.Email),
		Password:   omit.From(params.Password),
		RoleID:     omit.From(params.RoleID),
	}); e != nil {
		return nil, e
	} else if retrieved, e := models.Users.Query(
		c.GetContext(), exec,
		models.SelectWhere.Users.Email.EQ(inserted.Email),
		models.PreloadUserRole(),
	).One(); e != nil {
		return nil, e
	} else {
		return &users.UserResponse{
			ID:         retrieved.ID,
			Email:      retrieved.Email,
			FamilyName: retrieved.FamilyName,
			GivenName:  retrieved.GivenName,
			Role:       retrieved.R.Role.Description,
		}, nil
	}
}

func InsertEmployee(c *my.Context, exec bob.Executor, req *CreateRequest) (*EmployeeResponse, error) {
	params := req.GetInsertEmployeeParams()
	if clinic, e := models.Clinics.Query(
		c.GetContext(), exec,
		models.SelectWhere.Clinics.ID.EQ(params.ClinicID),
	).One(); e != nil {
		return nil, e
	} else if user, e := users.InsertUser(c, exec, req); e != nil {
		return nil, e
	} else if _, e := models.Employees.Insert(c.GetContext(), exec, &models.EmployeeSetter{
		UserID:   omit.From(user.ID),
		ClinicID: omit.From(clinic.ID),
	}); e != nil {
		return nil, e
	} else {
		return &EmployeeResponse{
			ID:         user.ID,
			ClinicID:   clinic.ID,
			Email:      user.Email,
			FamilyName: user.FamilyName,
			GivenName:  user.GivenName,
			Role:       user.Role,
		}, nil
	}
}

type EmployeeResponse struct {
	ID         uint32 `json:"id"`
	ClinicID   uint32 `json:"clinicId"`
	Email      string `json:"email"`
	FamilyName string `json:"familyName"`
	GivenName  string `json:"givenName"`
	Role       string `json:"role,omitempty"`
}

type CreateRequest struct {
	Type       string `json:"type" param:"type" query:"type" form:"type"`
	ClinicID   uint32 `json:"id" param:"id" query:"id" form:"id"`
	Email      string `json:"email" param:"email" query:"email" form:"email"`
	Password   string `json:"password" param:"password" query:"password" form:"password"`
	FamilyName string `json:"familyName" param:"familyName" query:"familyName" form:"familyName"`
	GivenName  string `json:"givenName" param:"givenName" query:"givenName" form:"givenName"`
	UserID     uint32 `json:"userId,omitempty" param:"userId" query:"userId" form:"userId"`
	RoleID     uint8  `json:"roleId,omitempty" param:"roleId" query:"roleId" form:"roleId"`
}

func (r *CreateRequest) GetInsertUserParams() users.InsertUserParams {
	return users.InsertUserParams{
		Email:      r.Email,
		Password:   r.Password,
		FamilyName: r.FamilyName,
		GivenName:  r.GivenName,
		RoleID:     r.RoleID,
	}
}

type InsertEmployeeParams struct {
	UserID   uint32 `json:"userId" param:"userId" query:"userId" form:"userId"`
	ClinicID uint32 `json:"clinicId" param:"clinicId" query:"clinicId" form:"clinicId"`
}

func (r *CreateRequest) GetInsertEmployeeParams() InsertEmployeeParams {
	return InsertEmployeeParams{
		UserID:   r.UserID,
		ClinicID: r.ClinicID,
	}
}
