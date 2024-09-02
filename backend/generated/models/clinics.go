// Code generated by BobGen mysql v0.28.1. DO NOT EDIT.
// This file is meant to be re-generated in place and/or deleted at any time.

package models

import (
	"context"
	"database/sql"
	"errors"
	"fmt"

	"github.com/aarondl/opt/omit"
	"github.com/stephenafamo/bob"
	"github.com/stephenafamo/bob/dialect/mysql"
	"github.com/stephenafamo/bob/dialect/mysql/dialect"
	"github.com/stephenafamo/bob/dialect/mysql/im"
	"github.com/stephenafamo/bob/dialect/mysql/sm"
	"github.com/stephenafamo/bob/dialect/mysql/um"
	"github.com/stephenafamo/bob/expr"
	"github.com/stephenafamo/bob/mods"
	"github.com/stephenafamo/bob/orm"
)

// Clinic is an object representing the database table.
type Clinic struct {
	ID         uint32 `db:"id,pk,autoincr" `
	UserID     uint32 `db:"user_id" `
	Name       string `db:"name" `
	Location   string `db:"location" `
	BusinessNo string `db:"business_no" `

	R clinicR `db:"-" `
}

// ClinicSlice is an alias for a slice of pointers to Clinic.
// This should almost always be used instead of []*Clinic.
type ClinicSlice []*Clinic

// Clinics contains methods to work with the clinics table
var Clinics = mysql.NewTablex[*Clinic, ClinicSlice, *ClinicSetter]("clinics", []string{"id"}, []string{"business_no"})

// ClinicsQuery is a query on the clinics table
type ClinicsQuery = *mysql.ViewQuery[*Clinic, ClinicSlice]

// ClinicsStmt is a prepared statment on clinics
type ClinicsStmt = bob.QueryStmt[*Clinic, ClinicSlice]

// clinicR is where relationships are stored.
type clinicR struct {
	User *User // fk_user_clinics_clinics_user_id
}

// ClinicSetter is used for insert/upsert/update operations
// All values are optional, and do not have to be set
// Generated columns are not included
type ClinicSetter struct {
	ID         omit.Val[uint32] `db:"id,pk,autoincr" `
	UserID     omit.Val[uint32] `db:"user_id" `
	Name       omit.Val[string] `db:"name" `
	Location   omit.Val[string] `db:"location" `
	BusinessNo omit.Val[string] `db:"business_no" `
}

func (s ClinicSetter) SetColumns() []string {
	vals := make([]string, 0, 5)
	if !s.ID.IsUnset() {
		vals = append(vals, "id")
	}

	if !s.UserID.IsUnset() {
		vals = append(vals, "user_id")
	}

	if !s.Name.IsUnset() {
		vals = append(vals, "name")
	}

	if !s.Location.IsUnset() {
		vals = append(vals, "location")
	}

	if !s.BusinessNo.IsUnset() {
		vals = append(vals, "business_no")
	}

	return vals
}

func (s ClinicSetter) Overwrite(t *Clinic) {
	if !s.ID.IsUnset() {
		t.ID, _ = s.ID.Get()
	}
	if !s.UserID.IsUnset() {
		t.UserID, _ = s.UserID.Get()
	}
	if !s.Name.IsUnset() {
		t.Name, _ = s.Name.Get()
	}
	if !s.Location.IsUnset() {
		t.Location, _ = s.Location.Get()
	}
	if !s.BusinessNo.IsUnset() {
		t.BusinessNo, _ = s.BusinessNo.Get()
	}
}

func (s ClinicSetter) InsertMod() bob.Mod[*dialect.InsertQuery] {
	vals := make([]bob.Expression, 5)
	if s.ID.IsUnset() {
		vals[0] = mysql.Raw("DEFAULT")
	} else {
		vals[0] = mysql.Arg(s.ID)
	}

	if s.UserID.IsUnset() {
		vals[1] = mysql.Raw("DEFAULT")
	} else {
		vals[1] = mysql.Arg(s.UserID)
	}

	if s.Name.IsUnset() {
		vals[2] = mysql.Raw("DEFAULT")
	} else {
		vals[2] = mysql.Arg(s.Name)
	}

	if s.Location.IsUnset() {
		vals[3] = mysql.Raw("DEFAULT")
	} else {
		vals[3] = mysql.Arg(s.Location)
	}

	if s.BusinessNo.IsUnset() {
		vals[4] = mysql.Raw("DEFAULT")
	} else {
		vals[4] = mysql.Arg(s.BusinessNo)
	}

	return im.Values(vals...)
}

