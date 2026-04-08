// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ending_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EndingData _$EndingDataFromJson(Map<String, dynamic> json) {
  return _EndingData.fromJson(json);
}

/// @nodoc
mixin _$EndingData {
  String get title => throw _privateConstructorUsedError;
  String get narrative => throw _privateConstructorUsedError;

  /// Hasta geri bildirimi ("Teşekkürler doktor...")
  String get patientFeedback => throw _privateConstructorUsedError;

  /// Hasta iyileşme görseli
  String? get patientImage => throw _privateConstructorUsedError;

  /// Eğitici not (hastalık hakkında bilgi)
  String? get educationalNote => throw _privateConstructorUsedError;

  /// Etik seçime bağlı alternatif bitiş anlatıları
  /// Key: dilemmaId, Value: alternateEndingNarrative
  Map<String, String> get alternateNarratives =>
      throw _privateConstructorUsedError;

  /// İtibar puanı eşik değeri — bu eşiğin altında farklı ending
  int? get reputationThreshold => throw _privateConstructorUsedError;

  /// Düşük itibar ending anlatısı
  String? get lowReputationNarrative => throw _privateConstructorUsedError;

  /// Düşük itibar hasta geri bildirimi
  String? get lowReputationFeedback =>
      throw _privateConstructorUsedError; // Geriye uyumluluk
  @JsonKey(name: 'killerConfession')
  String? get killerConfessionLegacy => throw _privateConstructorUsedError;
  @JsonKey(name: 'killerImage')
  String? get killerImageLegacy => throw _privateConstructorUsedError;

  /// Serializes this EndingData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EndingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EndingDataCopyWith<EndingData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EndingDataCopyWith<$Res> {
  factory $EndingDataCopyWith(
    EndingData value,
    $Res Function(EndingData) then,
  ) = _$EndingDataCopyWithImpl<$Res, EndingData>;
  @useResult
  $Res call({
    String title,
    String narrative,
    String patientFeedback,
    String? patientImage,
    String? educationalNote,
    Map<String, String> alternateNarratives,
    int? reputationThreshold,
    String? lowReputationNarrative,
    String? lowReputationFeedback,
    @JsonKey(name: 'killerConfession') String? killerConfessionLegacy,
    @JsonKey(name: 'killerImage') String? killerImageLegacy,
  });
}

/// @nodoc
class _$EndingDataCopyWithImpl<$Res, $Val extends EndingData>
    implements $EndingDataCopyWith<$Res> {
  _$EndingDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EndingData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? narrative = null,
    Object? patientFeedback = null,
    Object? patientImage = freezed,
    Object? educationalNote = freezed,
    Object? alternateNarratives = null,
    Object? reputationThreshold = freezed,
    Object? lowReputationNarrative = freezed,
    Object? lowReputationFeedback = freezed,
    Object? killerConfessionLegacy = freezed,
    Object? killerImageLegacy = freezed,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            narrative: null == narrative
                ? _value.narrative
                : narrative // ignore: cast_nullable_to_non_nullable
                      as String,
            patientFeedback: null == patientFeedback
                ? _value.patientFeedback
                : patientFeedback // ignore: cast_nullable_to_non_nullable
                      as String,
            patientImage: freezed == patientImage
                ? _value.patientImage
                : patientImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            educationalNote: freezed == educationalNote
                ? _value.educationalNote
                : educationalNote // ignore: cast_nullable_to_non_nullable
                      as String?,
            alternateNarratives: null == alternateNarratives
                ? _value.alternateNarratives
                : alternateNarratives // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            reputationThreshold: freezed == reputationThreshold
                ? _value.reputationThreshold
                : reputationThreshold // ignore: cast_nullable_to_non_nullable
                      as int?,
            lowReputationNarrative: freezed == lowReputationNarrative
                ? _value.lowReputationNarrative
                : lowReputationNarrative // ignore: cast_nullable_to_non_nullable
                      as String?,
            lowReputationFeedback: freezed == lowReputationFeedback
                ? _value.lowReputationFeedback
                : lowReputationFeedback // ignore: cast_nullable_to_non_nullable
                      as String?,
            killerConfessionLegacy: freezed == killerConfessionLegacy
                ? _value.killerConfessionLegacy
                : killerConfessionLegacy // ignore: cast_nullable_to_non_nullable
                      as String?,
            killerImageLegacy: freezed == killerImageLegacy
                ? _value.killerImageLegacy
                : killerImageLegacy // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EndingDataImplCopyWith<$Res>
    implements $EndingDataCopyWith<$Res> {
  factory _$$EndingDataImplCopyWith(
    _$EndingDataImpl value,
    $Res Function(_$EndingDataImpl) then,
  ) = __$$EndingDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String narrative,
    String patientFeedback,
    String? patientImage,
    String? educationalNote,
    Map<String, String> alternateNarratives,
    int? reputationThreshold,
    String? lowReputationNarrative,
    String? lowReputationFeedback,
    @JsonKey(name: 'killerConfession') String? killerConfessionLegacy,
    @JsonKey(name: 'killerImage') String? killerImageLegacy,
  });
}

