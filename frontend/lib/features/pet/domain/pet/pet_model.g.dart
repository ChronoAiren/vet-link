// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PetImpl _$$PetImplFromJson(Map<String, dynamic> json) => _$PetImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      gender: json['gender'] as String,
      birthdate: json['birthdate'] as String,
      age: (json['age'] as num).toInt(),
      breeds: Breed.fromJson(json['breeds'] as Map<String, dynamic>),
      species: Species.fromJson(json['species'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PetImplToJson(_$PetImpl instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gender': instance.gender,
      'birthdate': instance.birthdate,
      'age': instance.age,
      'breeds': instance.breeds,
      'species': instance.species,
    };
