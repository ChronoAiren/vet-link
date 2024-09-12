package pets

import (
	"backend/framework"
	"backend/generated/models"
	"backend/globals"
	"github.com/aarondl/opt/omit"
	"github.com/stephenafamo/bob"
	"time"
)

func (s *Service) handleList(c *framework.Context, data framework.ResultChan, err framework.ErrorChan) {
	params := new(listRequest)
	if e := c.Api.Bind(params); e != nil {
		err <- e
	} else if pets, e := models.Pets.Query(
		c.GetContext(), s.Store.Db,
		models.SelectWhere.Pets.OwnerID.EQ(params.OwnerID),
		models.PreloadPetBreed(),
	).All(); e != nil {
		err <- e
	} else {
		var DTOs []PetDTO
		for _, pet := range pets {
			birthdate, _ := time.Parse(time.DateOnly, pet.Birthdate)
			DTOs = append(DTOs, PetDTO{
				ID:        pet.ID,
				Name:      pet.Name,
				Age:       globals.CalculateAge(birthdate),
				Gender:    pet.Gender,
				Birthdate: pet.Birthdate,
				Breed: &BreedDTO{
					ID:    pet.R.Breed.ID,
					Breed: pet.R.Breed.Description,
				},
			})
		}
		data <- DTOs
	}
}

func (s *Service) handleRead(c *framework.Context, data framework.ResultChan, err framework.ErrorChan) {
	params := new(readRequest)
	if e := c.Api.Bind(params); e != nil {
		err <- e
	} else if pet, e := models.Pets.Query(
		c.GetContext(), s.Store.Db,
		models.SelectWhere.Pets.ID.EQ(params.ID),
		models.PreloadPetBreed(),
	).One(); e != nil {
		err <- e
	} else if birthdate, e := time.Parse(time.DateOnly, pet.Birthdate); e != nil {
		err <- e
	} else {
		data <- PetDTO{
			ID:        pet.ID,
			Name:      pet.Name,
			Age:       globals.CalculateAge(birthdate),
			Gender:    pet.Gender,
			Birthdate: pet.Birthdate,
			Breed: &BreedDTO{
				ID:    pet.R.Breed.ID,
				Breed: pet.R.Breed.Description,
			},
		}
	}
}

func (s *Service) handleUpdate(c *framework.Context, data framework.ResultChan, err framework.ErrorChan) {
	params := new(updateRequest)
	if e := c.Api.Bind(params); e != nil {
		err <- e
	} else if e := s.Store.Transact(c.GetContext(), func(tx *bob.Tx) error {
		pet, e := models.FindPet(c.GetContext(), tx, params.ID)
		if e != nil {
			return e
		}
		e = pet.Update(c.GetContext(), tx, &models.PetSetter{
			Name:      omit.FromPtr(params.Name),
			Gender:    omit.FromPtr(params.Gender),
			Birthdate: omit.FromPtr(params.Birthdate),
			BreedID:   omit.FromPtr(params.BreedID),
		})
		data <- "Successfully updated pet"
		return nil
	}); e != nil {
		err <- e
	}
}

func (s *Service) handleDelete(c *framework.Context, data framework.ResultChan, err framework.ErrorChan) {
	params := new(deleteRequest)
	if e := c.Api.Bind(params); e != nil {
		err <- e
	} else if e := s.Store.Transact(c.GetContext(), func(tx *bob.Tx) error {
		if e = deletePet(c, tx, params.ID); e != nil {
			return e
		}
		data <- "Successfully deleted pet"
		return nil
	}); e != nil {
		err <- e
	}
}

func (s *Service) handleCreate(c *framework.Context, data framework.ResultChan, err framework.ErrorChan) {
	params := new(CreateRequest)
	if e := c.Api.Bind(params); e != nil {
		err <- e
	} else if e = s.Store.Transact(c.GetContext(), func(tx *bob.Tx) error {
		pet, e := insertPet(c, tx, params)
		if e != nil {
			return e
		}
		data <- pet
		return nil
	}); e != nil {
		err <- e
	}
}

func (s *Service) handleReadAllBreeds(c *framework.Context, data framework.ResultChan, err framework.ErrorChan) {
	params := new(listBreedsRequest)
	if e := c.Api.Bind(params); e != nil {
		err <- e
	} else if e = s.Store.Transact(c.GetContext(), func(tx *bob.Tx) error {
		breeds, e := listBreeds(c, tx, models.SelectWhere.Breeds.SpeciesID.EQ(params.SpeciesID))
		if e != nil {
			return e
		}
		data <- breeds
		return nil
	}); e != nil {
		err <- e
	}
}

type BreedDTO struct {
	ID    uint32 `json:"id"`
	Breed string `json:"breed"`
}
