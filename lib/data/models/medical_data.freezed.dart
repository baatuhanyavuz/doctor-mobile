// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medical_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MedicalData _$MedicalDataFromJson(Map<String, dynamic> json) {
  return _MedicalData.fromJson(json);
}

/// @nodoc
mixin _$MedicalData {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  MedicalDataType get type => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  String? get thumbnailPath => throw _privateConstructorUsedError;

  /// Verinin kaynağı (Örn: "Radyoloji", "Biyokimya Lab", "Acil Servis")
  String? get source => throw _privateConstructorUsedError;

  /// Verinin bulunduğu konum / kaynak
  String? get location => throw _privateConstructorUsedError;

  /// Tarih/saat
  String? get dateTime => throw _privateConstructorUsedError;

  /// Bulunma/alınma tarihi
  String? get discoveredAt => throw _privateConstructorUsedError;

  /// Ek notlar
  String? get notes => throw _privateConstructorUsedError;

  /// Başlangıçta görünür mü
  bool get isUnlocked => throw _privateConstructorUsedError;

  /// Kilitli mi (tahlil henüz istenmemiş)
  bool get isLocked => throw _privateConstructorUsedError;

  /// Kilidi açmak için kod (tahlil istem kodu)
  String? get unlockCode => throw _privateConstructorUsedError;

  /// Kilitli ipucu ("Bu tahlili istemek için kodu girin")
  String? get lockedHint => throw _privateConstructorUsedError;

  /// Kontrastlı/filtreli gizli katman var mı
  bool get hasHiddenLayer => throw _privateConstructorUsedError;

  /// Gizli katman görselinin yolu
  String? get hiddenLayerUrl => throw _privateConstructorUsedError;

  /// Telefon/sağlık app verisi (phone tipi için)
  PhoneData? get phoneData => throw _privateConstructorUsedError;

  /// Lab analizi verisi (labSample tipi için)
  ForensicData? get labAnalysisData => throw _privateConstructorUsedError;

  /// İncelendi mi
  bool get isExamined => throw _privateConstructorUsedError;

  /// Referans aralığı (tahlil sonuçları için: "Normal: 0-5 mg/L")
  String? get referenceRange => throw _privateConstructorUsedError;

  /// Sonuç değeri (tahlil: "D-Dimer: 2.8 mg/L")
  String? get resultValue => throw _privateConstructorUsedError;

  /// Normal/anormal flag
  bool get isAbnormal =>
      throw _privateConstructorUsedError; // === TAHLİL İSTEK SİSTEMİ ===
  /// Bu veri istek gerektirir mi (true = oyuncu "İste" butonuna basmalı)
  bool get isRequestable => throw _privateConstructorUsedError;

  /// İstek süresi (saniye) — tahlil/görüntüleme ne kadar sürer
  /// Örn: kan tahlili 180s (3dk), röntgen 300s (5dk), MR 600s (10dk)
  int get requestDurationSeconds => throw _privateConstructorUsedError;

  /// İstek maliyeti (kredi) — 0 = ücretsiz
  int get requestCreditCost =>
      throw _privateConstructorUsedError; // === EKİP HATALARI (Faz 3.4) ===
  /// Bu sonuç potansiyel olarak başka bir hastayla karışmış olabilir
  bool get isPotentiallySwapped => throw _privateConstructorUsedError;

  /// Doğru değer (retest sonrası gösterilir)
  String? get correctValue => throw _privateConstructorUsedError;

  /// Retest maliyeti (kredi) — varsayılan 15
  int get retestCost => throw _privateConstructorUsedError;

  /// Hemşire notu (tutarsızlık içerebilir)
  String? get nurseNote => throw _privateConstructorUsedError;

  /// Hemşire notundaki tutarsızlık açıklaması
  String? get nurseNoteInconsistency => throw _privateConstructorUsedError;

  /// Retest yapıldı mı (runtime state, JSON'dan gelmez)
  bool get isRetested => throw _privateConstructorUsedError;

  /// Serializes this MedicalData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MedicalData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MedicalDataCopyWith<MedicalData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicalDataCopyWith<$Res> {
  factory $MedicalDataCopyWith(
    MedicalData value,
    $Res Function(MedicalData) then,
  ) = _$MedicalDataCopyWithImpl<$Res, MedicalData>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    MedicalDataType type,
    String filePath,
    String? thumbnailPath,
    String? source,
    String? location,
    String? dateTime,
    String? discoveredAt,
    String? notes,
    bool isUnlocked,
    bool isLocked,
    String? unlockCode,
    String? lockedHint,
    bool hasHiddenLayer,
    String? hiddenLayerUrl,
    PhoneData? phoneData,
    ForensicData? labAnalysisData,
    bool isExamined,
    String? referenceRange,
    String? resultValue,
    bool isAbnormal,
    bool isRequestable,
    int requestDurationSeconds,
    int requestCreditCost,
    bool isPotentiallySwapped,
    String? correctValue,
    int retestCost,
    String? nurseNote,
    String? nurseNoteInconsistency,
    bool isRetested,
  });

  $PhoneDataCopyWith<$Res>? get phoneData;
  $ForensicDataCopyWith<$Res>? get labAnalysisData;
}

