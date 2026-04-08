// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuestionAnswer _$QuestionAnswerFromJson(Map<String, dynamic> json) {
  return _QuestionAnswer.fromJson(json);
}

/// @nodoc
mixin _$QuestionAnswer {
  String get question => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;

  /// Bu cevap kritik bir bulgu mu
  bool get isClue => throw _privateConstructorUsedError;

  /// Bu cevap tahlil sonuçlarıyla çelişiyor mu
  bool get isContradiction => throw _privateConstructorUsedError;

  /// Çelişki çözüldüğünde ortaya çıkan gerçek cevap
  String? get truthReveal => throw _privateConstructorUsedError;

  /// Bu çelişkinin ilişkili olduğu tıbbi veri ID'si
  String? get contradictionEvidenceId => throw _privateConstructorUsedError;

  /// Serializes this QuestionAnswer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuestionAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionAnswerCopyWith<QuestionAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionAnswerCopyWith<$Res> {
  factory $QuestionAnswerCopyWith(
    QuestionAnswer value,
    $Res Function(QuestionAnswer) then,
  ) = _$QuestionAnswerCopyWithImpl<$Res, QuestionAnswer>;
  @useResult
  $Res call({
    String question,
    String answer,
    bool isClue,
    bool isContradiction,
    String? truthReveal,
    String? contradictionEvidenceId,
  });
}

