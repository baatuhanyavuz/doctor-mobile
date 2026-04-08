// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ethical_dilemma.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DilemmaChoice _$DilemmaChoiceFromJson(Map<String, dynamic> json) {
  return _DilemmaChoice.fromJson(json);
}

/// @nodoc
mixin _$DilemmaChoice {
  String get id => throw _privateConstructorUsedError;

  /// Seçenek metni (ör: "Tedaviyi uygula")
  String get text => throw _privateConstructorUsedError;

  /// Seçim sonrası gösterilen sonuç anlatısı
  String get consequence => throw _privateConstructorUsedError;

  /// İtibar puanı etkisi (+/-)
  int get reputationImpact => throw _privateConstructorUsedError;

  /// Bu seçim yeni tıbbi veri açar mı
  String? get unlocksEvidenceId => throw _privateConstructorUsedError;

  /// Bu seçim bir tıbbi veriyi kaldırır/gizler mi
  String? get removesEvidenceId => throw _privateConstructorUsedError;

  /// Farklı bitiş anlatısı (seçime bağlı ending)
  String? get alternateEndingNarrative => throw _privateConstructorUsedError;

  /// Farklı bitiş başlığı
  String? get alternateEndingTitle => throw _privateConstructorUsedError;

  /// Farklı hasta geri bildirimi
  String? get alternatePatientFeedback => throw _privateConstructorUsedError;

  /// Etik olarak "doğru" kabul edilen seçim mi
  bool get isEthical => throw _privateConstructorUsedError;

  /// Serializes this DilemmaChoice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DilemmaChoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DilemmaChoiceCopyWith<DilemmaChoice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DilemmaChoiceCopyWith<$Res> {
  factory $DilemmaChoiceCopyWith(
    DilemmaChoice value,
    $Res Function(DilemmaChoice) then,
  ) = _$DilemmaChoiceCopyWithImpl<$Res, DilemmaChoice>;
  @useResult
  $Res call({
    String id,
    String text,
    String consequence,
    int reputationImpact,
    String? unlocksEvidenceId,
    String? removesEvidenceId,
    String? alternateEndingNarrative,
    String? alternateEndingTitle,
    String? alternatePatientFeedback,
    bool isEthical,
  });
}

/// @nodoc
class _$DilemmaChoiceCopyWithImpl<$Res, $Val extends DilemmaChoice>
    implements $DilemmaChoiceCopyWith<$Res> {
  _$DilemmaChoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DilemmaChoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? consequence = null,
    Object? reputationImpact = null,
    Object? unlocksEvidenceId = freezed,
    Object? removesEvidenceId = freezed,
    Object? alternateEndingNarrative = freezed,
    Object? alternateEndingTitle = freezed,
    Object? alternatePatientFeedback = freezed,
    Object? isEthical = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            consequence: null == consequence
                ? _value.consequence
                : consequence // ignore: cast_nullable_to_non_nullable
                      as String,
            reputationImpact: null == reputationImpact
                ? _value.reputationImpact
                : reputationImpact // ignore: cast_nullable_to_non_nullable
                      as int,
            unlocksEvidenceId: freezed == unlocksEvidenceId
                ? _value.unlocksEvidenceId
                : unlocksEvidenceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            removesEvidenceId: freezed == removesEvidenceId
                ? _value.removesEvidenceId
                : removesEvidenceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            alternateEndingNarrative: freezed == alternateEndingNarrative
                ? _value.alternateEndingNarrative
                : alternateEndingNarrative // ignore: cast_nullable_to_non_nullable
                      as String?,
            alternateEndingTitle: freezed == alternateEndingTitle
                ? _value.alternateEndingTitle
                : alternateEndingTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            alternatePatientFeedback: freezed == alternatePatientFeedback
                ? _value.alternatePatientFeedback
                : alternatePatientFeedback // ignore: cast_nullable_to_non_nullable
                      as String?,
            isEthical: null == isEthical
                ? _value.isEthical
                : isEthical // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DilemmaChoiceImplCopyWith<$Res>
    implements $DilemmaChoiceCopyWith<$Res> {
  factory _$$DilemmaChoiceImplCopyWith(
    _$DilemmaChoiceImpl value,
    $Res Function(_$DilemmaChoiceImpl) then,
  ) = __$$DilemmaChoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String text,
    String consequence,
    int reputationImpact,
    String? unlocksEvidenceId,
    String? removesEvidenceId,
    String? alternateEndingNarrative,
    String? alternateEndingTitle,
    String? alternatePatientFeedback,
    bool isEthical,
  });
}

