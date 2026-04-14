import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Yeni kullanıcıya zorluk seviyelerini tanıtan onboarding ekranı.
/// İlk giriş sonrası bir kez gösterilir, "shown" bayrağı SharedPreferences'te tutulur.
class DifficultyOnboardingScreen extends StatefulWidget {
  const DifficultyOnboardingScreen({super.key});

  static const _prefsKey = 'difficulty_onboarding_shown';

  /// Onboarding daha önce gösterilmiş mi?
  static Future<bool> hasBeenShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefsKey) ?? false;
  }

  /// Gösterildi olarak işaretle
  static Future<void> markAsShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, true);
  }

  @override
  State<DifficultyOnboardingScreen> createState() =>
      _DifficultyOnboardingScreenState();
}

class _DifficultyOnboardingScreenState
    extends State<DifficultyOnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  static const _bgColor = Color(0xFF0A1628);

  final List<_OnboardingSlide> _slides = [
    _OnboardingSlide(
      title: 'STAJYER',
      color: const Color(0xFF66BB6A),
      icon: Icons.medical_services_outlined,
      subtitle: 'Halk diliyle anlatılan vakalar',
      description:
          'Tıp bilgisi olmayan herkes çözebilir. Günlük hayatta karşılaşılan durumlar — alerji, kan şekeri düşüklüğü, böbrek taşı gibi.',
      example:
          '"12 yaşında bir çocuk, parktan dönerken aniden dudakları şişmeye başlamış..."',
    ),
    _OnboardingSlide(
      title: 'SAĞLIKÇI',
      color: const Color(0xFFFFB74D),
      icon: Icons.local_hospital,
      subtitle: 'Orta seviye tıbbi bilgi',
      description:
          'Hemşire, sağlık memuru veya tıp öğrencisi seviyesi. Bazı tıbbi terimler kullanılır ama parantez içinde açıklanır.',
      example:
          '"AST ve ALT değerleri yüksek — karaciğer hasar görmüş. Siroz (karaciğer nasırlaşması) bulgusu..."',
    ),
    _OnboardingSlide(
      title: 'AÇILIN BEN DOKTORUM',
      color: const Color(0xFFEF5350),
      icon: Icons.emergency,
      subtitle: 'Tıp mezunu seviyesi',
      description:
          'Tıp fakültesi öğrencisi, pratisyen hekim, uzmanlık öğrencisi için. Tam tıbbi terminoloji, klinik skorlar, kısaltmalar — gerçek klinik dili.',
      example:
          '"NIHSS 12, ASPECTS 9, window time 30 dk — IV rtPA uygun. Kardiyoembolik etiyoloji..."',
    ),
    _OnboardingSlide(
      title: 'HİPOKRAT',
      color: const Color(0xFFAB47BC),
      icon: Icons.biotech,
      subtitle: 'Uzman seviyesi',
      description:
          'Yan dal uzmanı seviyesinde nadir sendromlar, karmaşık tanı, multidisipliner yaklaşım gerektiren vakalar.',
      example:
          '"Paraneoplastik sendrom şüphesi — anti-Hu pozitif. PET-CT ile gizli primer tümör aranmalı..."',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    HapticFeedback.lightImpact();
    await DifficultyOnboardingScreen.markAsShown();
    if (mounted) context.go('/cases');
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Üst bar: Atla butonu
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'ZORLUK SEVİYELERİ',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white38,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _finish,
                    child: Text(
                      'ATLA',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white54,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // PageView — slaytlar
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  return _SlideView(slide: _slides[index]);
                },
              ),
            ),

            // Sayfa indikatörleri
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_slides.length, (i) {
                  final isActive = i == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 28 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive
                          ? _slides[_currentPage].color
                          : Colors.white24,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),

            // Alt buton
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _slides[_currentPage].color.withOpacity(0.2),
                    foregroundColor: _slides[_currentPage].color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: _slides[_currentPage].color,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    _currentPage == _slides.length - 1
                        ? 'OYUNA BAŞLA'
                        : 'DEVAM',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlideView extends StatelessWidget {
  final _OnboardingSlide slide;

  const _SlideView({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // İkon (büyük, glow'lu)
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: slide.color.withOpacity(0.12),
              border: Border.all(
                color: slide.color.withOpacity(0.4),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: slide.color.withOpacity(0.2),
                  blurRadius: 40,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(slide.icon, color: slide.color, size: 72),
          ),
          const SizedBox(height: 32),

          // Başlık
          Text(
            slide.title,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: slide.color,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),

          // Alt başlık
          Text(
            slide.subtitle,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Açıklama
          Text(
            slide.description,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.white.withOpacity(0.85),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Örnek vaka kutusu
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: slide.color.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: slide.color.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.article_outlined, color: slide.color, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      'ÖRNEK',
                      style: GoogleFonts.robotoMono(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: slide.color,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  slide.example,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white60,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingSlide {
  final String title;
  final String subtitle;
  final String description;
  final String example;
  final Color color;
  final IconData icon;

  const _OnboardingSlide({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.example,
    required this.color,
    required this.icon,
  });
}
