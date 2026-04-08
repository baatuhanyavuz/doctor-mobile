import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/utils/sound_manager.dart';
import '../../core/widgets/app_image.dart';
import '../../data/models/case.dart';
import '../providers/config_provider.dart';
/// Hasta Kabul Ekranı - Triaj ve hasta gelişi anlatımı
class BriefingScreen extends ConsumerStatefulWidget {
  final Case gameCase;
  final VoidCallback onAccept;

  const BriefingScreen({
    super.key,
    required this.gameCase,
    required this.onAccept,
  });

  @override
  ConsumerState<BriefingScreen> createState() => _BriefingScreenState();
}

class _BriefingScreenState extends ConsumerState<BriefingScreen>
    with TickerProviderStateMixin {
  late AnimationController _stampController;
  late Animation<double> _stampScale;
  late Animation<double> _stampOpacity;
  
  bool _showContent = false;
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    
    // Damga animasyonu
    _stampController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _stampScale = Tween<double>(begin: 3.0, end: 1.0).animate(
      CurvedAnimation(parent: _stampController, curve: Curves.elasticOut),
    );
    
    _stampOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _stampController, curve: Curves.easeIn),
    );
    
    // Animasyon sırası
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    await Future.delayed(const Duration(milliseconds: 500));
    SoundManager.instance.playSfx('page_flip');
    _stampController.forward();
    
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => _showContent = true);
    
    await Future.delayed(const Duration(milliseconds: 2000));
    if (mounted) setState(() => _showButton = true);
  }

  @override
  void dispose() {
    _stampController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      body: Stack(
        children: [
          // Arka plan dokusu
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: AppImage(
                  path: widget.gameCase.coverImage,
                  cdnBaseUrl: ref.watch(cdnBaseUrlProvider),
                fit: BoxFit.cover,
                  errorWidget: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF132038), Color(0xFF0A1628)],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // İçerik
          SafeArea(
            child: Column(
              children: [
                // Başlık çubuğu
                _buildHeader(),
                
                // Ana içerik
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // GİZLİ Damgası
                        _buildStamp(),
                        
                        const SizedBox(height: 24),
                        
                        // Dosya numarası
                        _buildCaseNumber(),
                        
                        const SizedBox(height: 24),
                        
                        // Kurban bilgileri
                        if (_showContent) ...[
                          _buildVictimCard(),
                          const SizedBox(height: 24),
                          
                          // Hikaye metni (Daktilo efekti)
                          _buildStoryText(),
                          
                          const SizedBox(height: 24),
                          
                          // Resmi rapor
                          if (widget.gameCase.nurseReport != null)
                            _buildOfficialReport(),
                        ],
                        
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
                
                // Kabul butonu
                if (_showButton) _buildAcceptButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        border: const Border(
          bottom: BorderSide(color: Colors.white10),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white70),
          ),
          const SizedBox(width: 8),
          Text(
            'briefing.case_file'.tr(),
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 14,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStamp() {
    return AnimatedBuilder(
      animation: _stampController,
      builder: (context, child) {
        return Transform.scale(
          scale: _stampScale.value,
          child: Opacity(
            opacity: _stampOpacity.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF00BFA5), width: 3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Transform.rotate(
                angle: -0.1,
                child: Text(
                  'briefing.classified'.tr(),
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF00BFA5),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCaseNumber() {
    return AnimatedOpacity(
      opacity: _showContent ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Column(
        children: [
          Text(
            widget.gameCase.title.toUpperCase(),
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Container(
            height: 1,
            width: 100,
            color: Colors.white24,
          ),
        ],
      ),
    );
  }

  Widget _buildVictimCard() {
    final patient = widget.gameCase.patient;
    final clinicName = widget.gameCase.clinic;
    final vitals = patient.vitals;

    return AnimatedOpacity(
      opacity: _showContent ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF132038),
          border: Border.all(color: const Color(0xFF00BFA5).withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Hasta fotoğrafı
                Container(
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: patient.photoPath != null
                        ? AppImage(
                            path: patient.photoPath!,
                            cdnBaseUrl: ref.watch(cdnBaseUrlProvider),
                            fit: BoxFit.cover,
                            errorWidget: _buildPlaceholderPhoto(),
                          )
                        : _buildPlaceholderPhoto(),
                  ),
                ),

                const SizedBox(width: 16),

                // Hasta bilgileri
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'briefing.patient'.tr(),
                        style: GoogleFonts.robotoMono(
                          color: const Color(0xFF00BFA5),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        patient.name,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (patient.age != null)
                        Text(
                          'briefing.age_occupation'.tr(namedArgs: {'age': patient.age.toString(), 'occupation': patient.occupation != null ? ' \u2022 ${patient.occupation}' : ''}),
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.local_hospital, color: Color(0xFF42A5F5), size: 14),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              clinicName ?? 'common.unknown'.tr(),
                              style: const TextStyle(
                                color: Colors.white38,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Vital bulgular
            if (vitals != null) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A1628),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFF42A5F5).withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (vitals.bloodPressure != null)
                      _buildVitalItem(Icons.favorite, 'TA', vitals.bloodPressure!, const Color(0xFFEF5350)),
                    if (vitals.heartRate != null)
                      _buildVitalItem(Icons.monitor_heart, 'Nabız', '${vitals.heartRate}', const Color(0xFF00BFA5)),
                    if (vitals.temperature != null)
                      _buildVitalItem(Icons.thermostat, 'Ateş', '${vitals.temperature}\u00B0C', const Color(0xFFFFD54F)),
                    if (vitals.oxygenSaturation != null)
                      _buildVitalItem(Icons.air, 'SpO2', '%${vitals.oxygenSaturation}', const Color(0xFF42A5F5)),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildVitalItem(IconData icon, String label, String value, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.robotoMono(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.robotoMono(
            color: Colors.white38,
            fontSize: 9,
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderPhoto() {
    return Container(
      color: const Color(0xFF0A1628),
      child: const Icon(
        Icons.person,
        color: Color(0xFF42A5F5),
        size: 40,
      ),
    );
  }

  Widget _buildStoryText() {
    final introText = widget.gameCase.introText ?? widget.gameCase.fullDescription;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF132038),
        border: Border.all(color: const Color(0xFF66BB6A).withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.description, color: const Color(0xFF66BB6A), size: 18),
              const SizedBox(width: 8),
              Text(
                'briefing.case_summary'.tr(),
                style: GoogleFonts.robotoMono(
                  color: const Color(0xFF66BB6A),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DefaultTextStyle(
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.85),
              fontSize: 14,
              height: 1.7,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  introText,
                  speed: const Duration(milliseconds: 30),
                ),
              ],
              isRepeatingAnimation: false,
              displayFullTextOnTap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfficialReport() {
    return AnimatedOpacity(
      opacity: _showContent ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF42A5F5).withOpacity(0.1),
          border: Border.all(color: const Color(0xFF42A5F5).withOpacity(0.4)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.assignment, color: Color(0xFF42A5F5), size: 18),
                const SizedBox(width: 8),
                Text(
                  'briefing.official_report'.tr(),
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF42A5F5),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.gameCase.nurseReport!,
              style: GoogleFonts.robotoMono(
                color: Colors.white70,
                fontSize: 12,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAcceptButton() {
    return AnimatedOpacity(
      opacity: _showButton ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: widget.onAccept,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00BFA5),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_add, size: 20),
              const SizedBox(width: 12),
              Text(
                'briefing.accept_case'.tr(),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
