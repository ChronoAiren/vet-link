import 'package:freezed_annotation/freezed_annotation.dart';

part 'species_model.freezed.dart';
part 'species_model.g.dart';

@Freezed()
class Species with _$Species {
  factory Species({
    required int id,
    required String name,
  }) = _Species;

  factory Species.fromJson(Map<String, dynamic> json) =>
      _$SpeciesFromJson(json);
}