/// @nodoc
class _$MedicalDataCopyWithImpl<$Res, $Val extends MedicalData>
    implements $MedicalDataCopyWith<$Res> {
  _$MedicalDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MedicalData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? filePath = null,
    Object? thumbnailPath = freezed,
    Object? source = freezed,
    Object? location = freezed,
    Object? dateTime = freezed,
    Object? discoveredAt = freezed,
    Object? notes = freezed,
    Object? isUnlocked = null,
    Object? isLocked = null,
    Object? unlockCode = freezed,
    Object? lockedHint = freezed,
    Object? hasHiddenLayer = null,
    Object? hiddenLayerUrl = freezed,
    Object? phoneData = freezed,
    Object? labAnalysisData = freezed,
    Object? isExamined = null,
    Object? referenceRange = freezed,
    Object? resultValue = freezed,
    Object? isAbnormal = null,
    Object? isRequestable = null,
    Object? requestDurationSeconds = null,
    Object? requestCreditCost = null,
    Object? isPotentiallySwapped = null,
    Object? correctValue = freezed,
    Object? retestCost = null,
    Object? nurseNote = freezed,
    Object? nurseNoteInconsistency = freezed,
    Object? isRetested = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as MedicalDataType,
            filePath: null == filePath
                ? _value.filePath
                : filePath // ignore: cast_nullable_to_non_nullable
                      as String,
            thumbnailPath: freezed == thumbnailPath
                ? _value.thumbnailPath
                : thumbnailPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            source: freezed == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateTime: freezed == dateTime
                ? _value.dateTime
                : dateTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            discoveredAt: freezed == discoveredAt
                ? _value.discoveredAt
                : discoveredAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            isUnlocked: null == isUnlocked
                ? _value.isUnlocked
                : isUnlocked // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLocked: null == isLocked
                ? _value.isLocked
                : isLocked // ignore: cast_nullable_to_non_nullable
                      as bool,
            unlockCode: freezed == unlockCode
                ? _value.unlockCode
                : unlockCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            lockedHint: freezed == lockedHint
                ? _value.lockedHint
                : lockedHint // ignore: cast_nullable_to_non_nullable
                      as String?,
            hasHiddenLayer: null == hasHiddenLayer
                ? _value.hasHiddenLayer
                : hasHiddenLayer // ignore: cast_nullable_to_non_nullable
                      as bool,
            hiddenLayerUrl: freezed == hiddenLayerUrl
                ? _value.hiddenLayerUrl
                : hiddenLayerUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            phoneData: freezed == phoneData
                ? _value.phoneData
                : phoneData // ignore: cast_nullable_to_non_nullable
                      as PhoneData?,
            labAnalysisData: freezed == labAnalysisData
                ? _value.labAnalysisData
                : labAnalysisData // ignore: cast_nullable_to_non_nullable
                      as ForensicData?,
            isExamined: null == isExamined
                ? _value.isExamined
                : isExamined // ignore: cast_nullable_to_non_nullable
                      as bool,
            referenceRange: freezed == referenceRange
                ? _value.referenceRange
                : referenceRange // ignore: cast_nullable_to_non_nullable
                      as String?,
            resultValue: freezed == resultValue
                ? _value.resultValue
                : resultValue // ignore: cast_nullable_to_non_nullable
                      as String?,
            isAbnormal: null == isAbnormal
                ? _value.isAbnormal
                : isAbnormal // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRequestable: null == isRequestable
                ? _value.isRequestable
                : isRequestable // ignore: cast_nullable_to_non_nullable
                      as bool,
            requestDurationSeconds: null == requestDurationSeconds
                ? _value.requestDurationSeconds
                : requestDurationSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            requestCreditCost: null == requestCreditCost
                ? _value.requestCreditCost
                : requestCreditCost // ignore: cast_nullable_to_non_nullable
                      as int,
            isPotentiallySwapped: null == isPotentiallySwapped
                ? _value.isPotentiallySwapped
                : isPotentiallySwapped // ignore: cast_nullable_to_non_nullable
                      as bool,
            correctValue: freezed == correctValue
                ? _value.correctValue
                : correctValue // ignore: cast_nullable_to_non_nullable
                      as String?,
            retestCost: null == retestCost
                ? _value.retestCost
                : retestCost // ignore: cast_nullable_to_non_nullable
                      as int,
            nurseNote: freezed == nurseNote
                ? _value.nurseNote
                : nurseNote // ignore: cast_nullable_to_non_nullable
                      as String?,
            nurseNoteInconsistency: freezed == nurseNoteInconsistency
                ? _value.nurseNoteInconsistency
                : nurseNoteInconsistency // ignore: cast_nullable_to_non_nullable
                      as String?,
            isRetested: null == isRetested
                ? _value.isRetested
                : isRetested // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of MedicalData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PhoneDataCopyWith<$Res>? get phoneData {
    if (_value.phoneData == null) {
      return null;
    }

    return $PhoneDataCopyWith<$Res>(_value.phoneData!, (value) {
      return _then(_value.copyWith(phoneData: value) as $Val);
    });
  }

  /// Create a copy of MedicalData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ForensicDataCopyWith<$Res>? get labAnalysisData {
    if (_value.labAnalysisData == null) {
      return null;
    }

    return $ForensicDataCopyWith<$Res>(_value.labAnalysisData!, (value) {
      return _then(_value.copyWith(labAnalysisData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MedicalDataImplCopyWith<$Res>
    implements $MedicalDataCopyWith<$Res> {
  factory _$$MedicalDataImplCopyWith(
    _$MedicalDataImpl value,
    $Res Function(_$MedicalDataImpl) then,
  ) = __$$MedicalDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    MedicalDataType type,
    String filePath,
    String? thumbnailPath,
    String? source,
    String? location,
    String? dateTime,
    String? discoveredAt,
    String? notes,
    bool isUnlocked,
    bool isLocked,
    String? unlockCode,
    String? lockedHint,
    bool hasHiddenLayer,
    String? hiddenLayerUrl,
    PhoneData? phoneData,
    ForensicData? labAnalysisData,
    bool isExamined,
    String? referenceRange,
    String? resultValue,
    bool isAbnormal,
    bool isRequestable,
    int requestDurationSeconds,
    int requestCreditCost,
    bool isPotentiallySwapped,
    String? correctValue,
    int retestCost,
    String? nurseNote,
    String? nurseNoteInconsistency,
    bool isRetested,
  });

  @override
  $PhoneDataCopyWith<$Res>? get phoneData;
  @override
  $ForensicDataCopyWith<$Res>? get labAnalysisData;
}

/// @nodoc
class __$$MedicalDataImplCopyWithImpl<$Res>
    extends _$MedicalDataCopyWithImpl<$Res, _$MedicalDataImpl>
    implements _$$MedicalDataImplCopyWith<$Res> {
  __$$MedicalDataImplCopyWithImpl(
    _$MedicalDataImpl _value,
    $Res Function(_$MedicalDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MedicalData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? filePath = null,
    Object? thumbnailPath = freezed,
    Object? source = freezed,
    Object? location = freezed,
    Object? dateTime = freezed,
    Object? discoveredAt = freezed,
    Object? notes = freezed,
    Object? isUnlocked = null,
    Object? isLocked = null,
    Object? unlockCode = freezed,
    Object? lockedHint = freezed,
    Object? hasHiddenLayer = null,
    Object? hiddenLayerUrl = freezed,
    Object? phoneData = freezed,
    Object? labAnalysisData = freezed,
    Object? isExamined = null,
    Object? referenceRange = freezed,
    Object? resultValue = freezed,
    Object? isAbnormal = null,
    Object? isRequestable = null,
    Object? requestDurationSeconds = null,
    Object? requestCreditCost = null,
    Object? isPotentiallySwapped = null,
    Object? correctValue = freezed,
    Object? retestCost = null,
    Object? nurseNote = freezed,
    Object? nurseNoteInconsistency = freezed,
    Object? isRetested = null,
  }) {
    return _then(
      _$MedicalDataImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as MedicalDataType,
        filePath: null == filePath
            ? _value.filePath
            : filePath // ignore: cast_nullable_to_non_nullable
                  as String,
        thumbnailPath: freezed == thumbnailPath
            ? _value.thumbnailPath
            : thumbnailPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        source: freezed == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateTime: freezed == dateTime
            ? _value.dateTime
            : dateTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        discoveredAt: freezed == discoveredAt
            ? _value.discoveredAt
            : discoveredAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        isUnlocked: null == isUnlocked
            ? _value.isUnlocked
            : isUnlocked // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLocked: null == isLocked
            ? _value.isLocked
            : isLocked // ignore: cast_nullable_to_non_nullable
                  as bool,
        unlockCode: freezed == unlockCode
            ? _value.unlockCode
            : unlockCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        lockedHint: freezed == lockedHint
            ? _value.lockedHint
            : lockedHint // ignore: cast_nullable_to_non_nullable
                  as String?,
        hasHiddenLayer: null == hasHiddenLayer
            ? _value.hasHiddenLayer
            : hasHiddenLayer // ignore: cast_nullable_to_non_nullable
                  as bool,
        hiddenLayerUrl: freezed == hiddenLayerUrl
            ? _value.hiddenLayerUrl
            : hiddenLayerUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        phoneData: freezed == phoneData
            ? _value.phoneData
            : phoneData // ignore: cast_nullable_to_non_nullable
                  as PhoneData?,
        labAnalysisData: freezed == labAnalysisData
            ? _value.labAnalysisData
            : labAnalysisData // ignore: cast_nullable_to_non_nullable
                  as ForensicData?,
        isExamined: null == isExamined
            ? _value.isExamined
            : isExamined // ignore: cast_nullable_to_non_nullable
                  as bool,
        referenceRange: freezed == referenceRange
            ? _value.referenceRange
            : referenceRange // ignore: cast_nullable_to_non_nullable
                  as String?,
        resultValue: freezed == resultValue
            ? _value.resultValue
            : resultValue // ignore: cast_nullable_to_non_nullable
                  as String?,
        isAbnormal: null == isAbnormal
            ? _value.isAbnormal
            : isAbnormal // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRequestable: null == isRequestable
            ? _value.isRequestable
            : isRequestable // ignore: cast_nullable_to_non_nullable
                  as bool,
        requestDurationSeconds: null == requestDurationSeconds
            ? _value.requestDurationSeconds
            : requestDurationSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        requestCreditCost: null == requestCreditCost
            ? _value.requestCreditCost
            : requestCreditCost // ignore: cast_nullable_to_non_nullable
                  as int,
        isPotentiallySwapped: null == isPotentiallySwapped
            ? _value.isPotentiallySwapped
            : isPotentiallySwapped // ignore: cast_nullable_to_non_nullable
                  as bool,
        correctValue: freezed == correctValue
            ? _value.correctValue
            : correctValue // ignore: cast_nullable_to_non_nullable
                  as String?,
        retestCost: null == retestCost
            ? _value.retestCost
            : retestCost // ignore: cast_nullable_to_non_nullable
                  as int,
        nurseNote: freezed == nurseNote
            ? _value.nurseNote
            : nurseNote // ignore: cast_nullable_to_non_nullable
                  as String?,
        nurseNoteInconsistency: freezed == nurseNoteInconsistency
            ? _value.nurseNoteInconsistency
            : nurseNoteInconsistency // ignore: cast_nullable_to_non_nullable
                  as String?,
        isRetested: null == isRetested
            ? _value.isRetested
            : isRetested // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MedicalDataImpl implements _MedicalData {
  const _$MedicalDataImpl({
    this.id = '',
    this.title = '',
    this.description = '',
    this.type = MedicalDataType.unknown,
    this.filePath = '',
    this.thumbnailPath,
    this.source,
    this.location,
    this.dateTime,
    this.discoveredAt,
    this.notes,
    this.isUnlocked = true,
    this.isLocked = false,
    this.unlockCode,
    this.lockedHint,
    this.hasHiddenLayer = false,
    this.hiddenLayerUrl,
    this.phoneData,
    this.labAnalysisData,
    this.isExamined = false,
    this.referenceRange,
    this.resultValue,
    this.isAbnormal = false,
    this.isRequestable = false,
    this.requestDurationSeconds = 0,
    this.requestCreditCost = 0,
    this.isPotentiallySwapped = false,
    this.correctValue,
    this.retestCost = 15,
    this.nurseNote,
    this.nurseNoteInconsistency,
    this.isRetested = false,
  });

  factory _$MedicalDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicalDataImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final MedicalDataType type;
  @override
  @JsonKey()
  final String filePath;
  @override
  final String? thumbnailPath;

  /// Verinin kaynağı (Örn: "Radyoloji", "Biyokimya Lab", "Acil Servis")
  @override
  final String? source;

  /// Verinin bulunduğu konum / kaynak
  @override
  final String? location;

  /// Tarih/saat
  @override
  final String? dateTime;

  /// Bulunma/alınma tarihi
  @override
  final String? discoveredAt;

  /// Ek notlar
  @override
  final String? notes;

  /// Başlangıçta görünür mü
  @override
  @JsonKey()
  final bool isUnlocked;

  /// Kilitli mi (tahlil henüz istenmemiş)
  @override
  @JsonKey()
  final bool isLocked;

  /// Kilidi açmak için kod (tahlil istem kodu)
  @override
  final String? unlockCode;

  /// Kilitli ipucu ("Bu tahlili istemek için kodu girin")
  @override
  final String? lockedHint;

  /// Kontrastlı/filtreli gizli katman var mı
  @override
  @JsonKey()
  final bool hasHiddenLayer;

  /// Gizli katman görselinin yolu
  @override
  final String? hiddenLayerUrl;

  /// Telefon/sağlık app verisi (phone tipi için)
  @override
  final PhoneData? phoneData;

  /// Lab analizi verisi (labSample tipi için)
  @override
  final ForensicData? labAnalysisData;

  /// İncelendi mi
  @override
  @JsonKey()
  final bool isExamined;

  /// Referans aralığı (tahlil sonuçları için: "Normal: 0-5 mg/L")
  @override
  final String? referenceRange;

  /// Sonuç değeri (tahlil: "D-Dimer: 2.8 mg/L")
  @override
  final String? resultValue;

  /// Normal/anormal flag
  @override
  @JsonKey()
  final bool isAbnormal;
  // === TAHLİL İSTEK SİSTEMİ ===
  /// Bu veri istek gerektirir mi (true = oyuncu "İste" butonuna basmalı)
  @override
  @JsonKey()
  final bool isRequestable;

  /// İstek süresi (saniye) — tahlil/görüntüleme ne kadar sürer
  /// Örn: kan tahlili 180s (3dk), röntgen 300s (5dk), MR 600s (10dk)
  @override
  @JsonKey()
  final int requestDurationSeconds;

  /// İstek maliyeti (kredi) — 0 = ücretsiz
  @override
  @JsonKey()
  final int requestCreditCost;
  // === EKİP HATALARI (Faz 3.4) ===
  /// Bu sonuç potansiyel olarak başka bir hastayla karışmış olabilir
  @override
  @JsonKey()
  final bool isPotentiallySwapped;

  /// Doğru değer (retest sonrası gösterilir)
  @override
  final String? correctValue;

  /// Retest maliyeti (kredi) — varsayılan 15
  @override
  @JsonKey()
  final int retestCost;

  /// Hemşire notu (tutarsızlık içerebilir)
  @override
  final String? nurseNote;

  /// Hemşire notundaki tutarsızlık açıklaması
  @override
  final String? nurseNoteInconsistency;

  /// Retest yapıldı mı (runtime state, JSON'dan gelmez)
  @override
  @JsonKey()
  final bool isRetested;

  @override
  String toString() {
    return 'MedicalData(id: $id, title: $title, description: $description, type: $type, filePath: $filePath, thumbnailPath: $thumbnailPath, source: $source, location: $location, dateTime: $dateTime, discoveredAt: $discoveredAt, notes: $notes, isUnlocked: $isUnlocked, isLocked: $isLocked, unlockCode: $unlockCode, lockedHint: $lockedHint, hasHiddenLayer: $hasHiddenLayer, hiddenLayerUrl: $hiddenLayerUrl, phoneData: $phoneData, labAnalysisData: $labAnalysisData, isExamined: $isExamined, referenceRange: $referenceRange, resultValue: $resultValue, isAbnormal: $isAbnormal, isRequestable: $isRequestable, requestDurationSeconds: $requestDurationSeconds, requestCreditCost: $requestCreditCost, isPotentiallySwapped: $isPotentiallySwapped, correctValue: $correctValue, retestCost: $retestCost, nurseNote: $nurseNote, nurseNoteInconsistency: $nurseNoteInconsistency, isRetested: $isRetested)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicalDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.thumbnailPath, thumbnailPath) ||
                other.thumbnailPath == thumbnailPath) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.discoveredAt, discoveredAt) ||
                other.discoveredAt == discoveredAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isUnlocked, isUnlocked) ||
                other.isUnlocked == isUnlocked) &&
            (identical(other.isLocked, isLocked) ||
                other.isLocked == isLocked) &&
            (identical(other.unlockCode, unlockCode) ||
                other.unlockCode == unlockCode) &&
            (identical(other.lockedHint, lockedHint) ||
                other.lockedHint == lockedHint) &&
            (identical(other.hasHiddenLayer, hasHiddenLayer) ||
                other.hasHiddenLayer == hasHiddenLayer) &&
            (identical(other.hiddenLayerUrl, hiddenLayerUrl) ||
                other.hiddenLayerUrl == hiddenLayerUrl) &&
            (identical(other.phoneData, phoneData) ||
                other.phoneData == phoneData) &&
            (identical(other.labAnalysisData, labAnalysisData) ||
                other.labAnalysisData == labAnalysisData) &&
            (identical(other.isExamined, isExamined) ||
                other.isExamined == isExamined) &&
            (identical(other.referenceRange, referenceRange) ||
                other.referenceRange == referenceRange) &&
            (identical(other.resultValue, resultValue) ||
                other.resultValue == resultValue) &&
            (identical(other.isAbnormal, isAbnormal) ||
                other.isAbnormal == isAbnormal) &&
            (identical(other.isRequestable, isRequestable) ||
                other.isRequestable == isRequestable) &&
            (identical(other.requestDurationSeconds, requestDurationSeconds) ||
                other.requestDurationSeconds == requestDurationSeconds) &&
            (identical(other.requestCreditCost, requestCreditCost) ||
                other.requestCreditCost == requestCreditCost) &&
            (identical(other.isPotentiallySwapped, isPotentiallySwapped) ||
                other.isPotentiallySwapped == isPotentiallySwapped) &&
            (identical(other.correctValue, correctValue) ||
                other.correctValue == correctValue) &&
            (identical(other.retestCost, retestCost) ||
                other.retestCost == retestCost) &&
            (identical(other.nurseNote, nurseNote) ||
                other.nurseNote == nurseNote) &&
            (identical(other.nurseNoteInconsistency, nurseNoteInconsistency) ||
                other.nurseNoteInconsistency == nurseNoteInconsistency) &&
            (identical(other.isRetested, isRetested) ||
                other.isRetested == isRetested));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    title,
    description,
    type,
    filePath,
    thumbnailPath,
    source,
    location,
    dateTime,
    discoveredAt,
    notes,
    isUnlocked,
    isLocked,
    unlockCode,
    lockedHint,
    hasHiddenLayer,
    hiddenLayerUrl,
    phoneData,
    labAnalysisData,
    isExamined,
    referenceRange,
    resultValue,
    isAbnormal,
    isRequestable,
    requestDurationSeconds,
    requestCreditCost,
    isPotentiallySwapped,
    correctValue,
    retestCost,
    nurseNote,
    nurseNoteInconsistency,
    isRetested,
  ]);

  /// Create a copy of MedicalData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicalDataImplCopyWith<_$MedicalDataImpl> get copyWith =>
      __$$MedicalDataImplCopyWithImpl<_$MedicalDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicalDataImplToJson(this);
  }
}

