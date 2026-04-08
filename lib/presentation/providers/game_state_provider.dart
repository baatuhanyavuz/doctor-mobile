import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/dio_client.dart';

/// Oyun içi ilerleme durumu
///
/// Tıbbi Veri açma, tahta durumu, sorgulama ilerlemesi gibi
/// verileri backend'e kaydedip geri yükler.
class GameState {
  final Set<String> unlockedEvidenceIds;
  final Set<String> viewedInterrogationIds;
  final Set<String> unlockedDeductionIds;
  final int progress;

  const GameState({
    this.unlockedEvidenceIds = const {},
    this.viewedInterrogationIds = const {},
    this.unlockedDeductionIds = const {},
    this.progress = 0,
  });

  Map<String, dynamic> toJson() => {
    'unlockedEvidenceIds': unlockedEvidenceIds.toList(),
    'viewedInterrogationIds': viewedInterrogationIds.toList(),
    'unlockedDeductionIds': unlockedDeductionIds.toList(),
  };

  factory GameState.fromJson(Map<String, dynamic> json) {
    return GameState(
      unlockedEvidenceIds: Set<String>.from(json['unlockedEvidenceIds'] ?? []),
      viewedInterrogationIds: Set<String>.from(json['viewedInterrogationIds'] ?? []),
      unlockedDeductionIds: Set<String>.from(json['unlockedDeductionIds'] ?? []),
    );
  }

  GameState copyWith({
    Set<String>? unlockedEvidenceIds,
    Set<String>? viewedInterrogationIds,
    Set<String>? unlockedDeductionIds,
    int? progress,
  }) {
    return GameState(
      unlockedEvidenceIds: unlockedEvidenceIds ?? this.unlockedEvidenceIds,
      viewedInterrogationIds: viewedInterrogationIds ?? this.viewedInterrogationIds,
      unlockedDeductionIds: unlockedDeductionIds ?? this.unlockedDeductionIds,
      progress: progress ?? this.progress,
    );
  }
}

/// Vaka bazlı oyun durumu yöneticisi
class GameStateNotifier extends FamilyNotifier<GameState, String> {
  @override
  GameState build(String caseId) {
    // Başlangıçta backend'den yükle
    _loadFromBackend(caseId);
    return const GameState();
  }

  Future<void> _loadFromBackend(String caseId) async {
    try {
      final dio = ref.read(dioProvider);
      final response = await dio.get('${AppConstants.gameStateLoadEndpoint}/$caseId');
      final data = response.data;

      final gsJson = data['gameState'];
      if (gsJson != null && gsJson is String && gsJson.isNotEmpty) {
        final parsed = jsonDecode(gsJson) as Map<String, dynamic>;
        state = GameState.fromJson(parsed).copyWith(
          progress: data['progress'] ?? 0,
        );
        debugPrint('[GameState] Loaded for $caseId: ${state.unlockedEvidenceIds.length} evidences');
      }
    } catch (e) {
      debugPrint('[GameState] Load failed for $caseId: $e');
    }
  }

  /// Tıbbi Veri aç
  void unlockEvidence(String evidenceId) {
    state = state.copyWith(
      unlockedEvidenceIds: {...state.unlockedEvidenceIds, evidenceId},
    );
    _saveToBackend();
  }

  /// Sorgulama görüldü
  void markInterrogationViewed(String interrogationId) {
    state = state.copyWith(
      viewedInterrogationIds: {...state.viewedInterrogationIds, interrogationId},
    );
    _saveToBackend();
  }

  /// Çıkarım açıldı
  void unlockDeduction(String deductionId) {
    state = state.copyWith(
      unlockedDeductionIds: {...state.unlockedDeductionIds, deductionId},
    );
    _saveToBackend();
  }

  /// İlerleme güncelle
  void updateProgress(int progress) {
    state = state.copyWith(progress: progress);
    _saveToBackend();
  }

  /// Backend'e kaydet (debounced — her değişiklikte hemen gönder)
  Future<void> _saveToBackend() async {
    try {
      final dio = ref.read(dioProvider);
      await dio.put(
        AppConstants.gameStateSaveEndpoint,
        data: {
          'caseId': arg,
          'gameState': jsonEncode(state.toJson()),
          'progress': _calculateProgress(),
        },
      );
    } catch (e) {
      debugPrint('[GameState] Save failed: $e');
    }
  }

  int _calculateProgress() {
    // Basit ilerleme hesabı: açılan tıbbi veri + sorgulama + çıkarım oranı
    final total = state.unlockedEvidenceIds.length +
        state.viewedInterrogationIds.length +
        state.unlockedDeductionIds.length;
    if (total == 0) return 0;
    // Maksimum 99 — 100 sadece vaka tamamlandığında
    return (total * 10).clamp(1, 99);
  }
}

/// Vaka bazlı game state provider
final gameStateProvider = NotifierProvider.family<GameStateNotifier, GameState, String>(
  GameStateNotifier.new,
);
