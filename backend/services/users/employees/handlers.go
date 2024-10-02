package employees

import (
	"backend/framework"
	"backend/generated/models"
	g "backend/globals"
	"errors"
	"github.com/stephenafamo/bob"
)

func (s *Service) handleReadAll(c *framework.Context, data framework.ResultChan, err framework.ErrorChan) {
	type listClinicRequest struct {
		ClinicID uint32 `json:"clinicId" param:"clinicId" query:"clinicId" form:"clinicId"`
	}
	params := new(listClinicRequest)
	if e := c.Api.Bind(params); e != nil {
		err <- e
		return
	}
	employees, e := models.Employees.Query(
		c.GetContext(), s.Store.Db,
		models.SelectWhere.Employees.ClinicID.EQ(params.ClinicID),
		models.PreloadEmployeeUser(models.ThenLoadUserRole()),
	).All()
	if e != nil {
		err <- e
		return
	}
	var employeesDto []EmployeeResponse
	for _, employee := range employees {
		employeesDto = append(employeesDto, EmployeeResponse{
			ID:         employee.ID,
			ClinicID:   params.ClinicID,
			Email:      employee.R.User.Email,
			FamilyName: employee.R.User.FamilyName,
			GivenName:  employee.R.User.GivenName,
			Role:       employee.R.User.R.Role.Description,
		})
	}
	data <- employeesDto
}

func (s *Service) handleReadType(c *framework.Context, data framework.ResultChan, err framework.ErrorChan) {
	type listClinicRequest struct {
		ClinicID uint32 `json:"clinicId" param:"clinicId" query:"clinicId" form:"clinicId"`
		Type     string `json:"type" param:"type" query:"type" form:"type"`
		RoleID   uint8
	}
	params := new(listClinicRequest)
	if e := c.Api.Bind(params); e != nil {
		err <- e
		return
	}
	switch params.Type {
	case "receptionist":
		params.RoleID = g.RoleReceptionist
	case "veterinarian":
		params.RoleID = g.RoleVeterinarian
	default:
		err <- errors.New("invalid role")
	}
	employees, e := models.Employees.Query(
		c.GetContext(), s.Store.Db,
		models.SelectWhere.Employees.ClinicID.EQ(params.ClinicID),
		models.PreloadEmployeeUser(models.ThenLoadUserRole()),
		models.SelectJoins.Employees.InnerJoin.User(c.GetContext()),
		models.SelectWhere.Users.RoleID.EQ(params.RoleID),
	).All()
	if e != nil {
		err <- e
		return
	}
	var employeesDto []EmployeeResponse
	for _, employee := range employees {
		employeesDto = append(employeesDto, EmployeeResponse{
			ID:         employee.ID,
			ClinicID:   params.ClinicID,
			Email:      employee.R.User.Email,
			FamilyName: employee.R.User.FamilyName,
			GivenName:  employee.R.User.GivenName,
			Role:       employee.R.User.R.Role.Description,
		})
	}
	data <- employeesDto
}

func (s *Service) handleCreate(c *framework.Context, data framework.ResultChan, err framework.ErrorChan) {
	params := new(CreateRequest)
	if e := c.Api.Bind(params); e != nil {
		err <- e
		return
	} else if e := s.Store.Transact(c.GetContext(), func(tx *bob.Tx) error {
		switch params.Type {
		case "receptionist":
			params.RoleID = g.RoleReceptionist
		case "veterinarian":
			params.RoleID = g.RoleVeterinarian
		default:
			return errors.New("invalid role")
		}
		employee, e := InsertEmployee(c, tx, params)
		if e != nil {
			return e
		}
		data <- employee
		return nil
	}); e != nil {
		err <- e
		return
	}
}
