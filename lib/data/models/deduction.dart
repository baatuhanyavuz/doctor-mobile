import 'package:freezed_annotation/freezed_annotation.dart';

part 'deduction.freezed.dart';
part 'deduction.g.dart';

/// Çıkarım / Birleştirme Kuralı
/// 
/// İki veya daha fazla tıbbi veri birleştirildiğinde
/// elde edilen sonucu tanımlar.
@freezed
class Deduction with _$Deduction {
  const factory Deduction({
    /// Benzersiz çıkarım ID'si
    @Default('') String id,
    
    /// Bu çıkarımı tetiklemek için birleşmesi gereken tıbbi veri ID'leri
    required List<String> requiredEvidenceIds,
    
    /// Birleşme başarılı olursa gösterilecek sonuç metni
    @Default('') String resultText,
    
    /// Çıkarımın kısa başlığı
    String? title,
    
    /// Çıkarımın önemi (1-10)
    @Default(5) int importance,
    
    /// (Opsiyonel) Bu birleşme sonucunda açılan yeni tıbbi veri ID'si
    String? rewardEvidenceId,
    
    /// Çıkarım bulundu mu?
    @Default(false) bool isFound,

    /// Bu çıkarım bir çelişki çözümü mü?
    /// (Hasta yanıltıcı cevap verdiğinde, tıbbi veri ile çelişki birleştirilerek gerçek ortaya çıkar)
    @Default(false) bool isContradiction,
  }) = _Deduction;

  factory Deduction.fromJson(Map<String, dynamic> json) =>
      _$DeductionFromJson(json);
}
