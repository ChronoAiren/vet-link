package clinicowners

import (
	my "backend/framework"
	. "backend/generated/models"
	"github.com/aarondl/opt/omit"
	"github.com/stephenafamo/bob"
)

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
	Name       string
	Location   string
	BusinessNo string
}
