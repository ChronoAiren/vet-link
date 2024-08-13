import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_model.freezed.dart';
part 'clinic_model.g.dart';

@Freezed()
class Clinic with _$Clinic {
  factory Clinic({
    required int id,
    required String name,
    required String location,
    required String businessPermit,
  }) = _Clinic;

  factory Clinic.fromJson(Map<String, dynamic> json) => _$ClinicFromJson(json);
}
