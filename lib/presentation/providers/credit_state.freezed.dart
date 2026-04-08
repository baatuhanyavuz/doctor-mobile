// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CreditState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CreditBalance balance) loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CreditBalance balance)? loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CreditBalance balance)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreditInitial value) initial,
    required TResult Function(CreditLoading value) loading,
    required TResult Function(CreditLoaded value) loaded,
    required TResult Function(CreditError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreditInitial value)? initial,
    TResult? Function(CreditLoading value)? loading,
    TResult? Function(CreditLoaded value)? loaded,
    TResult? Function(CreditError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreditInitial value)? initial,
    TResult Function(CreditLoading value)? loading,
    TResult Function(CreditLoaded value)? loaded,
    TResult Function(CreditError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditStateCopyWith<$Res> {
  factory $CreditStateCopyWith(
    CreditState value,
    $Res Function(CreditState) then,
  ) = _$CreditStateCopyWithImpl<$Res, CreditState>;
}

/// @nodoc
class _$CreditStateCopyWithImpl<$Res, $Val extends CreditState>
    implements $CreditStateCopyWith<$Res> {
  _$CreditStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreditState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CreditInitialImplCopyWith<$Res> {
  factory _$$CreditInitialImplCopyWith(
    _$CreditInitialImpl value,
    $Res Function(_$CreditInitialImpl) then,
  ) = __$$CreditInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreditInitialImplCopyWithImpl<$Res>
    extends _$CreditStateCopyWithImpl<$Res, _$CreditInitialImpl>
    implements _$$CreditInitialImplCopyWith<$Res> {
  __$$CreditInitialImplCopyWithImpl(
    _$CreditInitialImpl _value,
    $Res Function(_$CreditInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreditState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CreditInitialImpl implements CreditInitial {
  const _$CreditInitialImpl();

  @override
  String toString() {
    return 'CreditState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CreditInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CreditBalance balance) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CreditBalance balance)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CreditBalance balance)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreditInitial value) initial,
    required TResult Function(CreditLoading value) loading,
    required TResult Function(CreditLoaded value) loaded,
    required TResult Function(CreditError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreditInitial value)? initial,
    TResult? Function(CreditLoading value)? loading,
    TResult? Function(CreditLoaded value)? loaded,
    TResult? Function(CreditError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreditInitial value)? initial,
    TResult Function(CreditLoading value)? loading,
    TResult Function(CreditLoaded value)? loaded,
    TResult Function(CreditError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class CreditInitial implements CreditState {
  const factory CreditInitial() = _$CreditInitialImpl;
}

/// @nodoc
abstract class _$$CreditLoadingImplCopyWith<$Res> {
  factory _$$CreditLoadingImplCopyWith(
    _$CreditLoadingImpl value,
    $Res Function(_$CreditLoadingImpl) then,
  ) = __$$CreditLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreditLoadingImplCopyWithImpl<$Res>
    extends _$CreditStateCopyWithImpl<$Res, _$CreditLoadingImpl>
    implements _$$CreditLoadingImplCopyWith<$Res> {
  __$$CreditLoadingImplCopyWithImpl(
    _$CreditLoadingImpl _value,
    $Res Function(_$CreditLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreditState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CreditLoadingImpl implements CreditLoading {
  const _$CreditLoadingImpl();

  @override
  String toString() {
    return 'CreditState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CreditLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CreditBalance balance) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CreditBalance balance)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CreditBalance balance)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreditInitial value) initial,
    required TResult Function(CreditLoading value) loading,
    required TResult Function(CreditLoaded value) loaded,
    required TResult Function(CreditError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreditInitial value)? initial,
    TResult? Function(CreditLoading value)? loading,
    TResult? Function(CreditLoaded value)? loaded,
    TResult? Function(CreditError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreditInitial value)? initial,
    TResult Function(CreditLoading value)? loading,
    TResult Function(CreditLoaded value)? loaded,
    TResult Function(CreditError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class CreditLoading implements CreditState {
  const factory CreditLoading() = _$CreditLoadingImpl;
}

/// @nodoc
abstract class _$$CreditLoadedImplCopyWith<$Res> {
  factory _$$CreditLoadedImplCopyWith(
    _$CreditLoadedImpl value,
    $Res Function(_$CreditLoadedImpl) then,
  ) = __$$CreditLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CreditBalance balance});

  $CreditBalanceCopyWith<$Res> get balance;
}

/// @nodoc
class __$$CreditLoadedImplCopyWithImpl<$Res>
    extends _$CreditStateCopyWithImpl<$Res, _$CreditLoadedImpl>
    implements _$$CreditLoadedImplCopyWith<$Res> {
  __$$CreditLoadedImplCopyWithImpl(
    _$CreditLoadedImpl _value,
    $Res Function(_$CreditLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreditState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? balance = null}) {
    return _then(
      _$CreditLoadedImpl(
        null == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as CreditBalance,
      ),
    );
  }

  /// Create a copy of CreditState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CreditBalanceCopyWith<$Res> get balance {
    return $CreditBalanceCopyWith<$Res>(_value.balance, (value) {
      return _then(_value.copyWith(balance: value));
    });
  }
}

/// @nodoc

class _$CreditLoadedImpl implements CreditLoaded {
  const _$CreditLoadedImpl(this.balance);

  @override
  final CreditBalance balance;

  @override
  String toString() {
    return 'CreditState.loaded(balance: $balance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditLoadedImpl &&
            (identical(other.balance, balance) || other.balance == balance));
  }

  @override
  int get hashCode => Object.hash(runtimeType, balance);

  /// Create a copy of CreditState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditLoadedImplCopyWith<_$CreditLoadedImpl> get copyWith =>
      __$$CreditLoadedImplCopyWithImpl<_$CreditLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CreditBalance balance) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(balance);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CreditBalance balance)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(balance);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CreditBalance balance)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(balance);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreditInitial value) initial,
    required TResult Function(CreditLoading value) loading,
    required TResult Function(CreditLoaded value) loaded,
    required TResult Function(CreditError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreditInitial value)? initial,
    TResult? Function(CreditLoading value)? loading,
    TResult? Function(CreditLoaded value)? loaded,
    TResult? Function(CreditError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreditInitial value)? initial,
    TResult Function(CreditLoading value)? loading,
    TResult Function(CreditLoaded value)? loaded,
    TResult Function(CreditError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class CreditLoaded implements CreditState {
  const factory CreditLoaded(final CreditBalance balance) = _$CreditLoadedImpl;

  CreditBalance get balance;

  /// Create a copy of CreditState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreditLoadedImplCopyWith<_$CreditLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreditErrorImplCopyWith<$Res> {
  factory _$$CreditErrorImplCopyWith(
    _$CreditErrorImpl value,
    $Res Function(_$CreditErrorImpl) then,
  ) = __$$CreditErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CreditErrorImplCopyWithImpl<$Res>
    extends _$CreditStateCopyWithImpl<$Res, _$CreditErrorImpl>
    implements _$$CreditErrorImplCopyWith<$Res> {
  __$$CreditErrorImplCopyWithImpl(
    _$CreditErrorImpl _value,
    $Res Function(_$CreditErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreditState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$CreditErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CreditErrorImpl implements CreditError {
  const _$CreditErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'CreditState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CreditState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditErrorImplCopyWith<_$CreditErrorImpl> get copyWith =>
      __$$CreditErrorImplCopyWithImpl<_$CreditErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(CreditBalance balance) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(CreditBalance balance)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(CreditBalance balance)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreditInitial value) initial,
    required TResult Function(CreditLoading value) loading,
    required TResult Function(CreditLoaded value) loaded,
    required TResult Function(CreditError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CreditInitial value)? initial,
    TResult? Function(CreditLoading value)? loading,
    TResult? Function(CreditLoaded value)? loaded,
    TResult? Function(CreditError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreditInitial value)? initial,
    TResult Function(CreditLoading value)? loading,
    TResult Function(CreditLoaded value)? loaded,
    TResult Function(CreditError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CreditError implements CreditState {
  const factory CreditError(final String message) = _$CreditErrorImpl;

  String get message;

  /// Create a copy of CreditState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreditErrorImplCopyWith<_$CreditErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
