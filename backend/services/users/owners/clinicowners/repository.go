package clinicowners

import (
	my "backend/framework"
	. "backend/generated/models"
	g "backend/globals"
	"backend/services/users/users"
	"backend/store"
	"errors"
	"github.com/aarondl/opt/omit"
	"github.com/stephenafamo/bob"
	"github.com/stephenafamo/bob/dialect/mysql/dialect"
	"log"
)

func ListClinics(c *my.Context, s *store.Store, args ...bob.Mod[*dialect.SelectQuery]) (ClinicSlice, error) {
	return Clinics.Query(c.GetContext(), s.Db,
		append(
			args,
			PreloadClinicUser(),
			SelectJoins.Clinics.LeftJoin.User(c.GetContext()),
		)...,
	).All()
}

func InsertClinic(c *my.Context, exec bob.Executor, req *CreateRequest) (clinic *ClinicResponse, err error) {
	if params, e := req.GetInsertClinicParams(); e != nil {
		return nil, e
	} else if inserted, e := Clinics.Insert(c.GetContext(), exec, &ClinicSetter{
		UserID:     omit.From(params.UserID),
		Name:       omit.From(params.Name),
		Location:   omit.From(params.Location),
		BusinessNo: omit.From(params.BusinessNo),
	}); e != nil {
		return nil, e
	} else if retrieved, e := Clinics.Query(c.GetContext(), exec,
		SelectWhere.Clinics.ID.EQ(inserted.ID),
		PreloadClinicUser(),
	).One(); e != nil {
		return nil, e
	} else {
		return &ClinicResponse{
			ID:         retrieved.ID,
			ClinicName: retrieved.Name,
			Location:   retrieved.Location,
			BusinessNo: retrieved.BusinessNo,
			Owner: users.UserResponse{
				ID:         retrieved.UserID,
				Email:      retrieved.R.User.Email,
				FamilyName: retrieved.R.User.FamilyName,
				GivenName:  retrieved.R.User.GivenName,
			},
		}, nil
	}
}

type CreateRequest struct {
	Name       string              `json:"name" param:"name" query:"name" form:"name"`
	Location   string              `json:"location" param:"location" query:"location" form:"location"`
	BusinessNo string              `json:"businessNo" param:"businessNo" query:"businessNo" form:"businessNo"`
	Email      string              `json:"email" param:"email" query:"email" form:"email"`
	Password   string              `json:"password" param:"password" query:"password" form:"password"`
	FamilyName string              `json:"familyName" param:"familyName" query:"familyName" form:"familyName"`
	GivenName  string              `json:"givenName" param:"givenName" query:"givenName" form:"givenName"`
	User       *users.UserResponse `json:"owner,omitempty" param:"owner" query:"owner" form:"owner"`
}

func (r *CreateRequest) GetInsertUserParams() users.InsertUserParams {
	return users.InsertUserParams{
		Email:      r.Email,
		Password:   r.Password,
		FamilyName: r.FamilyName,
		GivenName:  r.GivenName,
		RoleID:     g.RoleUnverifiedClinicOwner,
	}
}

type InsertClinicRequest interface {
	GetInsertClinicParams() (*InsertClinicParams, error)
}

type InsertClinicParams struct {
	UserID     uint32 `json:"userId" path:"userId" query:"userId" form:"userId"`
	Name       string `json:"name" path:"name" query:"name" form:"name"`
	Location   string `json:"location" path:"location" query:"location" form:"location"`
	BusinessNo string `json:"businessNo" path:"businessNo" query:"businessNo" form:"businessNo"`
}

func (r *CreateRequest) GetInsertClinicParams() (*InsertClinicParams, error) {
	if r.User == nil {
		log.Println(r.User)
		return nil, errors.New("user is required")
	}
	return &InsertClinicParams{
		UserID:     r.User.ID,
		Name:       r.Name,
		Location:   r.Location,
		BusinessNo: r.BusinessNo,
	}, nil
}

type ListClinicOwnersRequest struct {
	Verified *bool `json:"verified" param:"verified" query:"verified" form:"verified"`
}

type ClinicResponse struct {
	ID         uint32             `json:"id"`
	ClinicName string             `json:"clinicName"`
	Location   string             `json:"location"`
	BusinessNo string             `json:"businessNo"`
	Owner      users.UserResponse `json:"owner,omitempty"`
}

type VerifyRequest struct {
	Id uint32 `json:"id" param:"id" query:"id" form:"id"`
}
