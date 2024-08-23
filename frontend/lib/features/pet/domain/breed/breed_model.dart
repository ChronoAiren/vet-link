import 'package:freezed_annotation/freezed_annotation.dart';

part 'breed_model.freezed.dart';
part 'breed_model.g.dart';

@Freezed()
class Breed with _$Breed {
  factory Breed({
    required int id,
    required String name,
  }) = _Breed;

  factory Breed.fromJson(Map<String, dynamic> json) => _$BreedFromJson(json);
}
