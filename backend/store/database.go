package store

import (
	"context"
	"github.com/stephenafamo/bob"
)

type Store struct {
	Db *bob.DB
}

func NewDatabase(dsn string) (*Store, error) {
	if db, err := bob.Open("mysql", dsn); err != nil {
		return nil, err
	} else {
		return &Store{Db: &db}, nil
	}
}

//goland:noinspection GoUnhandledErrorResult
func (d Store) Transact(ctx context.Context, fn func(tx *bob.Tx) error) error {
	tx, err := d.Db.BeginTx(ctx, nil)
	if err != nil {
		return err
	}
	defer tx.Rollback()
	if err = fn(&tx); err != nil {
		tx.Rollback()
		return err
	}
	return tx.Commit()
}
