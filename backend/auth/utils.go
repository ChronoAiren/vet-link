package auth

import "backend/mysqlc"

func toClinicDTO(raw interface{}) *ClinicDTO {
	switch row := raw.(type) {
	case mysqlc.GetClinicRow:
		return &ClinicDTO{
			ID:         row.ID,
			Name:       row.Name,
			Location:   row.Location,
			BusinessNo: row.BusinessNo,
			User:       *toUserDTO(row.User),
		}
	case mysqlc.ListClinicsRow:
		return &ClinicDTO{
			ID:         row.ID,
			Name:       row.Name,
			Location:   row.Location,
			BusinessNo: row.BusinessNo,
			User:       *toUserDTO(row.User),
		}
	default: // Handle unexpected types if necessary
		return nil
	}
}

func toUserDTO(row interface{}) *UserDTO {
	switch row := row.(type) {
	case mysqlc.User:
		return &UserDTO{
			ID:         row.ID,
			GivenName:  row.GivenName,
			FamilyName: row.FamilyName,
			Email:      row.Email,
			Role:       nil,
		}
	case mysqlc.GetUserByEmailRow:
		return &UserDTO{
			ID:         row.ID,
			GivenName:  row.GivenName,
			FamilyName: row.FamilyName,
			Email:      row.Email,
			Role:       &row.UserRole,
		}
	case mysqlc.GetUserByIDRow:
		return &UserDTO{
			ID:         row.ID,
			GivenName:  row.GivenName,
			FamilyName: row.FamilyName,
			Email:      row.Email,
			Role:       &row.UserRole,
		}
	case mysqlc.ListUsersRow:
		return &UserDTO{
			ID:         row.ID,
			GivenName:  row.GivenName,
			FamilyName: row.FamilyName,
			Email:      row.Email,
			Role:       &row.UserRole,
		}
	default: // Handle unexpected types if necessary
		return nil
	}
}
