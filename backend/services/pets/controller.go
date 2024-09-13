package pets

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
	f.Mux().Get("/pets", s.handleList)
	f.Mux().Get("/pets/:id", s.handleRead)
	f.Mux().Post("/pets", s.handleCreate)
	f.Mux().Delete("/pets/:id", s.handleDelete)
	f.Mux().Patch("/pets/:id", s.handleUpdate)
	f.Mux().Get("/pets/breeds", s.handleReadAllBreeds)
}
