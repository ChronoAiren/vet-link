// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['ID'] as num).toInt(),
      email: json['Email'] as String,
      givenName: json['GivenName'] as String,
      familyName: json['FamilyName'] as String,
      userRole: json['Role'] as String,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'Email': instance.email,
      'GivenName': instance.givenName,
      'FamilyName': instance.familyName,
      'Role': instance.userRole,
    };