abstract class _MedicalData implements MedicalData {
  const factory _MedicalData({
    final String id,
    final String title,
    final String description,
    final MedicalDataType type,
    final String filePath,
    final String? thumbnailPath,
    final String? source,
    final String? location,
    final String? dateTime,
    final String? discoveredAt,
    final String? notes,
    final bool isUnlocked,
    final bool isLocked,
    final String? unlockCode,
    final String? lockedHint,
    final bool hasHiddenLayer,
    final String? hiddenLayerUrl,
    final PhoneData? phoneData,
    final ForensicData? labAnalysisData,
    final bool isExamined,
    final String? referenceRange,
    final String? resultValue,
    final bool isAbnormal,
    final bool isRequestable,
    final int requestDurationSeconds,
    final int requestCreditCost,
    final bool isPotentiallySwapped,
    final String? correctValue,
    final int retestCost,
    final String? nurseNote,
    final String? nurseNoteInconsistency,
    final bool isRetested,
  }) = _$MedicalDataImpl;

  factory _MedicalData.fromJson(Map<String, dynamic> json) =
      _$MedicalDataImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  MedicalDataType get type;
  @override
  String get filePath;
  @override
  String? get thumbnailPath;

  /// Verinin kaynağı (Örn: "Radyoloji", "Biyokimya Lab", "Acil Servis")
  @override
  String? get source;

