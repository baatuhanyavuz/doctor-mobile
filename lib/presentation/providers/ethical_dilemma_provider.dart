import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/ethical_dilemma.dart';

/// Malpraktis kayıt türü
enum MalpracticeType {
  patientLost,            // Hasta kaybı
  wrongTreatment,         // Yanlış tedavi (tehlikeli tedavi)
  unnecessaryTest,        // Gereksiz pahalı tahlil
  infectionPenalty,       // KKD eksikliği enfeksiyonu
  ethicalViolation,       // Etik ihlali
}

/// Tek bir malpraktis kaydı
class MalpracticeRecord {
  final MalpracticeType type;
  final String caseId;
  final String description;
  final int penaltyPoints;
  final DateTime timestamp;

  MalpracticeRecord({
    required this.type,
    required this.caseId,
    required this.description,
    required this.penaltyPoints,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'type': type.name,
    'caseId': caseId,
    'description': description,
    'penaltyPoints': penaltyPoints,
    'timestamp': timestamp.toIso8601String(),
  };

  factory MalpracticeRecord.fromJson(Map<String, dynamic> json) => MalpracticeRecord(
    type: MalpracticeType.values.firstWhere((t) => t.name == json['type']),
    caseId: json['caseId'] ?? '',
    description: json['description'] ?? '',
    penaltyPoints: json['penaltyPoints'] ?? 0,
    timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
  );
}

/// Oyuncu itibar puanı (varsayılan 50, etik seçimlere göre +/-)
class ReputationState {
  final int score;
  final Map<String, String> resolvedDilemmas; // dilemmaId -> choiceId
  final List<MalpracticeRecord> malpracticeHistory;

  /// Etik kurul aktif mi? (itibar 20 altına düşünce tetiklenir)
  final bool ethicalBoardTriggered;

  const ReputationState({
    this.score = 50,
    this.resolvedDilemmas = const {},
    this.malpracticeHistory = const [],
    this.ethicalBoardTriggered = false,
  });

  /// İtibar seviyesi
  String get reputationLevel {
    if (score >= 80) return 'Örnek Doktor';
    if (score >= 60) return 'İyi İtibar';
    if (score >= 40) return 'Normal';
    if (score >= 20) return 'Riskli';
    return 'Etik Kurul';
  }

  /// İtibar rengi
  bool get isInDanger => score < 20;
  bool get isLow => score < 40;

  ReputationState copyWith({
    int? score,
    Map<String, String>? resolvedDilemmas,
    List<MalpracticeRecord>? malpracticeHistory,
    bool? ethicalBoardTriggered,
  }) {
    return ReputationState(
      score: score ?? this.score,
      resolvedDilemmas: resolvedDilemmas ?? this.resolvedDilemmas,
      malpracticeHistory: malpracticeHistory ?? this.malpracticeHistory,
      ethicalBoardTriggered: ethicalBoardTriggered ?? this.ethicalBoardTriggered,
    );
  }

  bool isDilemmaResolved(String dilemmaId) =>
      resolvedDilemmas.containsKey(dilemmaId);

  String? getChoiceId(String dilemmaId) => resolvedDilemmas[dilemmaId];
}

class ReputationNotifier extends StateNotifier<ReputationState> {
  static const _storageKey = 'reputation_state';

  ReputationNotifier() : super(const ReputationState()) {
    _loadFromStorage();
  }

  /// Etik ikilem seçimi yap
  void resolveDilemma(EthicalDilemma dilemma, DilemmaChoice choice) {
    final newResolved = Map<String, String>.from(state.resolvedDilemmas);
    newResolved[dilemma.id] = choice.id;

    state = state.copyWith(
      score: (state.score + choice.reputationImpact).clamp(0, 100),
      resolvedDilemmas: newResolved,
    );
    _checkEthicalBoard();
    _saveToStorage();
  }

  /// Malpraktis cezası uygula
  void addMalpractice({
    required MalpracticeType type,
    required String caseId,
    required String description,
    int penaltyPoints = 5,
  }) {
    final record = MalpracticeRecord(
      type: type,
      caseId: caseId,
      description: description,
      penaltyPoints: penaltyPoints,
    );

    state = state.copyWith(
      score: (state.score - penaltyPoints).clamp(0, 100),
      malpracticeHistory: [...state.malpracticeHistory, record],
    );
    _checkEthicalBoard();
    _saveToStorage();
  }

  /// İtibar puanı ekle (doğru teşhis, iyi davranış vb.)
  void addReputation(int points) {
    state = state.copyWith(
      score: (state.score + points).clamp(0, 100),
    );
    _saveToStorage();
  }

  /// Etik kurul savunması başarılı — itibar iyileşir
  void completeEthicalBoard(bool success) {
    state = state.copyWith(
      ethicalBoardTriggered: false,
      score: success ? (state.score + 15).clamp(0, 100) : state.score,
    );
    _saveToStorage();
  }

  void _checkEthicalBoard() {
    if (state.score < 20 && !state.ethicalBoardTriggered) {
      state = state.copyWith(ethicalBoardTriggered: true);
    }
  }

  /// Başlangıç puanı ayarla (backend'den gelen değer)
  void setInitialScore(int score) {
    state = state.copyWith(score: score);
    _saveToStorage();
  }

  /// Dilemma'ları sıfırla (yeni vaka için) — malpraktis geçmişi korunur
  void resetDilemmas() {
    state = state.copyWith(resolvedDilemmas: {});
  }

  // ─── Kalıcı Storage ────────────────────────────────

  Future<void> _loadFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_storageKey);
      if (json == null) return;

      final data = jsonDecode(json) as Map<String, dynamic>;
      final history = (data['malpracticeHistory'] as List?)
          ?.map((e) => MalpracticeRecord.fromJson(e))
          .toList() ?? [];

      state = state.copyWith(
        score: data['score'] ?? 50,
        malpracticeHistory: history,
        ethicalBoardTriggered: data['ethicalBoardTriggered'] ?? false,
      );
    } catch (e) {
      debugPrint('[Reputation] Storage yükleme hatası: $e');
    }
  }

  Future<void> _saveToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_storageKey, jsonEncode({
        'score': state.score,
        'malpracticeHistory': state.malpracticeHistory.map((r) => r.toJson()).toList(),
        'ethicalBoardTriggered': state.ethicalBoardTriggered,
      }));
    } catch (e) {
      debugPrint('[Reputation] Storage kaydetme hatası: $e');
    }
  }
}

final reputationProvider =
    StateNotifierProvider<ReputationNotifier, ReputationState>(
  (ref) => ReputationNotifier(),
);

/// Belirli bir dilemma'nın çözülüp çözülmediğini kontrol eden provider
final isDilemmaResolvedProvider =
    Provider.family<bool, String>((ref, dilemmaId) {
  return ref.watch(reputationProvider).isDilemmaResolved(dilemmaId);
});