func (s ClinicSetter) Apply(q *dialect.UpdateQuery) {
	um.Set(s.Expressions("clinics")...).Apply(q)
}

func (s ClinicSetter) Expressions(prefix ...string) []bob.Expression {
	exprs := make([]bob.Expression, 0, 5)

	if !s.ID.IsUnset() {
		exprs = append(exprs, expr.Join{Sep: " = ", Exprs: []bob.Expression{
			mysql.Quote(append(prefix, "id")...),
			mysql.Arg(s.ID),
		}})
	}

	if !s.UserID.IsUnset() {
		exprs = append(exprs, expr.Join{Sep: " = ", Exprs: []bob.Expression{
			mysql.Quote(append(prefix, "user_id")...),
			mysql.Arg(s.UserID),
		}})
	}

	if !s.Name.IsUnset() {
		exprs = append(exprs, expr.Join{Sep: " = ", Exprs: []bob.Expression{
			mysql.Quote(append(prefix, "name")...),
			mysql.Arg(s.Name),
		}})
	}

	if !s.Location.IsUnset() {
		exprs = append(exprs, expr.Join{Sep: " = ", Exprs: []bob.Expression{
			mysql.Quote(append(prefix, "location")...),
			mysql.Arg(s.Location),
		}})
	}

	if !s.BusinessNo.IsUnset() {
		exprs = append(exprs, expr.Join{Sep: " = ", Exprs: []bob.Expression{
			mysql.Quote(append(prefix, "business_no")...),
			mysql.Arg(s.BusinessNo),
		}})
	}

	return exprs
}

type clinicColumnNames struct {
	ID         string
	UserID     string
	Name       string
	Location   string
	BusinessNo string
}

var ClinicColumns = buildClinicColumns("clinics")

type clinicColumns struct {
	tableAlias string
	ID         mysql.Expression
	UserID     mysql.Expression
	Name       mysql.Expression
	Location   mysql.Expression
	BusinessNo mysql.Expression
}

func (c clinicColumns) Alias() string {
	return c.tableAlias
}

func (clinicColumns) AliasedAs(alias string) clinicColumns {
	return buildClinicColumns(alias)
}

func buildClinicColumns(alias string) clinicColumns {
	return clinicColumns{
		tableAlias: alias,
		ID:         mysql.Quote(alias, "id"),
		UserID:     mysql.Quote(alias, "user_id"),
		Name:       mysql.Quote(alias, "name"),
		Location:   mysql.Quote(alias, "location"),
		BusinessNo: mysql.Quote(alias, "business_no"),
	}
}

type clinicWhere[Q mysql.Filterable] struct {
	ID         mysql.WhereMod[Q, uint32]
	UserID     mysql.WhereMod[Q, uint32]
	Name       mysql.WhereMod[Q, string]
	Location   mysql.WhereMod[Q, string]
	BusinessNo mysql.WhereMod[Q, string]
}

func (clinicWhere[Q]) AliasedAs(alias string) clinicWhere[Q] {
	return buildClinicWhere[Q](buildClinicColumns(alias))
}

func buildClinicWhere[Q mysql.Filterable](cols clinicColumns) clinicWhere[Q] {
	return clinicWhere[Q]{
		ID:         mysql.Where[Q, uint32](cols.ID),
		UserID:     mysql.Where[Q, uint32](cols.UserID),
		Name:       mysql.Where[Q, string](cols.Name),
		Location:   mysql.Where[Q, string](cols.Location),
		BusinessNo: mysql.Where[Q, string](cols.BusinessNo),
	}
}

type clinicJoins[Q dialect.Joinable] struct {
	typ  string
	User func(context.Context) modAs[Q, userColumns]
}

func (j clinicJoins[Q]) aliasedAs(alias string) clinicJoins[Q] {
	return buildClinicJoins[Q](buildClinicColumns(alias), j.typ)
}

func buildClinicJoins[Q dialect.Joinable](cols clinicColumns, typ string) clinicJoins[Q] {
	return clinicJoins[Q]{
		typ:  typ,
		User: clinicsJoinUser[Q](cols, typ),
	}
}

