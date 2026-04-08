// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreditPackageImpl _$$CreditPackageImplFromJson(Map<String, dynamic> json) =>
    _$CreditPackageImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      priceTl: (json['priceTl'] as num?)?.toDouble() ?? 0,
      baseCredits: (json['baseCredits'] as num?)?.toInt() ?? 0,
      bonusCredits: (json['bonusCredits'] as num?)?.toInt() ?? 0,
      totalCredits: (json['totalCredits'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$CreditPackageImplToJson(_$CreditPackageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'priceTl': instance.priceTl,
      'baseCredits': instance.baseCredits,
      'bonusCredits': instance.bonusCredits,
      'totalCredits': instance.totalCredits,
      'isActive': instance.isActive,
      'sortOrder': instance.sortOrder,
    };
