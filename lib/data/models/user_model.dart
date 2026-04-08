import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// API'den gelen kullanıcı verisi modeli
///
/// JSON serileştirme desteği ile domain User entity'sine dönüştürülebilir.
/// .NET API'nin döndüğü JSON yapısına uygun field isimleri.
@freezed
class UserModel with _$UserModel {
  const UserModel._(); // Custom method'lar için

  const factory UserModel({
    @Default('') String id,
    @Default('') String email,
    @Default('') String fullName,
    @Default(1) int level,
    @Default(0) int totalXp,
    String? photoUrl,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  /// Domain entity'sine dönüştür
  User toDomain() {
    return User(
      id: id,
      email: email,
      fullName: fullName,
      level: level,
      totalXp: totalXp,
      photoUrl: photoUrl,
    );
  }
}
