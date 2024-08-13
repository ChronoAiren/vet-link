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
      breeds: (json['breeds'] as List<dynamic>)
          .map((e) => Breed.fromJson(e as Map<String, dynamic>))
          .toList(),
      species: Species.fromJson(json['species'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PetImplToJson(_$PetImpl instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gender': instance.gender,
      'birthdate': instance.birthdate,
      'breeds': instance.breeds,
      'species': instance.species,
    };