/// @nodoc
class __$$DilemmaChoiceImplCopyWithImpl<$Res>
    extends _$DilemmaChoiceCopyWithImpl<$Res, _$DilemmaChoiceImpl>
    implements _$$DilemmaChoiceImplCopyWith<$Res> {
  __$$DilemmaChoiceImplCopyWithImpl(
    _$DilemmaChoiceImpl _value,
    $Res Function(_$DilemmaChoiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DilemmaChoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? consequence = null,
    Object? reputationImpact = null,
    Object? unlocksEvidenceId = freezed,
    Object? removesEvidenceId = freezed,
    Object? alternateEndingNarrative = freezed,
    Object? alternateEndingTitle = freezed,
    Object? alternatePatientFeedback = freezed,
    Object? isEthical = null,
  }) {
    return _then(
      _$DilemmaChoiceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        consequence: null == consequence
            ? _value.consequence
            : consequence // ignore: cast_nullable_to_non_nullable
                  as String,
        reputationImpact: null == reputationImpact
            ? _value.reputationImpact
            : reputationImpact // ignore: cast_nullable_to_non_nullable
                  as int,
        unlocksEvidenceId: freezed == unlocksEvidenceId
            ? _value.unlocksEvidenceId
            : unlocksEvidenceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        removesEvidenceId: freezed == removesEvidenceId
            ? _value.removesEvidenceId
            : removesEvidenceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        alternateEndingNarrative: freezed == alternateEndingNarrative
            ? _value.alternateEndingNarrative
            : alternateEndingNarrative // ignore: cast_nullable_to_non_nullable
                  as String?,
        alternateEndingTitle: freezed == alternateEndingTitle
            ? _value.alternateEndingTitle
            : alternateEndingTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        alternatePatientFeedback: freezed == alternatePatientFeedback
            ? _value.alternatePatientFeedback
            : alternatePatientFeedback // ignore: cast_nullable_to_non_nullable
                  as String?,
        isEthical: null == isEthical
            ? _value.isEthical
            : isEthical // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DilemmaChoiceImpl implements _DilemmaChoice {
  const _$DilemmaChoiceImpl({
    this.id = '',
    this.text = '',
    this.consequence = '',
    this.reputationImpact = 0,
    this.unlocksEvidenceId,
    this.removesEvidenceId,
    this.alternateEndingNarrative,
    this.alternateEndingTitle,
    this.alternatePatientFeedback,
    this.isEthical = false,
  });

  factory _$DilemmaChoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DilemmaChoiceImplFromJson(json);

  @override
  @JsonKey()
  final String id;

  /// Seçenek metni (ör: "Tedaviyi uygula")
  @override
  @JsonKey()
  final String text;

  /// Seçim sonrası gösterilen sonuç anlatısı
  @override
  @JsonKey()
  final String consequence;

  /// İtibar puanı etkisi (+/-)
  @override
  @JsonKey()
  final int reputationImpact;

  /// Bu seçim yeni tıbbi veri açar mı
  @override
  final String? unlocksEvidenceId;

  /// Bu seçim bir tıbbi veriyi kaldırır/gizler mi
  @override
  final String? removesEvidenceId;

  /// Farklı bitiş anlatısı (seçime bağlı ending)
  @override
  final String? alternateEndingNarrative;

  /// Farklı bitiş başlığı
  @override
  final String? alternateEndingTitle;

  /// Farklı hasta geri bildirimi
  @override
  final String? alternatePatientFeedback;

  /// Etik olarak "doğru" kabul edilen seçim mi
  @override
  @JsonKey()
  final bool isEthical;

  @override
  String toString() {
    return 'DilemmaChoice(id: $id, text: $text, consequence: $consequence, reputationImpact: $reputationImpact, unlocksEvidenceId: $unlocksEvidenceId, removesEvidenceId: $removesEvidenceId, alternateEndingNarrative: $alternateEndingNarrative, alternateEndingTitle: $alternateEndingTitle, alternatePatientFeedback: $alternatePatientFeedback, isEthical: $isEthical)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DilemmaChoiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.consequence, consequence) ||
                other.consequence == consequence) &&
            (identical(other.reputationImpact, reputationImpact) ||
                other.reputationImpact == reputationImpact) &&
            (identical(other.unlocksEvidenceId, unlocksEvidenceId) ||
                other.unlocksEvidenceId == unlocksEvidenceId) &&
            (identical(other.removesEvidenceId, removesEvidenceId) ||
                other.removesEvidenceId == removesEvidenceId) &&
            (identical(
                  other.alternateEndingNarrative,
                  alternateEndingNarrative,
                ) ||
                other.alternateEndingNarrative == alternateEndingNarrative) &&
            (identical(other.alternateEndingTitle, alternateEndingTitle) ||
                other.alternateEndingTitle == alternateEndingTitle) &&
            (identical(
                  other.alternatePatientFeedback,
                  alternatePatientFeedback,
                ) ||
                other.alternatePatientFeedback == alternatePatientFeedback) &&
            (identical(other.isEthical, isEthical) ||
                other.isEthical == isEthical));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    text,
    consequence,
    reputationImpact,
    unlocksEvidenceId,
    removesEvidenceId,
    alternateEndingNarrative,
    alternateEndingTitle,
    alternatePatientFeedback,
    isEthical,
  );

  /// Create a copy of DilemmaChoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DilemmaChoiceImplCopyWith<_$DilemmaChoiceImpl> get copyWith =>
      __$$DilemmaChoiceImplCopyWithImpl<_$DilemmaChoiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DilemmaChoiceImplToJson(this);
  }
}

