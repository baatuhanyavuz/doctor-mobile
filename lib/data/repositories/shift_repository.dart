import 'dart:convert';
import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';
import '../models/shift.dart';

class ShiftRepository {
  final Dio _dio;

  ShiftRepository(this._dio);

  /// Nöbet başlat
  Future<ShiftStatus> startShift({
    required String shiftType,
    required String intensity,
    required int durationHours,
  }) async {
    final response = await _dio.post(
      AppConstants.shiftStartEndpoint,
      data: {
        'shiftType': shiftType,
        'intensity': intensity,
        'durationHours': durationHours,
      },
    );
    return ShiftStatus.fromJson(response.data);
  }

  /// Aktif nöbet durumunu sorgula
  Future<ShiftStatus?> getActiveShift() async {
    final response = await _dio.get(AppConstants.shiftStatusEndpoint);
    if (response.data is Map && response.data['active'] == false) {
      return null;
    }
    return ShiftStatus.fromJson(response.data);
  }

  /// Nöbet vakasına cevap ver
  Future<ShiftStatus> respondToCase({
    required String shiftCaseId,
    required List<Map<String, String>> responses,
  }) async {
    final response = await _dio.post(
      AppConstants.shiftRespondEndpoint,
      data: {
        'shiftCaseId': shiftCaseId,
        'responseData': jsonEncode(responses),
      },
    );
    return ShiftStatus.fromJson(response.data);
  }

  /// Nöbeti erken bitir
  Future<ShiftStatus> completeShift() async {
    final response = await _dio.post(AppConstants.shiftCompleteEndpoint);
    return ShiftStatus.fromJson(response.data);
  }

  /// Nöbeti iptal et
  Future<void> cancelShift() async {
    await _dio.delete(AppConstants.shiftCancelEndpoint);
  }

  /// Nöbet geçmişi
  Future<List<ShiftHistoryItem>> getHistory() async {
    final response = await _dio.get(AppConstants.shiftHistoryEndpoint);
    return (response.data as List)
        .map((e) => ShiftHistoryItem.fromJson(e))
        .toList();
  }
}
