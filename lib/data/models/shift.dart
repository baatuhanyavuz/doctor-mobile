import 'dart:convert';

/// Nöbet yoğunluk seviyesi
enum ShiftIntensity { calm, normal, intense, chaotic }

/// Nöbet türü
enum ShiftType { day, night, weekend }

/// Nöbet durumu
class ShiftStatus {
  final String shiftId;
  final String shiftType;
  final String intensity;
  final String status;
  final DateTime startedAt;
  final DateTime endsAt;
  final int totalCases;
  final int correctCases;
  final int missedCases;
  final int wrongCases;
  final int totalXp;
  final int totalCredits;
  final String? grade;
  final ShiftCaseInfo? pendingCase;

  const ShiftStatus({
    required this.shiftId,
    required this.shiftType,
    required this.intensity,
    required this.status,
    required this.startedAt,
    required this.endsAt,
    this.totalCases = 0,
    this.correctCases = 0,
    this.missedCases = 0,
    this.wrongCases = 0,
    this.totalXp = 0,
    this.totalCredits = 0,
    this.grade,
    this.pendingCase,
  });

  bool get isActive => status == 'active';
  bool get isCompleted => status == 'completed';

  Duration get remainingDuration {
    final remaining = endsAt.difference(DateTime.now().toUtc());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  String get remainingFormatted {
    final d = remainingDuration;
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return '${h}sa ${m}dk';
  }

  int get answeredCases => correctCases + wrongCases;

  factory ShiftStatus.fromJson(Map<String, dynamic> json) {
    return ShiftStatus(
      shiftId: json['shiftId'] ?? '',
      shiftType: json['shiftType'] ?? 'day',
      intensity: json['intensity'] ?? 'normal',
      status: json['status'] ?? 'active',
      startedAt: DateTime.parse(json['startedAt']),
      endsAt: DateTime.parse(json['endsAt']),
      totalCases: json['totalCases'] ?? 0,
      correctCases: json['correctCases'] ?? 0,
      missedCases: json['missedCases'] ?? 0,
      wrongCases: json['wrongCases'] ?? 0,
      totalXp: json['totalXp'] ?? 0,
      totalCredits: json['totalCredits'] ?? 0,
      grade: json['grade'],
      pendingCase: json['pendingCase'] != null
          ? ShiftCaseInfo.fromJson(json['pendingCase'])
          : null,
    );
  }
}

/// Bekleyen snippet vaka bilgisi
class ShiftCaseInfo {
  final String shiftCaseId;
  final String? snippetId;
  final String? caseId;
  final String triageLevel;
  final String snippetTitle;
  final String scenario;
  final List<SnippetStep> steps;
  final int timeLimitSec;
  final DateTime sentAt;
  final DateTime expiresAt;

  const ShiftCaseInfo({
    required this.shiftCaseId,
    this.snippetId,
    this.caseId,
    required this.triageLevel,
    required this.snippetTitle,
    required this.scenario,
    required this.steps,
    required this.timeLimitSec,
    required this.sentAt,
    required this.expiresAt,
  });

  bool get isExpired => expiresAt.isBefore(DateTime.now().toUtc());

  Duration get remainingTime {
    final remaining = expiresAt.difference(DateTime.now().toUtc());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  factory ShiftCaseInfo.fromJson(Map<String, dynamic> json) {
    final stepsRaw = json['steps'];
    List<SnippetStep> parsedSteps = [];
    try {
      List<dynamic> list;
      if (stepsRaw is String) {
        list = jsonDecode(stepsRaw) as List;
      } else if (stepsRaw is List) {
        list = stepsRaw;
      } else {
        list = [];
      }
      parsedSteps = list
          .map((e) => SnippetStep.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (_) {}

    return ShiftCaseInfo(
      shiftCaseId: json['shiftCaseId'] ?? '',
      snippetId: json['snippetId'],
      caseId: json['caseId'],
      triageLevel: json['triageLevel'] ?? 'yellow',
      snippetTitle: json['snippetTitle'] ?? '',
      scenario: json['scenario'] ?? '',
      steps: parsedSteps,
      timeLimitSec: json['timeLimitSec'] ?? 60,
      sentAt: DateTime.parse(json['sentAt']),
      expiresAt: DateTime.parse(json['expiresAt']),
    );
  }
}

/// Snippet adımı (interaktif soru)
class SnippetStep {
  final String id;
  final String text;
  final List<SnippetOption> options;

  const SnippetStep({
    required this.id,
    required this.text,
    required this.options,
  });

  factory SnippetStep.fromJson(Map<String, dynamic> json) {
    return SnippetStep(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
      options: (json['options'] as List? ?? [])
          .map((e) => SnippetOption.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
}

/// Snippet seçenek
class SnippetOption {
  final String id;
  final String text;
  final bool isCorrect;
  final String feedback;
  final String? consequence;
  final String? nextStepId;

  const SnippetOption({
    required this.id,
    required this.text,
    this.isCorrect = false,
    this.feedback = '',
    this.consequence,
    this.nextStepId,
  });

  factory SnippetOption.fromJson(Map<String, dynamic> json) {
    return SnippetOption(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
      isCorrect: json['isCorrect'] ?? false,
      feedback: json['feedback'] ?? '',
      consequence: json['consequence'],
      nextStepId: json['nextStepId'],
    );
  }
}

/// Nöbet geçmişi öğesi
class ShiftHistoryItem {
  final String id;
  final String shiftType;
  final String intensity;
  final String status;
  final DateTime startedAt;
  final DateTime? completedAt;
  final int totalCases;
  final int correctCases;
  final int missedCases;
  final int wrongCases;
  final int totalXp;
  final int totalCredits;
  final String? grade;

  const ShiftHistoryItem({
    required this.id,
    required this.shiftType,
    required this.intensity,
    required this.status,
    required this.startedAt,
    this.completedAt,
    this.totalCases = 0,
    this.correctCases = 0,
    this.missedCases = 0,
    this.wrongCases = 0,
    this.totalXp = 0,
    this.totalCredits = 0,
    this.grade,
  });

  factory ShiftHistoryItem.fromJson(Map<String, dynamic> json) {
    return ShiftHistoryItem(
      id: json['id'] ?? '',
      shiftType: json['shiftType'] ?? 'day',
      intensity: json['intensity'] ?? 'normal',
      status: json['status'] ?? 'completed',
      startedAt: DateTime.parse(json['startedAt']),
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
      totalCases: json['totalCases'] ?? 0,
      correctCases: json['correctCases'] ?? 0,
      missedCases: json['missedCases'] ?? 0,
      wrongCases: json['wrongCases'] ?? 0,
      totalXp: json['totalXp'] ?? 0,
      totalCredits: json['totalCredits'] ?? 0,
      grade: json['grade'],
    );
  }
}
