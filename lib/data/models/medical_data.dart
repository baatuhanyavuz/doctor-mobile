import 'package:freezed_annotation/freezed_annotation.dart';
import 'phone_data.dart';
import 'forensic_data.dart';

part 'medical_data.freezed.dart';
part 'medical_data.g.dart';

/// Tıbbi veri türleri
enum MedicalDataType {
  @JsonValue('imaging')
  imaging,            // Röntgen, MR, BT görüntüsü
  @JsonValue('labResult')
  labResult,          // Kan tahlili, idrar vb.
  @JsonValue('physicalExam')
  physicalExam,       // Fizik muayene bulgusu
  @JsonValue('document')
  document,           // Epikriz, sevk raporu, reçete
  @JsonValue('phone')
  phone,              // Hasta sağlık uygulaması verileri
  @JsonValue('labSample')
  labSample,          // Numune analizi (drag-drop lab)
  @JsonValue('audio')
  audio,              // Oskültasyon kaydı (akciğer, kalp sesi)
  @JsonValue('photo')
  photo,              // Fotoğraf
  @JsonValue('video')
  video,              // Video kaydı
  @JsonValue('object')
  object,             // Fiziksel nesne
  @JsonValue('toxicology')
  toxicology,         // Toksikoloji raporu
  @JsonValue('policeReport')
  policeReport,       // Polis raporu (adli tıp entegrasyonu)
  @JsonValue('trainingLog')
  trainingLog,        // Antrenman günlüğü (spor hekimliği)
  @JsonValue('lifestyleData')
  lifestyleData,      // Yaşam tarzı analizi verileri
  @JsonValue('anatomicalImaging')
  anatomicalImaging,  // Anatomik görüntüleme (kas/eklem MR)
  @JsonValue('unknown')
  unknown,
}

/// Tıbbi veri modeli (eski MedicalData karşılığı)
@freezed
class MedicalData with _$MedicalData {
  const factory MedicalData({
    @Default('') String id,
    @Default('') String title,
    @Default('') String description,
    @Default(MedicalDataType.unknown) MedicalDataType type,
    @Default('') String filePath,
    String? thumbnailPath,

    /// Verinin kaynağı (Örn: "Radyoloji", "Biyokimya Lab", "Acil Servis")
    String? source,

    /// Verinin bulunduğu konum / kaynak
    String? location,

    /// Tarih/saat
    String? dateTime,

    /// Bulunma/alınma tarihi
    String? discoveredAt,

    /// Ek notlar
    String? notes,

    /// Başlangıçta görünür mü
    @Default(true) bool isUnlocked,

    /// Kilitli mi (tahlil henüz istenmemiş)
    @Default(false) bool isLocked,

    /// Kilidi açmak için kod (tahlil istem kodu)
    String? unlockCode,

    /// Kilitli ipucu ("Bu tahlili istemek için kodu girin")
    String? lockedHint,

    /// Kontrastlı/filtreli gizli katman var mı
    @Default(false) bool hasHiddenLayer,

    /// Gizli katman görselinin yolu
    String? hiddenLayerUrl,

    /// Telefon/sağlık app verisi (phone tipi için)
    PhoneData? phoneData,

    /// Lab analizi verisi (labSample tipi için)
    ForensicData? labAnalysisData,

    /// İncelendi mi
    @Default(false) bool isExamined,

    /// Referans aralığı (tahlil sonuçları için: "Normal: 0-5 mg/L")
    String? referenceRange,

    /// Sonuç değeri (tahlil: "D-Dimer: 2.8 mg/L")
    String? resultValue,

    /// Normal/anormal flag
    @Default(false) bool isAbnormal,

    // === TAHLİL İSTEK SİSTEMİ ===

    /// Bu veri istek gerektirir mi (true = oyuncu "İste" butonuna basmalı)
    @Default(false) bool isRequestable,

    /// İstek süresi (saniye) — tahlil/görüntüleme ne kadar sürer
    /// Örn: kan tahlili 180s (3dk), röntgen 300s (5dk), MR 600s (10dk)
    @Default(0) int requestDurationSeconds,

    /// İstek maliyeti (kredi) — 0 = ücretsiz
    @Default(0) int requestCreditCost,

    // === EKİP HATALARI (Faz 3.4) ===

    /// Bu sonuç potansiyel olarak başka bir hastayla karışmış olabilir
    @Default(false) bool isPotentiallySwapped,

    /// Doğru değer (retest sonrası gösterilir)
    String? correctValue,

    /// Retest maliyeti (kredi) — varsayılan 15
    @Default(15) int retestCost,

    /// Hemşire notu (tutarsızlık içerebilir)
    String? nurseNote,

    /// Hemşire notundaki tutarsızlık açıklaması
    String? nurseNoteInconsistency,

    /// Retest yapıldı mı (runtime state, JSON'dan gelmez)
    @Default(false) bool isRetested,
  }) = _MedicalData;

  factory MedicalData.fromJson(Map<String, dynamic> json) =>
      _$MedicalDataFromJson(json);
}
