import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/dio_client.dart';
import '../../core/services/notification_service.dart';

/// Enerji durumu
class EnergyState {
  final int energy;
  final int maxEnergy;
  final int secondsUntilNextRefill;

  const EnergyState({
    this.energy = 5,
    this.maxEnergy = 5,
    this.secondsUntilNextRefill = 0,
  });

  EnergyState copyWith({
    int? energy,
    int? maxEnergy,
    int? secondsUntilNextRefill,
  }) {
    return EnergyState(
      energy: energy ?? this.energy,
      maxEnergy: maxEnergy ?? this.maxEnergy,
      secondsUntilNextRefill: secondsUntilNextRefill ?? this.secondsUntilNextRefill,
    );
  }

  bool get hasEnergy => energy > 0;
  bool get isFull => energy >= maxEnergy;

  /// Sonraki dolum saati (geçerli)
  String get nextRefillFormatted {
    if (isFull) return '';
    if (secondsUntilNextRefill <= 0) return 'Yenileniyor...';
    final m = secondsUntilNextRefill ~/ 60;
    final s = secondsUntilNextRefill % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}

class EnergyNotifier extends StateNotifier<EnergyState> {
  final Ref _ref;
  Timer? _tickTimer;

  EnergyNotifier(this._ref) : super(const EnergyState()) {
    _startTick();
    fetchFromServer();
  }

  /// Her saniye geri sayım (UI gösterimi için)
  void _startTick() {
    _tickTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.isFull) return;
      if (state.secondsUntilNextRefill <= 0) {
        // Dolum süresi bitti — sunucudan tekrar al
        fetchFromServer();
      } else {
        state = state.copyWith(secondsUntilNextRefill: state.secondsUntilNextRefill - 1);
      }
    });
  }

  /// Sunucudan güncel enerji durumu al
  Future<void> fetchFromServer() async {
    try {
      final dio = _ref.read(dioProvider);
      final response = await dio.get(AppConstants.energyEndpoint);
      _updateFromJson(response.data);
    } catch (e) {
      debugPrint('[Energy] Fetch error: $e');
    }
  }

  /// Yanlış cevap sonrası enerji eksilt
  Future<void> consumeEnergy({int amount = 1}) async {
    try {
      final dio = _ref.read(dioProvider);
      final response = await dio.post(
        AppConstants.energyConsumeEndpoint,
        data: {'amount': amount},
      );
      _updateFromJson(response.data);

      // Enerji 0'a düştüyse, 15 dakika sonraya enerji dolumu bildirimi
      if (state.energy == 0) {
        _scheduleEnergyRefillNotification();
      }
    } catch (e) {
      debugPrint('[Energy] Consume error: $e');
    }
  }

  /// 15 dakika sonraya "1 enerjin doldu" bildirimi
  void _scheduleEnergyRefillNotification() {
    try {
      final notificationService = _ref.read(notificationServiceProvider);
      notificationService.scheduleLocalNotification(
        id: 9001, // Sabit ID — önceki scheduled notification varsa üzerine yazar
        title: '❤️ Enerjin Yenilendi!',
        body: '1 enerjin doldu. Yeni vakaları çözmeye hazır mısın?',
        delaySeconds: 15 * 60, // 15 dakika
        route: '/cases',
      );
      debugPrint('[Energy] Refill notification scheduled in 15 min');
    } catch (e) {
      debugPrint('[Energy] Notification schedule error: $e');
    }
  }

  /// Reklam izleyerek 1 enerji al
  Future<void> refillWithAd() async {
    try {
      final dio = _ref.read(dioProvider);
      final response = await dio.post(AppConstants.energyRefillAdEndpoint);
      _updateFromJson(response.data);
    } catch (e) {
      debugPrint('[Energy] Refill with ad error: $e');
    }
  }

  void _updateFromJson(dynamic data) {
    if (data == null) return;
    state = EnergyState(
      energy: (data['energy'] ?? 5) as int,
      maxEnergy: (data['maxEnergy'] ?? 5) as int,
      secondsUntilNextRefill: (data['secondsUntilNextRefill'] ?? 0) as int,
    );
  }

  @override
  void dispose() {
    _tickTimer?.cancel();
    super.dispose();
  }
}

final energyProvider = StateNotifierProvider<EnergyNotifier, EnergyState>((ref) {
  return EnergyNotifier(ref);
});