  /// Verinin bulunduğu konum / kaynak
  @override
  String? get location;

  /// Tarih/saat
  @override
  String? get dateTime;

  /// Bulunma/alınma tarihi
  @override
  String? get discoveredAt;

  /// Ek notlar
  @override
  String? get notes;

  /// Başlangıçta görünür mü
  @override
  bool get isUnlocked;

  /// Kilitli mi (tahlil henüz istenmemiş)
  @override
  bool get isLocked;

  /// Kilidi açmak için kod (tahlil istem kodu)
  @override
  String? get unlockCode;

  /// Kilitli ipucu ("Bu tahlili istemek için kodu girin")
  @override
  String? get lockedHint;

  /// Kontrastlı/filtreli gizli katman var mı
  @override
  bool get hasHiddenLayer;

  /// Gizli katman görselinin yolu
  @override
  String? get hiddenLayerUrl;

  /// Telefon/sağlık app verisi (phone tipi için)
  @override
  PhoneData? get phoneData;

  /// Lab analizi verisi (labSample tipi için)
  @override
  ForensicData? get labAnalysisData;

  /// İncelendi mi
  @override
  bool get isExamined;

  /// Referans aralığı (tahlil sonuçları için: "Normal: 0-5 mg/L")
  @override
  String? get referenceRange;