// FindClinic retrieves a single record by primary key
// If cols is empty Find will return all columns.
func FindClinic(ctx context.Context, exec bob.Executor, IDPK uint32, cols ...string) (*Clinic, error) {
	if len(cols) == 0 {
		return Clinics.Query(
			ctx, exec,
			SelectWhere.Clinics.ID.EQ(IDPK),
		).One()
	}

	return Clinics.Query(
		ctx, exec,
		SelectWhere.Clinics.ID.EQ(IDPK),
		sm.Columns(Clinics.Columns().Only(cols...)),
	).One()
}

// ClinicExists checks the presence of a single record by primary key
func ClinicExists(ctx context.Context, exec bob.Executor, IDPK uint32) (bool, error) {
	return Clinics.Query(
		ctx, exec,
		SelectWhere.Clinics.ID.EQ(IDPK),
	).Exists()
}

// PrimaryKeyVals returns the primary key values of the Clinic
func (o *Clinic) PrimaryKeyVals() bob.Expression {
	return mysql.Arg(o.ID)
}

// Update uses an executor to update the Clinic
func (o *Clinic) Update(ctx context.Context, exec bob.Executor, s *ClinicSetter) error {
	return Clinics.Update(ctx, exec, s, o)
}

// Delete deletes a single Clinic record with an executor
func (o *Clinic) Delete(ctx context.Context, exec bob.Executor) error {
	return Clinics.Delete(ctx, exec, o)
}

// Reload refreshes the Clinic using the executor
func (o *Clinic) Reload(ctx context.Context, exec bob.Executor) error {
	o2, err := Clinics.Query(
		ctx, exec,
		SelectWhere.Clinics.ID.EQ(o.ID),
	).One()
	if err != nil {
		return err
	}
	o2.R = o.R
	*o = *o2

	return nil
}

func (o ClinicSlice) UpdateAll(ctx context.Context, exec bob.Executor, vals ClinicSetter) error {
	return Clinics.Update(ctx, exec, &vals, o...)
}

func (o ClinicSlice) DeleteAll(ctx context.Context, exec bob.Executor) error {
	return Clinics.Delete(ctx, exec, o...)
}

func (o ClinicSlice) ReloadAll(ctx context.Context, exec bob.Executor) error {
	var mods []bob.Mod[*dialect.SelectQuery]

	IDPK := make([]uint32, len(o))

	for i, o := range o {
		IDPK[i] = o.ID
	}

	mods = append(mods,
		SelectWhere.Clinics.ID.In(IDPK...),
	)

	o2, err := Clinics.Query(ctx, exec, mods...).All()
	if err != nil {
		return err
	}

	for _, old := range o {
		for _, new := range o2 {
			if new.ID != old.ID {
				continue
			}
			new.R = old.R
			*old = *new
			break
		}
	}

	return nil
}

func clinicsJoinUser[Q dialect.Joinable](from clinicColumns, typ string) func(context.Context) modAs[Q, userColumns] {
	return func(ctx context.Context) modAs[Q, userColumns] {
		return modAs[Q, userColumns]{
			c: UserColumns,
			f: func(to userColumns) bob.Mod[Q] {
				mods := make(mods.QueryMods[Q], 0, 1)

				{
					mods = append(mods, dialect.Join[Q](typ, Users.Name(ctx).As(to.Alias())).On(
						to.ID.EQ(from.UserID),
					))
				}

				return mods
			},
		}
	}
}

// User starts a query for related objects on users
func (o *Clinic) User(ctx context.Context, exec bob.Executor, mods ...bob.Mod[*dialect.SelectQuery]) UsersQuery {
	return Users.Query(ctx, exec, append(mods,
		sm.Where(UserColumns.ID.EQ(mysql.Arg(o.UserID))),
	)...)
}

func (os ClinicSlice) User(ctx context.Context, exec bob.Executor, mods ...bob.Mod[*dialect.SelectQuery]) UsersQuery {
	PKArgs := make([]bob.Expression, len(os))
	for i, o := range os {
		PKArgs[i] = mysql.ArgGroup(o.UserID)
	}

	return Users.Query(ctx, exec, append(mods,
		sm.Where(mysql.Group(UserColumns.ID).In(PKArgs...)),
	)...)
}

