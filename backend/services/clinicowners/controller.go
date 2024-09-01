package clinicowners

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
	s.Api.Api.GET("/clinic-owners", s.listClinicOwners)
	s.Api.Api.POST("/clinic-owners", s.createClinicOwner)
	//s.Api.POST("/clinic-owners/:id/verify", s.verifyClinicOwner)
}
