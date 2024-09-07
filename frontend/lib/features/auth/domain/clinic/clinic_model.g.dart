// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClinicImpl _$$ClinicImplFromJson(Map<String, dynamic> json) => _$ClinicImpl(
      id: (json['id'] as num).toInt(),
      name: json['clinicName'] as String,
      location: json['location'] as String,
      businessPermit: json['businessNo'] as String,
      owner: User.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ClinicImplToJson(_$ClinicImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clinicName': instance.name,
      'location': instance.location,
      'businessNo': instance.businessPermit,
      'owner': instance.owner,
    };
