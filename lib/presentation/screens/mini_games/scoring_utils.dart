import 'dart:math';

/// Mini oyun skor hesaplama (client-side)
class ScoringUtils {
  ScoringUtils._();

  /// Balistik analiz skoru (0-1000)
  static int calculateBallisticScore({
    required double guessX,
    required double guessY,
    required double guessAngle,
    required double correctX,
    required double correctY,
    required double correctAngle,
    required double tolerance,
  }) {
    // Pozisyon skoru (0-700)
    final distance = sqrt(pow(guessX - correctX, 2) + pow(guessY - correctY, 2));
    final positionScore = max(0, (700 * (1 - distance / tolerance)).round());

    // Açı skoru (0-300)
    final angleDiff = min(
      (guessAngle - correctAngle).abs(),
      360 - (guessAngle - correctAngle).abs(),
    );
    final angleScore = max(0, (300 * (1 - angleDiff / 30.0)).round());

    return min(1000, positionScore + angleScore);
  }

  /// Sorgulama skoru (0-1000)
  static int calculateInterrogationScore({
    required List<String> chosenQuestionIds,
    required List<String> criticalQuestions,
    required List<String> optimalOrder,
    required int finalStressLevel,
    required int stressThreshold,
  }) {
    // 1. Kritik sorular (0-400)
    final criticalFound = criticalQuestions.where((id) => chosenQuestionIds.contains(id)).length;
    final criticalScore = criticalQuestions.isNotEmpty
        ? (400 * criticalFound / criticalQuestions.length).round()
        : 400;

    // 2. Sıralama bonusu (0-300)
    final orderScore = _calculateOrderScore(chosenQuestionIds, optimalOrder, 300);

    // 3. Stres yönetimi (0-300)
    final stressScore = finalStressLevel <= stressThreshold
        ? 300
        : max(0, 300 - (finalStressLevel - stressThreshold) * 10);

    return min(1000, criticalScore + orderScore + stressScore);
  }

  static int _calculateOrderScore(List<String> chosen, List<String> optimal, int maxPoints) {
    if (optimal.isEmpty) return maxPoints;

    var matchCount = 0;
    var optIdx = 0;
    for (final id in chosen) {
      if (optIdx < optimal.length && optimal[optIdx] == id) {
        matchCount++;
        optIdx++;
      }
    }

    return (maxPoints * matchCount / optimal.length).round();
  }
}
