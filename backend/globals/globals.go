package globals

import (
	"time"
)

const (
	RoleDefault uint8 = 2 + iota
	RoleClinicOwner
	RoleUnverifiedClinicOwner
	RoleReceptionist
	RoleVeterinarian
)

const (
	reset   = "\033[0m"
	Red     = "\033[31m"
	Green   = "\033[32m"
	Yellow  = "\033[33m"
	Blue    = "\033[34m"
	Magenta = "\033[35m"
	Cyan    = "\033[36m"
	Gray    = "\033[37m"
	White   = "\033[97m"
)

func Colorize(color string, text string) string {
	return color + text + reset
}

const (
	TimeOnly = "03:04PM"
)

func Elvis[T any](b any, tVal T, fVal T) T {
	switch b.(type) {
	case bool:
		return elvis(b.(bool), tVal, fVal)
	case uint8:
		return elvis(b.(uint8) != 0, tVal, fVal)
	case uint32:
		return elvis(b.(uint32) != 0, tVal, fVal)
	case uint64:
		return elvis(b.(uint64) != 0, tVal, fVal)
	case int:
		return elvis(b.(int) != 0, tVal, fVal)
	case int8:
		return elvis(b.(int8) != 0, tVal, fVal)
	case int32:
		return elvis(b.(int32) != 0, tVal, fVal)
	case int64:
		return elvis(b.(int64) != 0, tVal, fVal)
	default:
		panic("invalid type")
	}
}

func elvis[T any](b bool, tVal T, fVal T) T {
	if b {
		return tVal
	}
	return fVal
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