/// @nodoc
class __$$EndingDataImplCopyWithImpl<$Res>
    extends _$EndingDataCopyWithImpl<$Res, _$EndingDataImpl>
    implements _$$EndingDataImplCopyWith<$Res> {
  __$$EndingDataImplCopyWithImpl(
    _$EndingDataImpl _value,
    $Res Function(_$EndingDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EndingData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? narrative = null,
    Object? patientFeedback = null,
    Object? patientImage = freezed,
    Object? educationalNote = freezed,
    Object? alternateNarratives = null,
    Object? reputationThreshold = freezed,
    Object? lowReputationNarrative = freezed,
    Object? lowReputationFeedback = freezed,
    Object? killerConfessionLegacy = freezed,
    Object? killerImageLegacy = freezed,
  }) {
    return _then(
      _$EndingDataImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        narrative: null == narrative
            ? _value.narrative
            : narrative // ignore: cast_nullable_to_non_nullable
                  as String,
        patientFeedback: null == patientFeedback
            ? _value.patientFeedback
            : patientFeedback // ignore: cast_nullable_to_non_nullable
                  as String,
        patientImage: freezed == patientImage
            ? _value.patientImage
            : patientImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        educationalNote: freezed == educationalNote
            ? _value.educationalNote
            : educationalNote // ignore: cast_nullable_to_non_nullable
                  as String?,
        alternateNarratives: null == alternateNarratives
            ? _value._alternateNarratives
            : alternateNarratives // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        reputationThreshold: freezed == reputationThreshold
            ? _value.reputationThreshold
            : reputationThreshold // ignore: cast_nullable_to_non_nullable
                  as int?,
        lowReputationNarrative: freezed == lowReputationNarrative
            ? _value.lowReputationNarrative
            : lowReputationNarrative // ignore: cast_nullable_to_non_nullable
                  as String?,
        lowReputationFeedback: freezed == lowReputationFeedback
            ? _value.lowReputationFeedback
            : lowReputationFeedback // ignore: cast_nullable_to_non_nullable
                  as String?,
        killerConfessionLegacy: freezed == killerConfessionLegacy
            ? _value.killerConfessionLegacy
            : killerConfessionLegacy // ignore: cast_nullable_to_non_nullable
                  as String?,
        killerImageLegacy: freezed == killerImageLegacy
            ? _value.killerImageLegacy
            : killerImageLegacy // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EndingDataImpl implements _EndingData {
  const _$EndingDataImpl({
    this.title = '',
    this.narrative = '',
    this.patientFeedback = '',
    this.patientImage,
    this.educationalNote,
    final Map<String, String> alternateNarratives = const {},
    this.reputationThreshold,
    this.lowReputationNarrative,
    this.lowReputationFeedback,
    @JsonKey(name: 'killerConfession') this.killerConfessionLegacy,
    @JsonKey(name: 'killerImage') this.killerImageLegacy,
  }) : _alternateNarratives = alternateNarratives;

  factory _$EndingDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$EndingDataImplFromJson(json);

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String narrative;

  /// Hasta geri bildirimi ("Teşekkürler doktor...")
  @override
  @JsonKey()
  final String patientFeedback;

  /// Hasta iyileşme görseli
  @override
  final String? patientImage;

  /// Eğitici not (hastalık hakkında bilgi)
  @override
  final String? educationalNote;

  /// Etik seçime bağlı alternatif bitiş anlatıları
  /// Key: dilemmaId, Value: alternateEndingNarrative
  final Map<String, String> _alternateNarratives;

  /// Etik seçime bağlı alternatif bitiş anlatıları
  /// Key: dilemmaId, Value: alternateEndingNarrative
  @override
  @JsonKey()
  Map<String, String> get alternateNarratives {
    if (_alternateNarratives is EqualUnmodifiableMapView)
      return _alternateNarratives;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_alternateNarratives);
  }

  /// İtibar puanı eşik değeri — bu eşiğin altında farklı ending
  @override
  final int? reputationThreshold;

  /// Düşük itibar ending anlatısı
  @override
  final String? lowReputationNarrative;

  /// Düşük itibar hasta geri bildirimi
  @override
  final String? lowReputationFeedback;
  // Geriye uyumluluk
  @override
  @JsonKey(name: 'killerConfession')
  final String? killerConfessionLegacy;
  @override
  @JsonKey(name: 'killerImage')
  final String? killerImageLegacy;

  @override
  String toString() {
    return 'EndingData(title: $title, narrative: $narrative, patientFeedback: $patientFeedback, patientImage: $patientImage, educationalNote: $educationalNote, alternateNarratives: $alternateNarratives, reputationThreshold: $reputationThreshold, lowReputationNarrative: $lowReputationNarrative, lowReputationFeedback: $lowReputationFeedback, killerConfessionLegacy: $killerConfessionLegacy, killerImageLegacy: $killerImageLegacy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EndingDataImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.narrative, narrative) ||
                other.narrative == narrative) &&
            (identical(other.patientFeedback, patientFeedback) ||
                other.patientFeedback == patientFeedback) &&
            (identical(other.patientImage, patientImage) ||
                other.patientImage == patientImage) &&
            (identical(other.educationalNote, educationalNote) ||
                other.educationalNote == educationalNote) &&
            const DeepCollectionEquality().equals(
              other._alternateNarratives,
              _alternateNarratives,
            ) &&
            (identical(other.reputationThreshold, reputationThreshold) ||
                other.reputationThreshold == reputationThreshold) &&
            (identical(other.lowReputationNarrative, lowReputationNarrative) ||
                other.lowReputationNarrative == lowReputationNarrative) &&
            (identical(other.lowReputationFeedback, lowReputationFeedback) ||
                other.lowReputationFeedback == lowReputationFeedback) &&
            (identical(other.killerConfessionLegacy, killerConfessionLegacy) ||
                other.killerConfessionLegacy == killerConfessionLegacy) &&
            (identical(other.killerImageLegacy, killerImageLegacy) ||
                other.killerImageLegacy == killerImageLegacy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    narrative,
    patientFeedback,
    patientImage,
    educationalNote,
    const DeepCollectionEquality().hash(_alternateNarratives),
    reputationThreshold,
    lowReputationNarrative,
    lowReputationFeedback,
    killerConfessionLegacy,
    killerImageLegacy,
  );

  /// Create a copy of EndingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EndingDataImplCopyWith<_$EndingDataImpl> get copyWith =>
      __$$EndingDataImplCopyWithImpl<_$EndingDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EndingDataImplToJson(this);
  }
}

