// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Pet _$PetFromJson(Map<String, dynamic> json) {
  return _Pet.fromJson(json);
}

/// @nodoc
mixin _$Pet {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get birthdate => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  Breed get breed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PetCopyWith<Pet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetCopyWith<$Res> {
  factory $PetCopyWith(Pet value, $Res Function(Pet) then) =
      _$PetCopyWithImpl<$Res, Pet>;
  @useResult
  $Res call(
      {int id,
      String name,
      String gender,
      String birthdate,
      int age,
      Breed breed});

  $BreedCopyWith<$Res> get breed;
}

/// @nodoc
class _$PetCopyWithImpl<$Res, $Val extends Pet> implements $PetCopyWith<$Res> {
  _$PetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? gender = null,
    Object? birthdate = null,
    Object? age = null,
    Object? breed = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      birthdate: null == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      breed: null == breed
          ? _value.breed
          : breed // ignore: cast_nullable_to_non_nullable
              as Breed,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BreedCopyWith<$Res> get breed {
    return $BreedCopyWith<$Res>(_value.breed, (value) {
      return _then(_value.copyWith(breed: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PetImplCopyWith<$Res> implements $PetCopyWith<$Res> {
  factory _$$PetImplCopyWith(_$PetImpl value, $Res Function(_$PetImpl) then) =
      __$$PetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String gender,
      String birthdate,
      int age,
      Breed breed});

  @override
  $BreedCopyWith<$Res> get breed;
}

/// @nodoc
class __$$PetImplCopyWithImpl<$Res> extends _$PetCopyWithImpl<$Res, _$PetImpl>
    implements _$$PetImplCopyWith<$Res> {
  __$$PetImplCopyWithImpl(_$PetImpl _value, $Res Function(_$PetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? gender = null,
    Object? birthdate = null,
    Object? age = null,
    Object? breed = null,
  }) {
    return _then(_$PetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      birthdate: null == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      breed: null == breed
          ? _value.breed
          : breed // ignore: cast_nullable_to_non_nullable
              as Breed,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PetImpl implements _Pet {
  _$PetImpl(
      {required this.id,
      required this.name,
      required this.gender,
      required this.birthdate,
      required this.age,
      required this.breed});

  factory _$PetImpl.fromJson(Map<String, dynamic> json) =>
      _$$PetImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String gender;
  @override
  final String birthdate;
  @override
  final int age;
  @override
  final Breed breed;

  @override
  String toString() {
    return 'Pet(id: $id, name: $name, gender: $gender, birthdate: $birthdate, age: $age, breed: $breed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.breed, breed) || other.breed == breed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, gender, birthdate, age, breed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PetImplCopyWith<_$PetImpl> get copyWith =>
      __$$PetImplCopyWithImpl<_$PetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PetImplToJson(
      this,
    );
  }
}

abstract class _Pet implements Pet {
  factory _Pet(
      {required final int id,
      required final String name,
      required final String gender,
      required final String birthdate,
      required final int age,
      required final Breed breed}) = _$PetImpl;

  factory _Pet.fromJson(Map<String, dynamic> json) = _$PetImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get gender;
  @override
  String get birthdate;
  @override
  int get age;
  @override
  Breed get breed;
  @override
  @JsonKey(ignore: true)
  _$$PetImplCopyWith<_$PetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
