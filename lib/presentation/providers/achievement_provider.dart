import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/dio_client.dart';

class Achievement {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String category;
  final int creditReward;
  final bool unlocked;
  final DateTime? unlockedAt;

  Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.category,
    required this.creditReward,
    required this.unlocked,
    this.unlockedAt,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '🏆',
      category: json['category'] ?? 'general',
      creditReward: json['creditReward'] ?? json['credit_reward'] ?? 0,
      unlocked: json['unlocked'] ?? false,
      unlockedAt: json['unlockedAt'] != null || json['unlocked_at'] != null
          ? DateTime.tryParse(json['unlockedAt'] ?? json['unlocked_at'] ?? '')
          : null,
    );
  }
}

/// Kullanıcının başarımlarını çeken provider
final achievementsProvider = FutureProvider.autoDispose<List<Achievement>>((ref) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get(AppConstants.achievementsEndpoint);

  if (response.data is List) {
    return (response.data as List)
        .map((e) => Achievement.fromJson(e as Map<String, dynamic>))
        .toList();
  }
  return [];
});