  /// Sonuç değeri (tahlil: "D-Dimer: 2.8 mg/L")
  @override
  String? get resultValue;

  /// Normal/anormal flag
  @override
  bool get isAbnormal; // === TAHLİL İSTEK SİSTEMİ ===
  /// Bu veri istek gerektirir mi (true = oyuncu "İste" butonuna basmalı)
  @override
  bool get isRequestable;

  /// İstek süresi (saniye) — tahlil/görüntüleme ne kadar sürer
  /// Örn: kan tahlili 180s (3dk), röntgen 300s (5dk), MR 600s (10dk)
  @override
  int get requestDurationSeconds;

  /// İstek maliyeti (kredi) — 0 = ücretsiz
  @override
  int get requestCreditCost; // === EKİP HATALARI (Faz 3.4) ===
  /// Bu sonuç potansiyel olarak başka bir hastayla karışmış olabilir
  @override
  bool get isPotentiallySwapped;

  /// Doğru değer (retest sonrası gösterilir)
  @override
  String? get correctValue;

  /// Retest maliyeti (kredi) — varsayılan 15
  @override
  int get retestCost;

  /// Hemşire notu (tutarsızlık içerebilir)
  @override
  String? get nurseNote;

  /// Hemşire notundaki tutarsızlık açıklaması
  @override
  String? get nurseNoteInconsistency;

  /// Retest yapıldı mı (runtime state, JSON'dan gelmez)
  @override
  bool get isRetested;

  /// Create a copy of MedicalData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicalDataImplCopyWith<_$MedicalDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