abstract class _DilemmaChoice implements DilemmaChoice {
  const factory _DilemmaChoice({
    final String id,
    final String text,
    final String consequence,
    final int reputationImpact,
    final String? unlocksEvidenceId,
    final String? removesEvidenceId,
    final String? alternateEndingNarrative,
    final String? alternateEndingTitle,
    final String? alternatePatientFeedback,
    final bool isEthical,
  }) = _$DilemmaChoiceImpl;

  factory _DilemmaChoice.fromJson(Map<String, dynamic> json) =
      _$DilemmaChoiceImpl.fromJson;

  @override
  String get id;

  /// Seçenek metni (ör: "Tedaviyi uygula")
  @override
  String get text;

  /// Seçim sonrası gösterilen sonuç anlatısı
  @override
  String get consequence;

  /// İtibar puanı etkisi (+/-)
  @override
  int get reputationImpact;

  /// Bu seçim yeni tıbbi veri açar mı
  @override
  String? get unlocksEvidenceId;

  /// Bu seçim bir tıbbi veriyi kaldırır/gizler mi
  @override
  String? get removesEvidenceId;

  /// Farklı bitiş anlatısı (seçime bağlı ending)
  @override
  String? get alternateEndingNarrative;

  /// Farklı bitiş başlığı
  @override
  String? get alternateEndingTitle;

  /// Farklı hasta geri bildirimi
  @override
  String? get alternatePatientFeedback;

  /// Etik olarak "doğru" kabul edilen seçim mi
  @override
  bool get isEthical;

  /// Create a copy of DilemmaChoice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DilemmaChoiceImplCopyWith<_$DilemmaChoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EthicalDilemma _$EthicalDilemmaFromJson(Map<String, dynamic> json) {
  return _EthicalDilemma.fromJson(json);
}

