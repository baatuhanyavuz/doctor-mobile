import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// Merkezi ses yöneticisi - Singleton yapısında
/// Web platformu için ses bağlamı kilidi desteği içerir
class SoundManager {
  static final SoundManager instance = SoundManager._internal();
  SoundManager._internal();

  final AudioPlayer _sfxPlayer = AudioPlayer();
  final AudioPlayer _loopPlayer = AudioPlayer();
  bool _isInitialized = false;
  bool _audioContextUnlocked = false;

  /// Ses dosyaları listesi (preload için)
  static const List<String> _soundFiles = [
    'chemical_fizz',
    'judge_gavel',
    'liquid_pour',
    'neon_hum',
    'page_flip',
    'paper_slide',
    'pin_push',
    'string_tighten',
    'switch_click',
    'typewriter_key',
  ];

  /// Ses bağlamının kilidinin açılıp açılmadığını kontrol et
  bool get isAudioContextUnlocked => _audioContextUnlocked || !kIsWeb;

  /// Web'de ses bağlamı kilidi açılması gerekiyor mu?
  bool get needsAudioUnlock => kIsWeb && !_audioContextUnlocked;

  /// Sesleri önbelleğe al
  Future<void> init() async {
    if (_isInitialized) return;
    
    try {
      // AudioPlayer ayarları
      await _sfxPlayer.setReleaseMode(ReleaseMode.stop);
      await _loopPlayer.setReleaseMode(ReleaseMode.loop);
      
      // Web'de preload atla (ses bağlamı kilidi açılana kadar)
      if (!kIsWeb) {
        // Sesleri preload et (Android için önemli)
        for (final sound in _soundFiles) {
          try {
            await AudioCache.instance.load('audio/$sound.mp3');
          } catch (e) {
            // Dosya yoksa sessizce devam et
          }
        }
      }
      
      _isInitialized = true;
    } catch (e) {
      // Ses sistemi başlatılamazsa uygulama çalışmaya devam etsin
      debugPrint('SoundManager init error: $e');
    }
  }

  /// Web'de ses bağlamını aç (kullanıcı etkileşiminden sonra çağır)
  /// "Soruşturmaya Başla" butonundan çağrılmalı
  Future<void> unlockAudioContext() async {
    if (!kIsWeb || _audioContextUnlocked) return;
    
    try {
      // Sessiz bir ses çalarak audio context'i aç
      await _sfxPlayer.setVolume(0.0);
      await _sfxPlayer.play(AssetSource('audio/switch_click.mp3'));
      await Future.delayed(const Duration(milliseconds: 100));
      await _sfxPlayer.stop();
      await _sfxPlayer.setVolume(1.0);
      
      _audioContextUnlocked = true;
      debugPrint('Audio context unlocked successfully');
      
      // Şimdi sesleri preload et
      for (final sound in _soundFiles) {
        try {
          await AudioCache.instance.load('audio/$sound.mp3');
        } catch (e) {
          // Dosya yoksa sessizce devam et
        }
      }
    } catch (e) {
      debugPrint('Failed to unlock audio context: $e');
      // Hata olsa bile devam et, bazı tarayıcılarda farklı davranabilir
      _audioContextUnlocked = true;
    }
  }

  /// Tek seferlik ses efekti çal
  Future<void> playSfx(String fileName) async {
    // Web'de ses bağlamı açık değilse atla
    if (kIsWeb && !_audioContextUnlocked) {
      debugPrint('Audio context not unlocked, skipping sfx: $fileName');
      return;
    }
    
    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource('audio/$fileName.mp3'));
    } catch (e) {
      // Ses çalamazsa sessizce devam et
      debugPrint('Failed to play sfx $fileName: $e');
    }
  }

  /// Döngüsel ses başlat (UV ışığı vb.)
  Future<void> playLoop(String fileName) async {
    // Web'de ses bağlamı açık değilse atla
    if (kIsWeb && !_audioContextUnlocked) {
      debugPrint('Audio context not unlocked, skipping loop: $fileName');
      return;
    }
    
    try {
      await _loopPlayer.stop();
      await _loopPlayer.setReleaseMode(ReleaseMode.loop);
      await _loopPlayer.play(AssetSource('audio/$fileName.mp3'));
    } catch (e) {
      // Ses çalamazsa sessizce devam et
      debugPrint('Failed to play loop $fileName: $e');
    }
  }

  /// Döngüsel sesi durdur
  Future<void> stopLoop() async {
    try {
      await _loopPlayer.stop();
    } catch (e) {
      // Hata durumunda sessizce devam et
    }
  }

  /// Tüm sesleri durdur
  Future<void> stopAll() async {
    await _sfxPlayer.stop();
    await _loopPlayer.stop();
  }

  /// Kaynakları serbest bırak
  void dispose() {
    _sfxPlayer.dispose();
    _loopPlayer.dispose();
  }
}
