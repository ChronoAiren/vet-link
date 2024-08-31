package framework

type Binder struct {
	Context Context
}

type Request[T any] interface {
	BindFrom(c Context) error
}
