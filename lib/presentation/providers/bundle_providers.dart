import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/dio_client.dart';
import '../../data/models/case_bundle.dart';

/// Aktif kampanyaları backend'den çeker
final activeBundlesProvider = FutureProvider.autoDispose<List<CaseBundle>>((ref) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get(AppConstants.caseBundlesEndpoint);

  if (response.data is List) {
    return (response.data as List)
        .map((e) => CaseBundle.fromJson(e as Map<String, dynamic>))
        .toList();
  }
  return [];
});
