import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/credit_balance.dart';

part 'credit_state.freezed.dart';

/// Kredi sistemi durumu
///
/// UI bu duruma gore ekranlari gunceller.
@freezed
sealed class CreditState with _$CreditState {
  /// Baslangic durumu
  const factory CreditState.initial() = CreditInitial;

  /// Yukleniyor
  const factory CreditState.loading() = CreditLoading;

  /// Yuklendi
  const factory CreditState.loaded(CreditBalance balance) = CreditLoaded;

  /// Hata
  const factory CreditState.error(String message) = CreditError;
}
