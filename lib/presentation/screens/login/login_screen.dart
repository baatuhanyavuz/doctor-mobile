import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/auth_providers.dart';
import '../../providers/auth_state.dart';
import 'email_login_screen.dart';
import 'register_screen.dart';
import 'web_google_button_stub.dart'
    if (dart.library.html) 'web_google_button.dart';

/// Medikal temalı giriş ekranı
///
/// Doktor oyunu teması ile
/// Google Sign-In butonu sunar.
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    // Hata durumunda snackbar göster
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: const Color(0xFF00BFA5),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    final isLoading = authState is AuthLoading;

    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ─── Logo / İkon ─────────────────────────────
                _buildLogo(),
                const SizedBox(height: 40),

                // ─── Başlık ──────────────────────────────────
                Text(
                  'login.title'.tr(),
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withValues(alpha: 0.9),
                    letterSpacing: 6,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'login.subtitle'.tr(),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFF00BFA5),
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 60,
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        const Color(0xFF00BFA5).withValues(alpha: 0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // ─── Slogan ──────────────────────────────────
                Text(
                  'login.tagline'.tr(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white54,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 60),

                // ─── Google Sign-In Butonu ────────────────────
                if (kIsWeb)
                  _WebGoogleSignInButton(
                    isLoading: isLoading,
                  )
                else
                  _GoogleSignInButton(
                    isLoading: isLoading,
                    onPressed: isLoading
                        ? null
                        : () {
                            ref
                                .read(authNotifierProvider.notifier)
                                .signInWithGoogle();
                          },
                  ),

                // ─── Apple Sign-In Butonu (iOS only) ─────────
                if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: isLoading
                            ? null
                            : () => ref.read(authNotifierProvider.notifier).signInWithApple(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.apple, size: 24),
                        label: Text(
                          'Apple ile Giriş Yap',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                // ─── Ayırıcı ─────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.white12,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'common.or'.tr(),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.white24,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.white12,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // ─── E-posta ile Giriş ────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const EmailLoginScreen(),
                              ),
                            );
                          },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white70,
                      side: const BorderSide(color: Color(0xFF3E3E3E)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.email_outlined, size: 20),
                        const SizedBox(width: 10),
                        Text(
                          'login.email_sign_in'.tr(),
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ─── Hesap Oluştur ────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const RegisterScreen(),
                              ),
                            );
                          },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF00BFA5),
                      side: const BorderSide(color: Color(0xFF00BFA5), width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.person_add_outlined, size: 20),
                        const SizedBox(width: 10),
                        Text(
                          'login.create_account'.tr(),
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ─── Alt bilgi ───────────────────────────────
                Text(
                  'login.agree_prefix'.tr(),
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: Colors.white24,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => launchUrl(Uri.parse(AppConstants.privacyPolicyUrl)),
                      child: Text(
                        'login.privacy_policy'.tr(),
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: const Color(0xFF00BFA5),
                          decoration: TextDecoration.underline,
                          decorationColor: const Color(0xFF00BFA5),
                        ),
                      ),
                    ),
                    Text(
                      'login.and'.tr(),
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: Colors.white24,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => launchUrl(Uri.parse(AppConstants.termsOfServiceUrl)),
                      child: Text(
                        'login.terms_of_service'.tr(),
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: const Color(0xFF00BFA5),
                          decoration: TextDecoration.underline,
                          decorationColor: const Color(0xFF00BFA5),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'login.agree_suffix'.tr(),
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: Colors.white24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF00BFA5).withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00BFA5).withValues(alpha: 0.15),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.local_hospital,
          size: 64,
          color: const Color(0xFF00BFA5).withValues(alpha: 0.7),
        ),
      ),
    );
  }
}

/// Google Sign-In butonu
///
/// Google'ın marka yönergelerine uygun tasarım.
class _GoogleSignInButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const _GoogleSignInButton({
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          elevation: 2,
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Color(0xFF4285F4),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google "G" logosu
                  _buildGoogleLogo(),
                  const SizedBox(width: 12),
                  Text(
                    'login.google_sign_in'.tr(),
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildGoogleLogo() {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: _GoogleLogoPainter(),
      ),
    );
  }
}

/// Google "G" logosunu çizen CustomPainter
class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double cx = w / 2;
    final double cy = h / 2;
    final double r = w * 0.45;

    // Mavi bölüm (sağ üst)
    final bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.18
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      -0.6, // ~-35 derece
      1.4, // ~80 derece
      false,
      bluePaint,
    );

    // Yeşil bölüm (sağ alt)
    final greenPaint = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.18
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      0.8,
      1.0,
      false,
      greenPaint,
    );

    // Sarı bölüm (sol alt)
    final yellowPaint = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.18
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      1.8,
      1.0,
      false,
      yellowPaint,
    );

    // Kırmızı bölüm (sol üst)
    final redPaint = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.18
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      2.8,
      1.0,
      false,
      redPaint,
    );

    // Mavi çizgi (sağ taraf yatay)
    final barPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(cx, cy - w * 0.09, w * 0.45, w * 0.18),
      barPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Web-specific Google Sign-In Button
///
/// Uses Google's official GIS renderButton via google_sign_in_web.
/// The deprecated signIn() popup no longer works due to Google's COOP headers.
/// renderButton uses the modern GIS flow instead.
class _WebGoogleSignInButton extends ConsumerWidget {
  final bool isLoading;

  const _WebGoogleSignInButton({
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isLoading) {
      return const SizedBox(
        height: 52,
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Color(0xFF4285F4),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: buildPlatformGoogleButton(),
    );
  }
}
