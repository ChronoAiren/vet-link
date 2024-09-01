package clinicowners

import (
	my "backend/framework"
	. "backend/generated/models"
	"backend/services/users"
	"backend/store"
	"github.com/aarondl/opt/omit"
	"github.com/stephenafamo/bob"
	"github.com/stephenafamo/bob/dialect/mysql/dialect"
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

func CreateClinic(c my.Context, tx bob.Tx, user *User, req CreateClinicRequest) (clinic *Clinic, err error) {
	if clinic, err = Clinics.Insert(c.GetContext(), tx, &ClinicSetter{
		UserID:     omit.From(user.ID),
		Name:       omit.From(req.Name),
		Location:   omit.From(req.Location),
		BusinessNo: omit.From(req.BusinessNo),
	}); err != nil {
		return
	}
	err = clinic.Preload("User", user)
	return
}

type CreateClinicRequest struct {
	Name       string `json:"name" path:"name" query:"name" form:"name"`
	Location   string `json:"location" path:"location" query:"location" form:"location"`
	BusinessNo string `json:"businessNo" path:"businessNo" query:"businessNo" form:"businessNo"`
}

type ListClinicOwnersRequest struct {
	Verified *bool `json:"verified" path:"verified" query:"verified" form:"verified"`
}

type ClinicResponse struct {
	ID         uint32             `json:"id"`
	ClinicName string             `json:"clinicName"`
	Location   string             `json:"location"`
	BusinessNo string             `json:"businessNo"`
	User       users.UserResponse `json:"user"`
}
