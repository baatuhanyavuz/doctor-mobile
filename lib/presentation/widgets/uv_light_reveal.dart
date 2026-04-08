import 'package:flutter/material.dart';
import '../../core/utils/sound_manager.dart';
import '../../core/widgets/app_image.dart';

/// Kontrastlı görüntüleme efekti ile gizli katmanı ortaya çıkaran widget
///
/// Kullanıcı parmağını gezdirdikçe gizli katman sadece
/// parmağın olduğu dairesel alanda görünür hale gelir.
class UVLightReveal extends StatefulWidget {
  /// Normal görsel
  final String baseImagePath;
  
  /// Gizli katman görseli (UV altında görünecek)
  final String hiddenImagePath;
  
  /// Kontrast görüntüleme daire çapı
  final double revealRadius;

  /// CDN base URL
  final String? cdnBaseUrl;

  const UVLightReveal({
    super.key,
    required this.baseImagePath,
    required this.hiddenImagePath,
    this.revealRadius = 80,
    this.cdnBaseUrl,
  });

  @override
  State<UVLightReveal> createState() => _UVLightRevealState();
}

class _UVLightRevealState extends State<UVLightReveal> {
  Offset? _touchPosition;
  bool _isRevealing = false;

  @override
  void dispose() {
    SoundManager.instance.stopLoop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onPanStart: (details) {
            // Kontrast görüntüleme açılış sesi ve loop başlat
            SoundManager.instance.playSfx('switch_click');
            SoundManager.instance.playLoop('neon_hum');
            setState(() {
              _isRevealing = true;
              _touchPosition = details.localPosition;
            });
          },
          onPanUpdate: (details) {
            setState(() {
              _touchPosition = details.localPosition;
            });
          },
          onPanEnd: (_) {
            // Loop durdur ve kapanış sesi (kontrast)
            SoundManager.instance.stopLoop();
            SoundManager.instance.playSfx('switch_click');
            setState(() {
              _isRevealing = false;
              _touchPosition = null;
            });
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Base image (normal görsel)
              AppImage(
                path: widget.baseImagePath,
                cdnBaseUrl: widget.cdnBaseUrl,
                fit: BoxFit.contain,
                errorWidget: Container(
                  color: Colors.grey[900],
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.white54, size: 48),
                  ),
                ),
              ),
              
              // Hidden layer with UV reveal effect
              if (_isRevealing && _touchPosition != null)
                ClipPath(
                  clipper: _CircleClipper(
                    center: _touchPosition!,
                    radius: widget.revealRadius,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Hidden image
                      AppImage(
                        path: widget.hiddenImagePath,
                        cdnBaseUrl: widget.cdnBaseUrl,
                        fit: BoxFit.contain,
                        errorWidget: Container(
                          color: const Color(0xFF42A5F5).withOpacity(0.3),
                          child: const Center(
                            child: Icon(Icons.visibility_off, color: Color(0xFF42A5F5)),
                          ),
                        ),
                      ),
                      // Contrast glow overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment(
                              ((_touchPosition!.dx / constraints.maxWidth) * 2) - 1,
                              ((_touchPosition!.dy / constraints.maxHeight) * 2) - 1,
                            ),
                            radius: 0.3,
                            colors: [
                              const Color(0xFF00BFA5).withOpacity(0.0),
                              const Color(0xFF42A5F5).withOpacity(0.2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              
              // Contrast imaging glow ring effect
              if (_isRevealing && _touchPosition != null)
                Positioned(
                  left: _touchPosition!.dx - widget.revealRadius,
                  top: _touchPosition!.dy - widget.revealRadius,
                  child: Container(
                    width: widget.revealRadius * 2,
                    height: widget.revealRadius * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF42A5F5),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00BFA5).withOpacity(0.6),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                        BoxShadow(
                          color: const Color(0xFF42A5F5).withOpacity(0.3),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              
              // Contrast imaging hint (when not touching)
              if (!_isRevealing)
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A1628).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF42A5F5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.contrast, color: const Color(0xFF42A5F5), size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Kontrastli goruntuleme',
                            style: TextStyle(
                              color: const Color(0xFF42A5F5).withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Dairesel kesme clipper'ı
class _CircleClipper extends CustomClipper<Path> {
  final Offset center;
  final double radius;

  _CircleClipper({required this.center, required this.radius});

  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(covariant _CircleClipper oldClipper) {
    return oldClipper.center != center || oldClipper.radius != radius;
  }
}
