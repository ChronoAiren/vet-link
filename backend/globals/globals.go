package globals

import "time"

const (
	RoleDefault uint8 = 2 + iota
	RoleClinicOwner
	RoleUnverifiedClinicOwner
	RoleReceptionist
	RoleVeterinarian
)

const (
	TimeOnly = "03:04PM"
)

func Elvis[T any](b bool, trueVal T, falseVal T) T {
	if b {
		return trueVal
	} else {
		return falseVal
	}
}

// CalculateAge calculates the age based on the date of birth.
func CalculateAge(dob time.Time) int {
	today := time.Now()
	age := today.Year() - dob.Year()

	// Adjust for whether the birthday has occurred this year yet
	if today.YearDay() < dob.YearDay() {
		age--
	}

	return age
}
