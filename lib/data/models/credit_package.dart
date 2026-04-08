import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_package.freezed.dart';
part 'credit_package.g.dart';

@freezed
class CreditPackage with _$CreditPackage {
  const factory CreditPackage({
    @Default(0) int id,
    @Default('') String name,
    String? description,
    @Default(0) double priceTl,
    @Default(0) int baseCredits,
    @Default(0) int bonusCredits,
    @Default(0) int totalCredits,
    @Default(true) bool isActive,
    @Default(0) int sortOrder,
  }) = _CreditPackage;

  factory CreditPackage.fromJson(Map<String, dynamic> json) =>
      _$CreditPackageFromJson(json);
}