/// @nodoc
class _$QuestionAnswerCopyWithImpl<$Res, $Val extends QuestionAnswer>
    implements $QuestionAnswerCopyWith<$Res> {
  _$QuestionAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? answer = null,
    Object? isClue = null,
    Object? isContradiction = null,
    Object? truthReveal = freezed,
    Object? contradictionEvidenceId = freezed,
  }) {
    return _then(
      _value.copyWith(
            question: null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                      as String,
            answer: null == answer
                ? _value.answer
                : answer // ignore: cast_nullable_to_non_nullable
                      as String,
            isClue: null == isClue
                ? _value.isClue
                : isClue // ignore: cast_nullable_to_non_nullable
                      as bool,
            isContradiction: null == isContradiction
                ? _value.isContradiction
                : isContradiction // ignore: cast_nullable_to_non_nullable
                      as bool,
            truthReveal: freezed == truthReveal
                ? _value.truthReveal
                : truthReveal // ignore: cast_nullable_to_non_nullable
                      as String?,
            contradictionEvidenceId: freezed == contradictionEvidenceId
                ? _value.contradictionEvidenceId
                : contradictionEvidenceId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestionAnswerImplCopyWith<$Res>
    implements $QuestionAnswerCopyWith<$Res> {
  factory _$$QuestionAnswerImplCopyWith(
    _$QuestionAnswerImpl value,
    $Res Function(_$QuestionAnswerImpl) then,
  ) = __$$QuestionAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String question,
    String answer,
    bool isClue,
    bool isContradiction,
    String? truthReveal,
    String? contradictionEvidenceId,
  });
}

/// @nodoc
class __$$QuestionAnswerImplCopyWithImpl<$Res>
    extends _$QuestionAnswerCopyWithImpl<$Res, _$QuestionAnswerImpl>
    implements _$$QuestionAnswerImplCopyWith<$Res> {
  __$$QuestionAnswerImplCopyWithImpl(
    _$QuestionAnswerImpl _value,
    $Res Function(_$QuestionAnswerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuestionAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? answer = null,
    Object? isClue = null,
    Object? isContradiction = null,
    Object? truthReveal = freezed,
    Object? contradictionEvidenceId = freezed,
  }) {
    return _then(
      _$QuestionAnswerImpl(
        question: null == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as String,
        answer: null == answer
            ? _value.answer
            : answer // ignore: cast_nullable_to_non_nullable
                  as String,
        isClue: null == isClue
            ? _value.isClue
            : isClue // ignore: cast_nullable_to_non_nullable
                  as bool,
        isContradiction: null == isContradiction
            ? _value.isContradiction
            : isContradiction // ignore: cast_nullable_to_non_nullable
                  as bool,
        truthReveal: freezed == truthReveal
            ? _value.truthReveal
            : truthReveal // ignore: cast_nullable_to_non_nullable
                  as String?,
        contradictionEvidenceId: freezed == contradictionEvidenceId
            ? _value.contradictionEvidenceId
            : contradictionEvidenceId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionAnswerImpl implements _QuestionAnswer {
  const _$QuestionAnswerImpl({
    this.question = '',
    this.answer = '',
    this.isClue = false,
    this.isContradiction = false,
    this.truthReveal,
    this.contradictionEvidenceId,
  });

  factory _$QuestionAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionAnswerImplFromJson(json);

  @override
  @JsonKey()
  final String question;
  @override
  @JsonKey()
  final String answer;

  /// Bu cevap kritik bir bulgu mu
  @override
  @JsonKey()
  final bool isClue;

  /// Bu cevap tahlil sonuçlarıyla çelişiyor mu
  @override
  @JsonKey()
  final bool isContradiction;

  /// Çelişki çözüldüğünde ortaya çıkan gerçek cevap
  @override
  final String? truthReveal;

  /// Bu çelişkinin ilişkili olduğu tıbbi veri ID'si
  @override
  final String? contradictionEvidenceId;

  @override
  String toString() {
    return 'QuestionAnswer(question: $question, answer: $answer, isClue: $isClue, isContradiction: $isContradiction, truthReveal: $truthReveal, contradictionEvidenceId: $contradictionEvidenceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionAnswerImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.isClue, isClue) || other.isClue == isClue) &&
            (identical(other.isContradiction, isContradiction) ||
                other.isContradiction == isContradiction) &&
            (identical(other.truthReveal, truthReveal) ||
                other.truthReveal == truthReveal) &&
            (identical(
                  other.contradictionEvidenceId,
                  contradictionEvidenceId,
                ) ||
                other.contradictionEvidenceId == contradictionEvidenceId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    question,
    answer,
    isClue,
    isContradiction,
    truthReveal,
    contradictionEvidenceId,
  );

  /// Create a copy of QuestionAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionAnswerImplCopyWith<_$QuestionAnswerImpl> get copyWith =>
      __$$QuestionAnswerImplCopyWithImpl<_$QuestionAnswerImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionAnswerImplToJson(this);
  }
}

abstract class _QuestionAnswer implements QuestionAnswer {
  const factory _QuestionAnswer({
    final String question,
    final String answer,
    final bool isClue,
    final bool isContradiction,
    final String? truthReveal,
    final String? contradictionEvidenceId,
  }) = _$QuestionAnswerImpl;

  factory _QuestionAnswer.fromJson(Map<String, dynamic> json) =
      _$QuestionAnswerImpl.fromJson;

  @override
  String get question;
  @override
  String get answer;

  /// Bu cevap kritik bir bulgu mu
  @override
  bool get isClue;

  /// Bu cevap tahlil sonuçlarıyla çelişiyor mu
  @override
  bool get isContradiction;

  /// Çelişki çözüldüğünde ortaya çıkan gerçek cevap
  @override
  String? get truthReveal;

  /// Bu çelişkinin ilişkili olduğu tıbbi veri ID'si
  @override
  String? get contradictionEvidenceId;

  /// Create a copy of QuestionAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionAnswerImplCopyWith<_$QuestionAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Interview _$InterviewFromJson(Map<String, dynamic> json) {
  return _Interview.fromJson(json);
}

/// @nodoc
mixin _$Interview {
  String get id => throw _privateConstructorUsedError;

  /// Görüşülen kişinin ID'si
  String get personId => throw _privateConstructorUsedError;

  /// Görüşme başlığı
  String get title => throw _privateConstructorUsedError;

  /// Görüşülen kişinin adı
  String? get personName => throw _privateConstructorUsedError;

  /// Kişi tipi (hasta, yakın, hemşire)
  InterviewPersonType get personType => throw _privateConstructorUsedError;

  /// Kişi fotoğrafı
  String? get personPhotoPath => throw _privateConstructorUsedError;

  /// Görüşme tarihi/saati
  String? get dateTime => throw _privateConstructorUsedError;

  /// Soru-cevap listesi
  List<QuestionAnswer> get transcript => throw _privateConstructorUsedError;

  /// Ses kaydı dosya yolu
  String? get audioPath => throw _privateConstructorUsedError;

  /// Görüşme özeti
  String? get summary => throw _privateConstructorUsedError;

  /// Önemli bulgular
  List<String>? get keyFindings => throw _privateConstructorUsedError;

  /// Kilidi açık mı
  bool get isUnlocked => throw _privateConstructorUsedError;

  /// Tamamlandı mı
  bool get isCompleted => throw _privateConstructorUsedError;

  /// İnteraktif mi (mini oyun olarak oynanabilir)
  bool get isInteractive => throw _privateConstructorUsedError;

  /// Diyalog ağacı (interaktif görüşmeler için)
  List<DialogueNode>? get dialogueTree => throw _privateConstructorUsedError;

  /// Serializes this Interview to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Interview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InterviewCopyWith<Interview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterviewCopyWith<$Res> {
  factory $InterviewCopyWith(Interview value, $Res Function(Interview) then) =
      _$InterviewCopyWithImpl<$Res, Interview>;
  @useResult
  $Res call({
    String id,
    String personId,
    String title,
    String? personName,
    InterviewPersonType personType,
    String? personPhotoPath,
    String? dateTime,
    List<QuestionAnswer> transcript,
    String? audioPath,
    String? summary,
    List<String>? keyFindings,
    bool isUnlocked,
    bool isCompleted,
    bool isInteractive,
    List<DialogueNode>? dialogueTree,
  });
}

/// @nodoc
class _$InterviewCopyWithImpl<$Res, $Val extends Interview>
    implements $InterviewCopyWith<$Res> {
  _$InterviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Interview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? personId = null,
    Object? title = null,
    Object? personName = freezed,
    Object? personType = null,
    Object? personPhotoPath = freezed,
    Object? dateTime = freezed,
    Object? transcript = null,
    Object? audioPath = freezed,
    Object? summary = freezed,
    Object? keyFindings = freezed,
    Object? isUnlocked = null,
    Object? isCompleted = null,
    Object? isInteractive = null,
    Object? dialogueTree = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            personId: null == personId
                ? _value.personId
                : personId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            personName: freezed == personName
                ? _value.personName
                : personName // ignore: cast_nullable_to_non_nullable
                      as String?,
            personType: null == personType
                ? _value.personType
                : personType // ignore: cast_nullable_to_non_nullable
                      as InterviewPersonType,
            personPhotoPath: freezed == personPhotoPath
                ? _value.personPhotoPath
                : personPhotoPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateTime: freezed == dateTime
                ? _value.dateTime
                : dateTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            transcript: null == transcript
                ? _value.transcript
                : transcript // ignore: cast_nullable_to_non_nullable
                      as List<QuestionAnswer>,
            audioPath: freezed == audioPath
                ? _value.audioPath
                : audioPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            summary: freezed == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String?,
            keyFindings: freezed == keyFindings
                ? _value.keyFindings
                : keyFindings // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            isUnlocked: null == isUnlocked
                ? _value.isUnlocked
                : isUnlocked // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            isInteractive: null == isInteractive
                ? _value.isInteractive
                : isInteractive // ignore: cast_nullable_to_non_nullable
                      as bool,
            dialogueTree: freezed == dialogueTree
                ? _value.dialogueTree
                : dialogueTree // ignore: cast_nullable_to_non_nullable
                      as List<DialogueNode>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InterviewImplCopyWith<$Res>
    implements $InterviewCopyWith<$Res> {
  factory _$$InterviewImplCopyWith(
    _$InterviewImpl value,
    $Res Function(_$InterviewImpl) then,
  ) = __$$InterviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String personId,
    String title,
    String? personName,
    InterviewPersonType personType,
    String? personPhotoPath,
    String? dateTime,
    List<QuestionAnswer> transcript,
    String? audioPath,
    String? summary,
    List<String>? keyFindings,
    bool isUnlocked,
    bool isCompleted,
    bool isInteractive,
    List<DialogueNode>? dialogueTree,
  });
}

/// @nodoc
class __$$InterviewImplCopyWithImpl<$Res>
    extends _$InterviewCopyWithImpl<$Res, _$InterviewImpl>
    implements _$$InterviewImplCopyWith<$Res> {
  __$$InterviewImplCopyWithImpl(
    _$InterviewImpl _value,
    $Res Function(_$InterviewImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Interview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? personId = null,
    Object? title = null,
    Object? personName = freezed,
    Object? personType = null,
    Object? personPhotoPath = freezed,
    Object? dateTime = freezed,
    Object? transcript = null,
    Object? audioPath = freezed,
    Object? summary = freezed,
    Object? keyFindings = freezed,
    Object? isUnlocked = null,
    Object? isCompleted = null,
    Object? isInteractive = null,
    Object? dialogueTree = freezed,
  }) {
    return _then(
      _$InterviewImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        personId: null == personId
            ? _value.personId
            : personId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        personName: freezed == personName
            ? _value.personName
            : personName // ignore: cast_nullable_to_non_nullable
                  as String?,
        personType: null == personType
            ? _value.personType
            : personType // ignore: cast_nullable_to_non_nullable
                  as InterviewPersonType,
        personPhotoPath: freezed == personPhotoPath
            ? _value.personPhotoPath
            : personPhotoPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateTime: freezed == dateTime
            ? _value.dateTime
            : dateTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        transcript: null == transcript
            ? _value._transcript
            : transcript // ignore: cast_nullable_to_non_nullable
                  as List<QuestionAnswer>,
        audioPath: freezed == audioPath
            ? _value.audioPath
            : audioPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        summary: freezed == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String?,
        keyFindings: freezed == keyFindings
            ? _value._keyFindings
            : keyFindings // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        isUnlocked: null == isUnlocked
            ? _value.isUnlocked
            : isUnlocked // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        isInteractive: null == isInteractive
            ? _value.isInteractive
            : isInteractive // ignore: cast_nullable_to_non_nullable
                  as bool,
        dialogueTree: freezed == dialogueTree
            ? _value._dialogueTree
            : dialogueTree // ignore: cast_nullable_to_non_nullable
                  as List<DialogueNode>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InterviewImpl implements _Interview {
  const _$InterviewImpl({
    this.id = '',
    this.personId = '',
    this.title = '',
    this.personName,
    this.personType = InterviewPersonType.patient,
    this.personPhotoPath,
    this.dateTime,
    final List<QuestionAnswer> transcript = const [],
    this.audioPath,
    this.summary,
    final List<String>? keyFindings,
    this.isUnlocked = true,
    this.isCompleted = false,
    this.isInteractive = false,
    final List<DialogueNode>? dialogueTree,
  }) : _transcript = transcript,
       _keyFindings = keyFindings,
       _dialogueTree = dialogueTree;

  factory _$InterviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$InterviewImplFromJson(json);

  @override
  @JsonKey()
  final String id;

  /// Görüşülen kişinin ID'si
  @override
  @JsonKey()
  final String personId;

  /// Görüşme başlığı
  @override
  @JsonKey()
  final String title;

  /// Görüşülen kişinin adı
  @override
  final String? personName;

  /// Kişi tipi (hasta, yakın, hemşire)
  @override
  @JsonKey()
  final InterviewPersonType personType;

  /// Kişi fotoğrafı
  @override
  final String? personPhotoPath;

  /// Görüşme tarihi/saati
  @override
  final String? dateTime;

  /// Soru-cevap listesi
  final List<QuestionAnswer> _transcript;

  /// Soru-cevap listesi
  @override
  @JsonKey()
  List<QuestionAnswer> get transcript {
    if (_transcript is EqualUnmodifiableListView) return _transcript;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transcript);
  }

  /// Ses kaydı dosya yolu
  @override
  final String? audioPath;

  /// Görüşme özeti
  @override
  final String? summary;

  /// Önemli bulgular
  final List<String>? _keyFindings;

  /// Önemli bulgular
  @override
  List<String>? get keyFindings {
    final value = _keyFindings;
    if (value == null) return null;
    if (_keyFindings is EqualUnmodifiableListView) return _keyFindings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Kilidi açık mı
  @override
  @JsonKey()
  final bool isUnlocked;

  /// Tamamlandı mı
  @override
  @JsonKey()
  final bool isCompleted;

  /// İnteraktif mi (mini oyun olarak oynanabilir)
  @override
  @JsonKey()
  final bool isInteractive;

  /// Diyalog ağacı (interaktif görüşmeler için)
  final List<DialogueNode>? _dialogueTree;

  /// Diyalog ağacı (interaktif görüşmeler için)
  @override
  List<DialogueNode>? get dialogueTree {
    final value = _dialogueTree;
    if (value == null) return null;
    if (_dialogueTree is EqualUnmodifiableListView) return _dialogueTree;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Interview(id: $id, personId: $personId, title: $title, personName: $personName, personType: $personType, personPhotoPath: $personPhotoPath, dateTime: $dateTime, transcript: $transcript, audioPath: $audioPath, summary: $summary, keyFindings: $keyFindings, isUnlocked: $isUnlocked, isCompleted: $isCompleted, isInteractive: $isInteractive, dialogueTree: $dialogueTree)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterviewImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.personId, personId) ||
                other.personId == personId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.personName, personName) ||
                other.personName == personName) &&
            (identical(other.personType, personType) ||
                other.personType == personType) &&
            (identical(other.personPhotoPath, personPhotoPath) ||
                other.personPhotoPath == personPhotoPath) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            const DeepCollectionEquality().equals(
              other._transcript,
              _transcript,
            ) &&
            (identical(other.audioPath, audioPath) ||
                other.audioPath == audioPath) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(
              other._keyFindings,
              _keyFindings,
            ) &&
            (identical(other.isUnlocked, isUnlocked) ||
                other.isUnlocked == isUnlocked) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.isInteractive, isInteractive) ||
                other.isInteractive == isInteractive) &&
            const DeepCollectionEquality().equals(
              other._dialogueTree,
              _dialogueTree,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    personId,
    title,
    personName,
    personType,
    personPhotoPath,
    dateTime,
    const DeepCollectionEquality().hash(_transcript),
    audioPath,
    summary,
    const DeepCollectionEquality().hash(_keyFindings),
    isUnlocked,
    isCompleted,
    isInteractive,
    const DeepCollectionEquality().hash(_dialogueTree),
  );

  /// Create a copy of Interview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InterviewImplCopyWith<_$InterviewImpl> get copyWith =>
      __$$InterviewImplCopyWithImpl<_$InterviewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InterviewImplToJson(this);
  }
}

abstract class _Interview implements Interview {
  const factory _Interview({
    final String id,
    final String personId,
    final String title,
    final String? personName,
    final InterviewPersonType personType,
    final String? personPhotoPath,
    final String? dateTime,
    final List<QuestionAnswer> transcript,
    final String? audioPath,
    final String? summary,
    final List<String>? keyFindings,
    final bool isUnlocked,
    final bool isCompleted,
    final bool isInteractive,
    final List<DialogueNode>? dialogueTree,
  }) = _$InterviewImpl;

  factory _Interview.fromJson(Map<String, dynamic> json) =
      _$InterviewImpl.fromJson;

  @override
  String get id;

  /// Görüşülen kişinin ID'si
  @override
  String get personId;

  /// Görüşme başlığı
  @override
  String get title;

  /// Görüşülen kişinin adı
  @override
  String? get personName;

  /// Kişi tipi (hasta, yakın, hemşire)
  @override
  InterviewPersonType get personType;

  /// Kişi fotoğrafı
  @override
  String? get personPhotoPath;

  /// Görüşme tarihi/saati
  @override
  String? get dateTime;

  /// Soru-cevap listesi
  @override
  List<QuestionAnswer> get transcript;

  /// Ses kaydı dosya yolu
  @override
  String? get audioPath;

  /// Görüşme özeti
  @override
  String? get summary;

  /// Önemli bulgular
  @override
  List<String>? get keyFindings;

  /// Kilidi açık mı
  @override
  bool get isUnlocked;

  /// Tamamlandı mı
  @override
  bool get isCompleted;

  /// İnteraktif mi (mini oyun olarak oynanabilir)
  @override
  bool get isInteractive;

  /// Diyalog ağacı (interaktif görüşmeler için)
  @override
  List<DialogueNode>? get dialogueTree;

  /// Create a copy of Interview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InterviewImplCopyWith<_$InterviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
