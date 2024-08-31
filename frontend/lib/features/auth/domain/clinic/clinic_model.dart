import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend/features/auth/domain/user/user_model.dart';

part 'clinic_model.freezed.dart';
part 'clinic_model.g.dart';

@Freezed()
class Clinic with _$Clinic {
  factory Clinic({
    required int id,
    required String name,
    required String location,
    required String businessPermit,
    required User owner,
  }) = _Clinic;

  factory Clinic.fromJson(Map<String, dynamic> json) => _$ClinicFromJson(json);
}