abstract class _EndingData implements EndingData {
  const factory _EndingData({
    final String title,
    final String narrative,
    final String patientFeedback,
    final String? patientImage,
    final String? educationalNote,
    final Map<String, String> alternateNarratives,
    final int? reputationThreshold,
    final String? lowReputationNarrative,
    final String? lowReputationFeedback,
    @JsonKey(name: 'killerConfession') final String? killerConfessionLegacy,
    @JsonKey(name: 'killerImage') final String? killerImageLegacy,
  }) = _$EndingDataImpl;

  factory _EndingData.fromJson(Map<String, dynamic> json) =
      _$EndingDataImpl.fromJson;

  @override
  String get title;
  @override
  String get narrative;

  /// Hasta geri bildirimi ("Teşekkürler doktor...")
  @override
  String get patientFeedback;

  /// Hasta iyileşme görseli
  @override
  String? get patientImage;

  /// Eğitici not (hastalık hakkında bilgi)
  @override
  String? get educationalNote;

  /// Etik seçime bağlı alternatif bitiş anlatıları
  /// Key: dilemmaId, Value: alternateEndingNarrative
  @override
  Map<String, String> get alternateNarratives;

  /// İtibar puanı eşik değeri — bu eşiğin altında farklı ending
  @override
  int? get reputationThreshold;

  /// Düşük itibar ending anlatısı
  @override
  String? get lowReputationNarrative;

  /// Düşük itibar hasta geri bildirimi
  @override
  String? get lowReputationFeedback; // Geriye uyumluluk
  @override
  @JsonKey(name: 'killerConfession')
  String? get killerConfessionLegacy;
  @override
  @JsonKey(name: 'killerImage')
  String? get killerImageLegacy;

  /// Create a copy of EndingData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EndingDataImplCopyWith<_$EndingDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
