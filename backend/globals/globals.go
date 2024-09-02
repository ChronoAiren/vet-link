package globals

const (
	RoleDefault uint8 = 2 + iota
	RoleClinicOwner
	RoleUnverifiedClinicOwner
)

func Elvis[T any](b bool, trueVal T, falseVal T) T {
	if b {
		return trueVal
	} else {
		return falseVal
	}
}