/// @nodoc
mixin _$EthicalDilemma {
  String get id => throw _privateConstructorUsedError;

  /// İkilem başlığı (ör: "Hasta Mahremiyeti")
  String get title => throw _privateConstructorUsedError;

  /// Durum açıklaması — oyuncuya gösterilir
  String get description => throw _privateConstructorUsedError;

  /// Ne zaman tetiklenir:
  /// - "before_solution" → Teşhis & Tedavi tabına geçerken
  /// - "after_evidence_ev_001" → Belirli kanıt açıldığında
  /// - "after_deduction_ded_001" → Belirli çıkarım bulunduğunda
  /// - "on_game_start" → Oyun başladığında
  String get triggerPoint => throw _privateConstructorUsedError;

  /// Seçenekler (tam olarak 2 adet)
  List<DilemmaChoice> get choices => throw _privateConstructorUsedError;

  /// Ek bağlam bilgisi (ör: tıbbi etik kuralı referansı)
  String? get contextInfo => throw _privateConstructorUsedError;

  /// İkilem kategorisi (ör: "mahremiyet", "kaynak_dagitimi", "bilgilendirme")
  String? get category => throw _privateConstructorUsedError;

  /// Serializes this EthicalDilemma to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EthicalDilemma
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EthicalDilemmaCopyWith<EthicalDilemma> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EthicalDilemmaCopyWith<$Res> {
  factory $EthicalDilemmaCopyWith(
    EthicalDilemma value,
    $Res Function(EthicalDilemma) then,
  ) = _$EthicalDilemmaCopyWithImpl<$Res, EthicalDilemma>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String triggerPoint,
    List<DilemmaChoice> choices,
    String? contextInfo,
    String? category,
  });
}

/// @nodoc
class _$EthicalDilemmaCopyWithImpl<$Res, $Val extends EthicalDilemma>
    implements $EthicalDilemmaCopyWith<$Res> {
  _$EthicalDilemmaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EthicalDilemma
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? triggerPoint = null,
    Object? choices = null,
    Object? contextInfo = freezed,
    Object? category = freezed,
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
            triggerPoint: null == triggerPoint
                ? _value.triggerPoint
                : triggerPoint // ignore: cast_nullable_to_non_nullable
                      as String,
            choices: null == choices
                ? _value.choices
                : choices // ignore: cast_nullable_to_non_nullable
                      as List<DilemmaChoice>,
            contextInfo: freezed == contextInfo
                ? _value.contextInfo
                : contextInfo // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EthicalDilemmaImplCopyWith<$Res>
    implements $EthicalDilemmaCopyWith<$Res> {
  factory _$$EthicalDilemmaImplCopyWith(
    _$EthicalDilemmaImpl value,
    $Res Function(_$EthicalDilemmaImpl) then,
  ) = __$$EthicalDilemmaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String triggerPoint,
    List<DilemmaChoice> choices,
    String? contextInfo,
    String? category,
  });
}

