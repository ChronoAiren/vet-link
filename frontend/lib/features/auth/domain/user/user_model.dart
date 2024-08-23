import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@Freezed()
class User with _$User {
  factory User({
    required int id,
    required String email,
    required String givenName,
    required String familyName,
    required String userRole,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
