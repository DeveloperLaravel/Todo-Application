import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

@freezed
@HiveType(typeId: 1)
class AuthUser with _$AuthUser {
  const factory AuthUser({
    @HiveField(0) required int id,
    @HiveField(1) required String name,
    @HiveField(2) required String email,
    @HiveField(3) required String token,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}
