package petowners

import (
	"backend/framework"
	"backend/store"
)

type Service struct {
	Store *store.Store
	Api   *framework.Framework
}

func New() *Service { return &Service{} }

func (s *Service) Inject(db *store.Store, api *framework.Framework) {
	s.Store = db
	s.Api = api
}

func (s *Service) Serve(f *framework.Framework) {
	s.Api.Api.GET("/pet-owners", s.listPetOwners)
	s.Api.Api.POST("/pet-owners", s.createPetOwner)
}