/// @nodoc
class __$$EthicalDilemmaImplCopyWithImpl<$Res>
    extends _$EthicalDilemmaCopyWithImpl<$Res, _$EthicalDilemmaImpl>
    implements _$$EthicalDilemmaImplCopyWith<$Res> {
  __$$EthicalDilemmaImplCopyWithImpl(
    _$EthicalDilemmaImpl _value,
    $Res Function(_$EthicalDilemmaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EthicalDilemma
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? triggerPoint = null,
    Object? choices = null,
    Object? contextInfo = freezed,
    Object? category = freezed,
  }) {
    return _then(
      _$EthicalDilemmaImpl(
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
        triggerPoint: null == triggerPoint
            ? _value.triggerPoint
            : triggerPoint // ignore: cast_nullable_to_non_nullable
                  as String,
        choices: null == choices
            ? _value._choices
            : choices // ignore: cast_nullable_to_non_nullable
                  as List<DilemmaChoice>,
        contextInfo: freezed == contextInfo
            ? _value.contextInfo
            : contextInfo // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EthicalDilemmaImpl implements _EthicalDilemma {
  const _$EthicalDilemmaImpl({
    this.id = '',
    this.title = '',
    this.description = '',
    this.triggerPoint = 'before_solution',
    final List<DilemmaChoice> choices = const [],
    this.contextInfo,
    this.category,
  }) : _choices = choices;

  factory _$EthicalDilemmaImpl.fromJson(Map<String, dynamic> json) =>
      _$$EthicalDilemmaImplFromJson(json);

  @override
  @JsonKey()
  final String id;

  /// İkilem başlığı (ör: "Hasta Mahremiyeti")
  @override
  @JsonKey()
  final String title;

  /// Durum açıklaması — oyuncuya gösterilir
  @override
  @JsonKey()
  final String description;

  /// Ne zaman tetiklenir:
  /// - "before_solution" → Teşhis & Tedavi tabına geçerken
  /// - "after_evidence_ev_001" → Belirli kanıt açıldığında
  /// - "after_deduction_ded_001" → Belirli çıkarım bulunduğunda
  /// - "on_game_start" → Oyun başladığında
  @override
  @JsonKey()
  final String triggerPoint;

  /// Seçenekler (tam olarak 2 adet)
  final List<DilemmaChoice> _choices;

  /// Seçenekler (tam olarak 2 adet)
  @override
  @JsonKey()
  List<DilemmaChoice> get choices {
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_choices);
  }

  /// Ek bağlam bilgisi (ör: tıbbi etik kuralı referansı)
  @override
  final String? contextInfo;

  /// İkilem kategorisi (ör: "mahremiyet", "kaynak_dagitimi", "bilgilendirme")
  @override
  final String? category;

  @override
  String toString() {
    return 'EthicalDilemma(id: $id, title: $title, description: $description, triggerPoint: $triggerPoint, choices: $choices, contextInfo: $contextInfo, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EthicalDilemmaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.triggerPoint, triggerPoint) ||
                other.triggerPoint == triggerPoint) &&
            const DeepCollectionEquality().equals(other._choices, _choices) &&
            (identical(other.contextInfo, contextInfo) ||
                other.contextInfo == contextInfo) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    triggerPoint,
    const DeepCollectionEquality().hash(_choices),
    contextInfo,
    category,
  );

  /// Create a copy of EthicalDilemma
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EthicalDilemmaImplCopyWith<_$EthicalDilemmaImpl> get copyWith =>
      __$$EthicalDilemmaImplCopyWithImpl<_$EthicalDilemmaImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EthicalDilemmaImplToJson(this);
  }
}

abstract class _EthicalDilemma implements EthicalDilemma {
  const factory _EthicalDilemma({
    final String id,
    final String title,
    final String description,
    final String triggerPoint,
    final List<DilemmaChoice> choices,
    final String? contextInfo,
    final String? category,
  }) = _$EthicalDilemmaImpl;

  factory _EthicalDilemma.fromJson(Map<String, dynamic> json) =
      _$EthicalDilemmaImpl.fromJson;

  @override
  String get id;

  /// İkilem başlığı (ör: "Hasta Mahremiyeti")
  @override
  String get title;

  /// Durum açıklaması — oyuncuya gösterilir
  @override
  String get description;

  /// Ne zaman tetiklenir:
  /// - "before_solution" → Teşhis & Tedavi tabına geçerken
  /// - "after_evidence_ev_001" → Belirli kanıt açıldığında
  /// - "after_deduction_ded_001" → Belirli çıkarım bulunduğunda
  /// - "on_game_start" → Oyun başladığında
  @override
  String get triggerPoint;

  /// Seçenekler (tam olarak 2 adet)
  @override
  List<DilemmaChoice> get choices;

  /// Ek bağlam bilgisi (ör: tıbbi etik kuralı referansı)
  @override
  String? get contextInfo;

  /// İkilem kategorisi (ör: "mahremiyet", "kaynak_dagitimi", "bilgilendirme")
  @override
  String? get category;

  /// Create a copy of EthicalDilemma
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EthicalDilemmaImplCopyWith<_$EthicalDilemmaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
