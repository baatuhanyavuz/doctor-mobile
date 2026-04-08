import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// Kullanıcı entity'si
///
/// Domain katmanındaki saf iş nesnesi.
/// Dış bağımlılıklardan (JSON, API) bağımsızdır.
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String fullName,
    @Default(1) int level,
    @Default(0) int totalXp,
    String? photoUrl,
  }) = _User;
}