func (o *Clinic) Preload(name string, retrieved any) error {
	if o == nil {
		return nil
	}

	switch name {
	case "Owner":
		rel, ok := retrieved.(*User)
		if !ok {
			return fmt.Errorf("clinic cannot load %T as %q", retrieved, name)
		}

		o.R.User = rel

		if rel != nil {
			rel.R.Clinics = ClinicSlice{o}
		}
		return nil
	default:
		return fmt.Errorf("clinic has no relationship %q", name)
	}
}

func PreloadClinicUser(opts ...mysql.PreloadOption) mysql.Preloader {
	return mysql.Preload[*User, UserSlice](orm.Relationship{
		Name: "Owner",
		Sides: []orm.RelSide{
			{
				From: "clinics",
				To:   TableNames.Users,
				ToExpr: func(ctx context.Context) bob.Expression {
					return Users.Name(ctx)
				},
				FromColumns: []string{
					ColumnNames.Clinics.UserID,
				},
				ToColumns: []string{
					ColumnNames.Users.ID,
				},
			},
		},
	}, Users.Columns().Names(), opts...)
}

func ThenLoadClinicUser(queryMods ...bob.Mod[*dialect.SelectQuery]) mysql.Loader {
	return mysql.Loader(func(ctx context.Context, exec bob.Executor, retrieved any) error {
		loader, isLoader := retrieved.(interface {
			LoadClinicUser(context.Context, bob.Executor, ...bob.Mod[*dialect.SelectQuery]) error
		})
		if !isLoader {
			return fmt.Errorf("object %T cannot load ClinicUser", retrieved)
		}

		err := loader.LoadClinicUser(ctx, exec, queryMods...)

		// Don't cause an issue due to missing relationships
		if errors.Is(err, sql.ErrNoRows) {
			return nil
		}

		return err
	})
}

// LoadClinicUser loads the clinic's User into the .R struct
func (o *Clinic) LoadClinicUser(ctx context.Context, exec bob.Executor, mods ...bob.Mod[*dialect.SelectQuery]) error {
	if o == nil {
		return nil
	}

	// Reset the relationship
	o.R.User = nil

	related, err := o.User(ctx, exec, mods...).One()
	if err != nil {
		return err
	}

	related.R.Clinics = ClinicSlice{o}

	o.R.User = related
	return nil
}

// LoadClinicUser loads the clinic's User into the .R struct
func (os ClinicSlice) LoadClinicUser(ctx context.Context, exec bob.Executor, mods ...bob.Mod[*dialect.SelectQuery]) error {
	if len(os) == 0 {
		return nil
	}

	users, err := os.User(ctx, exec, mods...).All()
	if err != nil {
		return err
	}

	for _, o := range os {
		for _, rel := range users {
			if o.UserID != rel.ID {
				continue
			}

			rel.R.Clinics = append(rel.R.Clinics, o)

			o.R.User = rel
			break
		}
	}

	return nil
}

func attachClinicUser0(ctx context.Context, exec bob.Executor, count int, clinic0 *Clinic, user1 *User) (*Clinic, error) {
	setter := &ClinicSetter{
		UserID: omit.From(user1.ID),
	}

	err := Clinics.Update(ctx, exec, setter, clinic0)
	if err != nil {
		return nil, fmt.Errorf("attachClinicUser0: %w", err)
	}

	return clinic0, nil
}

func (clinic0 *Clinic) InsertUser(ctx context.Context, exec bob.Executor, related *UserSetter) error {
	user1, err := Users.Insert(ctx, exec, related)
	if err != nil {
		return fmt.Errorf("inserting related objects: %w", err)
	}

	_, err = attachClinicUser0(ctx, exec, 1, clinic0, user1)
	if err != nil {
		return err
	}

	clinic0.R.User = user1

	user1.R.Clinics = append(user1.R.Clinics, clinic0)

	return nil
}

func (clinic0 *Clinic) AttachUser(ctx context.Context, exec bob.Executor, user1 *User) error {
	var err error

	_, err = attachClinicUser0(ctx, exec, 1, clinic0, user1)
	if err != nil {
		return err
	}

	clinic0.R.User = user1

	user1.R.Clinics = append(user1.R.Clinics, clinic0)

	return nil
}
