import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tek bir tahlil isteğinin durumu
enum RequestStatus {
  notRequested, // Henüz istenmedi
  inProgress,   // İstek yapıldı, süre işliyor
  ready,        // Sonuç hazır
}

class EvidenceRequest {
  final String evidenceId;
  final int totalDurationSeconds;
  final int remainingSeconds;
  final RequestStatus status;
  final DateTime? requestedAt;

  const EvidenceRequest({
    required this.evidenceId,
    required this.totalDurationSeconds,
    this.remainingSeconds = 0,
    this.status = RequestStatus.notRequested,
    this.requestedAt,
  });

  EvidenceRequest copyWith({
    int? remainingSeconds,
    RequestStatus? status,
    DateTime? requestedAt,
  }) {
    return EvidenceRequest(
      evidenceId: evidenceId,
      totalDurationSeconds: totalDurationSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      status: status ?? this.status,
      requestedAt: requestedAt ?? this.requestedAt,
    );
  }

  /// İlerleme yüzdesi (0.0 - 1.0)
  double get progress {
    if (status == RequestStatus.ready) return 1.0;
    if (status == RequestStatus.notRequested || totalDurationSeconds == 0) return 0.0;
    return 1.0 - (remainingSeconds / totalDurationSeconds);
  }

  /// Kalan süre formatı (MM:SS)
  String get remainingFormatted {
    final min = remainingSeconds ~/ 60;
    final sec = remainingSeconds % 60;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }
}

/// Tüm aktif tahlil isteklerini yöneten state
class EvidenceRequestState {
  final Map<String, EvidenceRequest> requests;

  const EvidenceRequestState({this.requests = const {}});

  EvidenceRequestState copyWith({Map<String, EvidenceRequest>? requests}) {
    return EvidenceRequestState(requests: requests ?? this.requests);
  }

  RequestStatus getStatus(String evidenceId) {
    return requests[evidenceId]?.status ?? RequestStatus.notRequested;
  }

  EvidenceRequest? getRequest(String evidenceId) => requests[evidenceId];

  bool isReady(String evidenceId) =>
      requests[evidenceId]?.status == RequestStatus.ready;

  bool isInProgress(String evidenceId) =>
      requests[evidenceId]?.status == RequestStatus.inProgress;
}

class EvidenceRequestNotifier extends StateNotifier<EvidenceRequestState> {
  Timer? _tickTimer;

  EvidenceRequestNotifier() : super(const EvidenceRequestState()) {
    _startTick();
  }

  /// Her saniye tüm aktif isteklerin geri sayımını güncelle
  void _startTick() {
    _tickTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      final updated = Map<String, EvidenceRequest>.from(state.requests);
      bool changed = false;

      for (final entry in updated.entries) {
        final req = entry.value;
        if (req.status == RequestStatus.inProgress && req.remainingSeconds > 0) {
          final newRemaining = req.remainingSeconds - 1;
          updated[entry.key] = req.copyWith(
            remainingSeconds: newRemaining,
            status: newRemaining <= 0 ? RequestStatus.ready : RequestStatus.inProgress,
          );
          changed = true;
        }
      }

      if (changed) {
        state = state.copyWith(requests: updated);
      }
    });
  }

  /// Tahlil/görüntüleme iste
  void requestEvidence(String evidenceId, int durationSeconds) {
    if (state.requests[evidenceId]?.status == RequestStatus.inProgress ||
        state.requests[evidenceId]?.status == RequestStatus.ready) {
      return; // Zaten istendi
    }

    final updated = Map<String, EvidenceRequest>.from(state.requests);
    updated[evidenceId] = EvidenceRequest(
      evidenceId: evidenceId,
      totalDurationSeconds: durationSeconds,
      remainingSeconds: durationSeconds,
      status: durationSeconds <= 0 ? RequestStatus.ready : RequestStatus.inProgress,
      requestedAt: DateTime.now(),
    );

    state = state.copyWith(requests: updated);
    debugPrint('[EvidenceRequest] İstendi: $evidenceId (${durationSeconds}s)');
  }

  /// Anında hazır yap (hile/debug)
  void completeImmediately(String evidenceId) {
    final req = state.requests[evidenceId];
    if (req == null) return;

    final updated = Map<String, EvidenceRequest>.from(state.requests);
    updated[evidenceId] = req.copyWith(
      remainingSeconds: 0,
      status: RequestStatus.ready,
    );
    state = state.copyWith(requests: updated);
  }

  /// Sıfırla (yeni vaka için)
  void reset() {
    state = const EvidenceRequestState();
  }

  @override
  void dispose() {
    _tickTimer?.cancel();
    super.dispose();
  }
}

final evidenceRequestProvider =
    StateNotifierProvider<EvidenceRequestNotifier, EvidenceRequestState>(
  (ref) => EvidenceRequestNotifier(),
);

/// Belirli bir evidence'ın istek durumunu izle
final evidenceRequestStatusProvider =
    Provider.family<RequestStatus, String>((ref, evidenceId) {
  return ref.watch(evidenceRequestProvider).getStatus(evidenceId);
});

/// Belirli bir evidence'ın istek detayını izle
final evidenceRequestDetailProvider =
    Provider.family<EvidenceRequest?, String>((ref, evidenceId) {
  return ref.watch(evidenceRequestProvider).getRequest(evidenceId);
});
