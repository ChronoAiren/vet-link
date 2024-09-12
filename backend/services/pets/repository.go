package pets

import (
	my "backend/framework"
	"backend/generated/models"
	"backend/globals"
	"backend/services/users"
	"github.com/aarondl/opt/omit"
	"github.com/stephenafamo/bob"
	"github.com/stephenafamo/bob/dialect/mysql/dialect"
	"time"
)

func deletePet(c *my.Context, exec bob.Executor, id uint32) error {
	ctx := c.GetContext()
	if pet, e := models.FindPet(ctx, exec, id, models.ColumnNames.Pets.ID); e != nil {
		return e
	} else if e = pet.Delete(ctx, exec); e != nil {
		return e
	}
	return nil
}

func listBreeds(c *my.Context, exec bob.Executor, args ...bob.Mod[*dialect.SelectQuery]) (DTOs []BreedDTO, e error) {
	breeds, e := models.Breeds.Query(c.GetContext(), exec, args...).All()
	if e != nil {
		return nil, e
	}
	for _, breed := range breeds {
		DTOs = append(DTOs, BreedDTO{
			ID:    breed.ID,
			Breed: breed.Description,
		})
	}
	return DTOs, nil
}

func insertPet(c *my.Context, exec bob.Executor, req *CreateRequest) (*PetDTO, error) {
	if birthdate, e := time.Parse(time.DateOnly, req.Birthdate); e != nil {
		return nil, e
	} else if inserted, e := models.Pets.Insert(c.GetContext(), exec, &models.PetSetter{
		Name:      omit.From(req.Name),
		Gender:    omit.From(req.Gender),
		Birthdate: omit.From(req.Birthdate),
		BreedID:   omit.From(req.BreedID),
		OwnerID:   omit.From(req.OwnerID),
	}); e != nil {
		return nil, e
	} else if retrieved, e := models.Pets.Query(
		c.GetContext(), exec,
		models.SelectWhere.Pets.ID.EQ(inserted.ID),
		models.PreloadPetBreed(),
		models.PreloadPetOwnerUser(),
	).One(); e != nil {
		return nil, e
	} else {
		return &PetDTO{
			ID:        retrieved.ID,
			Name:      retrieved.Name,
			Age:       globals.CalculateAge(birthdate),
			Gender:    retrieved.Gender,
			Birthdate: retrieved.Birthdate,
			Breed: &BreedDTO{
				ID:    retrieved.R.Breed.ID,
				Breed: retrieved.R.Breed.Description,
			},
			Owner: &users.UserResponse{
				ID:         retrieved.R.OwnerUser.ID,
				Email:      retrieved.R.OwnerUser.Email,
				FamilyName: retrieved.R.OwnerUser.FamilyName,
				GivenName:  retrieved.R.OwnerUser.GivenName,
			},
		}, nil
	}
}

type PetDTO struct {
	ID        uint32              `json:"id"`
	Name      string              `json:"name"`
	Age       int                 `json:"age"`
	Gender    uint8               `json:"gender"`
	Birthdate string              `json:"birthdate"`
	Breed     *BreedDTO           `json:"breed,omitempty"`
	Owner     *users.UserResponse `json:"owner,omitempty"`
}

type CreateRequest struct {
	Name      string `json:"name" param:"name" query:"name" form:"name"`
	Gender    uint8  `json:"gender" param:"gender" query:"gender" form:"gender"`
	Birthdate string `json:"birthdate" param:"birthdate" query:"birthdate" form:"birthdate"`
	BreedID   uint32 `json:"breedId" param:"breedId" query:"breedId" form:"breedId"`
	OwnerID   uint32 `json:"ownerId" param:"ownerId" query:"ownerId" form:"ownerId"`
}

type deleteRequest struct {
	ID uint32 `json:"id" param:"id" query:"id" form:"id"`
}

type listBreedsRequest struct {
	SpeciesID uint8 `json:"species" param:"species" query:"species" form:"species"`
}

type updateRequest struct {
	ID        uint32  `json:"id,omitempty" param:"id" query:"id" form:"id"`
	Name      *string `json:"name,omitempty" param:"name" query:"name" form:"name"`
	Gender    *uint8  `json:"gender,omitempty" param:"gender" query:"gender" form:"gender"`
	Birthdate *string `json:"birthdate,omitempty" param:"birthdate" query:"birthdate" form:"birthdate"`
	BreedID   *uint32 `json:"breedId,omitempty" param:"breedId" query:"breedId" form:"breedId"`
}

type listRequest struct {
	OwnerID uint32 `json:"ownerId" param:"ownerId" query:"ownerId" form:"ownerId"`
}

type readRequest struct {
	ID uint32 `json:"id" param:"id" query:"id" form:"id"`
}
