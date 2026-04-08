import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/config_provider.dart';

/// Uygulama versiyonunu backend config ile karşılaştırıp
/// güncelleme dialog'u gösteren widget.
/// Dashboard'un üstüne sarılır, uygulama açıldığında bir kez kontrol eder.
class UpdateChecker extends ConsumerStatefulWidget {
  final Widget child;
  const UpdateChecker({super.key, required this.child});

  @override
  ConsumerState<UpdateChecker> createState() => _UpdateCheckerState();
}

class _UpdateCheckerState extends ConsumerState<UpdateChecker> {
  bool _checked = false;

  // Compile-time sabit — pubspec.yaml'daki version
  static const _currentVersion = '1.0.4';

  @override
  Widget build(BuildContext context) {
    // Config yüklendiğinde bir kez kontrol et
    if (!_checked) {
      ref.listen(appConfigProvider, (prev, next) {
        next.whenData((config) {
          if (_checked) return;
          _checked = true;
          _checkForUpdate(context, config);
        });
      });
    }

    return widget.child;
  }

  void _checkForUpdate(BuildContext context, Map<String, String> config) {
    final latestVersion = config['latest_app_version'];
    final minVersion = config['min_app_version'];
    final forceUpdate = config['force_update'] == 'true';
    final message = config['update_message'] ?? 'Yeni bir güncelleme mevcut!';

    if (latestVersion == null) return;

    final current = _parseVersion(_currentVersion);
    final latest = _parseVersion(latestVersion);
    final min = minVersion != null ? _parseVersion(minVersion) : null;

    // Zorunlu güncelleme: mevcut versiyon minimum'un altında
    final isForceRequired = min != null && _compareVersions(current, min) < 0;

    // Opsiyonel güncelleme: mevcut versiyon latest'in altında
    final isUpdateAvailable = _compareVersions(current, latest) < 0;

    if (isForceRequired || forceUpdate) {
      _showUpdateDialog(context, message, latestVersion, config, mandatory: true);
    } else if (isUpdateAvailable) {
      _showUpdateDialog(context, message, latestVersion, config, mandatory: false);
    }
  }

  void _showUpdateDialog(
    BuildContext context,
    String message,
    String latestVersion,
    Map<String, String> config, {
    required bool mandatory,
  }) {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: !mandatory,
      builder: (ctx) => PopScope(
        canPop: !mandatory,
        child: AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: mandatory
                  ? const Color(0xFFCF6679).withValues(alpha: 0.5)
                  : const Color(0xFF03DAC6).withValues(alpha: 0.3),
            ),
          ),
          title: Row(
            children: [
              Icon(
                mandatory ? Icons.system_update : Icons.upgrade_rounded,
                color: mandatory
                    ? const Color(0xFFCF6679)
                    : const Color(0xFF03DAC6),
                size: 28,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  mandatory ? 'update.required_title'.tr() : 'update.available_title'.tr(),
                  style: GoogleFonts.specialElite(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: GoogleFonts.merriweather(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'v$_currentVersion',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white38,
                        fontSize: 13,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(Icons.arrow_forward, color: Colors.white24, size: 16),
                    ),
                    Text(
                      'v$latestVersion',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFF03DAC6),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            if (!mandatory)
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(
                  'update.later'.tr(),
                  style: const TextStyle(color: Colors.white38),
                ),
              ),
            FilledButton.icon(
              onPressed: () => _openStore(config),
              icon: const Icon(Icons.download_rounded, size: 18),
              label: Text('update.update_now'.tr()),
              style: FilledButton.styleFrom(
                backgroundColor: mandatory
                    ? const Color(0xFFCF6679)
                    : const Color(0xFF03DAC6),
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openStore(Map<String, String> config) async {
    String? url;
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        url = config['update_url_android'];
      } else if (Platform.isIOS) {
        url = config['update_url_ios'];
      }
    }
    if (url != null) {
      try {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } catch (_) {}
    }
  }

  /// "1.2.3" -> [1, 2, 3]
  static List<int> _parseVersion(String version) {
    return version.split('.').map((s) => int.tryParse(s) ?? 0).toList();
  }

  /// -1: a < b, 0: a == b, 1: a > b
  static int _compareVersions(List<int> a, List<int> b) {
    for (var i = 0; i < 3; i++) {
      final va = i < a.length ? a[i] : 0;
      final vb = i < b.length ? b[i] : 0;
      if (va < vb) return -1;
      if (va > vb) return 1;
    }
    return 0;
  }
}
