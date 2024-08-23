// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClinicImpl _$$ClinicImplFromJson(Map<String, dynamic> json) => _$ClinicImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      location: json['location'] as String,
      businessPermit: json['businessPermit'] as String,
    );

Map<String, dynamic> _$$ClinicImplToJson(_$ClinicImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'businessPermit': instance.businessPermit,
    };
