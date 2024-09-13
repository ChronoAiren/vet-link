package clinicowners

import (
	"backend/framework"
	"backend/store"
)

type Service struct {
	Store     *store.Store
	Framework *framework.Framework
}

func New() *Service { return &Service{} }

func (s *Service) Inject(db *store.Store, f *framework.Framework) {
	s.Framework = f
	s.Store = db
}

func (s *Service) Serve(f *framework.Framework) {
	f.Mux().Get("/clinic-owners", s.handleReadAll)
	f.Mux().Get("/clinic-owners/:id", s.handleRead)
	f.Mux().Post("/clinic-owners", s.handleCreate)
	f.Mux().Post("/clinic-owners/:id/verify", s.handleVerify)
}
