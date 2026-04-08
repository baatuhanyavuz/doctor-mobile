import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagnosis.freezed.dart';
part 'diagnosis.g.dart';

/// Olası teşhis modeli (eski Diagnosis karşılığı)
@freezed
class Diagnosis with _$Diagnosis {
  const factory Diagnosis({
    @Default('') String id,
    @Default('') String name,

    /// Tıbbi kategori (Kardiyoloji, Göğüs Hastalıkları, Nöroloji vb.)
    String? category,

    /// Hastalık ikonu/illüstrasyon yolu
    String? iconPath,

    /// Hastalık açıklaması
    String? description,

    /// Tipik semptomlar
    @Default([]) List<String> typicalSymptoms,

    /// Risk faktörleri
    @Default([]) List<String> riskFactors,

    /// Meslek / alt branş
    String? occupation,

    /// Ayırıcı tanıda dikkat edilecekler
    String? differentialNotes,

    /// Hastalık fotoğrafı/illüstrasyon yolu
    String? photoPath,

    /// Detaylı açıklama (biyografi)
    String? biography,

    /// Semptom/kişilik özellikleri gösterimi
    List<String>? personalityTraits,

    /// Doğru teşhis mi (JSON'da saklanır, UI'da gösterilmez)
    @Default(false) bool isCorrectDiagnosis,

    /// Elenmiş mi (oyuncu tarafından)
    @Default(false) bool isRuledOut,
  }) = _Diagnosis;

  factory Diagnosis.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisFromJson(json);
}
