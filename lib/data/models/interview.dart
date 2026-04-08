import 'package:freezed_annotation/freezed_annotation.dart';
import 'dialogue_model.dart';

part 'interview.freezed.dart';
part 'interview.g.dart';

/// Soru-Cevap çifti (anamnez)
@freezed
class QuestionAnswer with _$QuestionAnswer {
  const factory QuestionAnswer({
    @Default('') String question,
    @Default('') String answer,

    /// Bu cevap kritik bir bulgu mu
    @Default(false) bool isClue,

    /// Bu cevap tahlil sonuçlarıyla çelişiyor mu
    @Default(false) bool isContradiction,

    /// Çelişki çözüldüğünde ortaya çıkan gerçek cevap
    String? truthReveal,

    /// Bu çelişkinin ilişkili olduğu tıbbi veri ID'si
    String? contradictionEvidenceId,
  }) = _QuestionAnswer;

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) =>
      _$QuestionAnswerFromJson(json);
}

/// Görüşülen kişi tipi
enum InterviewPersonType {
  @JsonValue('patient')
  patient,
  @JsonValue('relative')
  relative,
  @JsonValue('nurse')
  nurse,
  @JsonValue('other')
  other,
}

/// Anamnez görüşme kaydı (eski Interview karşılığı)
@freezed
class Interview with _$Interview {
  const factory Interview({
    @Default('') String id,

    /// Görüşülen kişinin ID'si
    @Default('') String personId,

    /// Görüşme başlığı
    @Default('') String title,

    /// Görüşülen kişinin adı
    String? personName,

    /// Kişi tipi (hasta, yakın, hemşire)
    @Default(InterviewPersonType.patient) InterviewPersonType personType,

    /// Kişi fotoğrafı
    String? personPhotoPath,

    /// Görüşme tarihi/saati
    String? dateTime,

    /// Soru-cevap listesi
    @Default([]) List<QuestionAnswer> transcript,

    /// Ses kaydı dosya yolu
    String? audioPath,

    /// Görüşme özeti
    String? summary,

    /// Önemli bulgular
    List<String>? keyFindings,

    /// Kilidi açık mı
    @Default(true) bool isUnlocked,

    /// Tamamlandı mı
    @Default(false) bool isCompleted,

    /// İnteraktif mi (mini oyun olarak oynanabilir)
    @Default(false) bool isInteractive,

    /// Diyalog ağacı (interaktif görüşmeler için)
    List<DialogueNode>? dialogueTree,
  }) = _Interview;

  factory Interview.fromJson(Map<String, dynamic> json) =>
      _$InterviewFromJson(json);
}
