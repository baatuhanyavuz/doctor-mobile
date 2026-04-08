import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/ethical_dilemma_provider.dart';

/// Etik Kurul Savunması — itibar 20 altına düşünce tetiklenen mini oyun.
/// Oyuncu malpraktis geçmişi üzerinden sorgulanır ve savunma yapar.
class EthicalBoardScreen extends ConsumerStatefulWidget {
  const EthicalBoardScreen({super.key});

  @override
  ConsumerState<EthicalBoardScreen> createState() => _EthicalBoardScreenState();
}

class _EthicalBoardScreenState extends ConsumerState<EthicalBoardScreen> {
  int _currentQuestion = 0;
  int _correctAnswers = 0;
  bool _isFinished = false;

  // Etik kurul soruları — sabit havuz
  static const _questions = [
    _BoardQuestion(
      scenario: 'Bir hasta acil servise getirildi. Teşhis koymadan önce pahalı bir MR çektirdiniz ama sonuç normaldi.',
      question: 'Bu durumda doğru yaklaşım neydi?',
      options: [
        'MR çektirmek her zaman güvenli bir yaklaşımdır',
        'Önce klinik muayene ve basit testlerle değerlendirmeli, gerekliyse MR istenmeliydi',
        'Hasta isterse her test yapılmalıdır',
      ],
      correctIndex: 1,
      explanation: 'Gereksiz tetkikler hem hastaya hem sağlık sistemine yük olur. Kademeli tanı yaklaşımı esastır.',
    ),
    _BoardQuestion(
      scenario: 'Hastanıza tedavi uygularken alerjik geçmişini kontrol etmeyi unuttunuz ve komplikasyon gelişti.',
      question: 'Bundan sonra ne yapmalısınız?',
      options: [
        'Komplikasyonu gizleyip tedaviye devam etmek',
        'Hastayı ve yakınlarını bilgilendirip gerekli müdahaleyi yapmak',
        'Sorumluluğu hemşireye yüklemek',
      ],
      correctIndex: 1,
      explanation: 'Tıbbi hata durumunda şeffaflık ve hasta güvenliği önceliklidir. Hataların gizlenmesi daha büyük sorunlara yol açar.',
    ),
    _BoardQuestion(
      scenario: 'KKD giymeden bulaşıcı bir hastaya müdahale ettiniz ve enfekte oldunuz.',
      question: 'Bu deneyimden çıkarılacak ders nedir?',
      options: [
        'Acil durumlarda KKD önemsizdir',
        'Her hastaya yaklaşmadan önce uygun KKD giyilmelidir',
        'Sadece COVID hastalarında KKD gereklidir',
      ],
      correctIndex: 1,
      explanation: 'KKD hem sağlık çalışanını hem diğer hastaları korur. Standart önlemler her hasta için geçerlidir.',
    ),
    _BoardQuestion(
      scenario: 'Bir meslektaşınız hastaya yanlış ilaç verdiğini fark ettiniz.',
      question: 'Ne yapmalısınız?',
      options: [
        'Meslektaşınızla özel konuşup durumu düzeltmesini istemek ve hastayı bilgilendirmek',
        'Görmezden gelmek — herkes hata yapar',
        'Doğrudan sosyal medyada paylaşmak',
      ],
      correctIndex: 0,
      explanation: 'Hasta güvenliği önce gelir. Meslektaş dayanışması hataları örtbas etmek değil, birlikte düzeltmektir.',
    ),
    _BoardQuestion(
      scenario: 'Hasta yakını tedavi hakkında internet araştırması yapıp size itiraz ediyor.',
      question: 'Doğru yaklaşım nedir?',
      options: [
        'Hastayı dinlemeyi reddetmek',
        'Sakin bir şekilde endişelerini dinlemek ve bilimsel kanıtlarla açıklamak',
        'Haklısınız deyip tedaviyi değiştirmek',
      ],
      correctIndex: 1,
      explanation: 'Hasta ve yakınlarıyla açık iletişim tedaviye uyumu artırır. Empati göstermek profesyonelliğin parçasıdır.',
    ),
  ];

  void _answerQuestion(int selectedIndex) {
    final question = _questions[_currentQuestion];
    if (selectedIndex == question.correctIndex) {
      _correctAnswers++;
    }

    setState(() {
      if (_currentQuestion < _questions.length - 1) {
        _currentQuestion++;
      } else {
        _isFinished = true;
        final success = _correctAnswers >= 3; // 5 üzerinden 3 doğru = geçti
        ref.read(reputationProvider.notifier).completeEthicalBoard(success);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      appBar: AppBar(
        backgroundColor: const Color(0xFF132038),
        title: Text(
          'ETİK KURUL SAVUNMASI',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 2),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: _isFinished ? _buildResult() : _buildQuestion(),
      ),
    );
  }

  Widget _buildQuestion() {
    final q = _questions[_currentQuestion];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // İlerleme
          Row(
            children: [
              Text(
                'Soru ${_currentQuestion + 1}/${_questions.length}',
                style: GoogleFonts.robotoMono(color: Colors.white54, fontSize: 12),
              ),
              const Spacer(),
              Text(
                'Doğru: $_correctAnswers',
                style: GoogleFonts.robotoMono(color: const Color(0xFF66BB6A), fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (_currentQuestion + 1) / _questions.length,
            backgroundColor: Colors.white10,
            valueColor: const AlwaysStoppedAnimation(Color(0xFF00BFA5)),
          ),
          const SizedBox(height: 32),

          // Senaryo
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF132038),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.description, color: Color(0xFFFFB74D), size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'SENARYO',
                      style: GoogleFonts.robotoMono(color: const Color(0xFFFFB74D), fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  q.scenario,
                  style: GoogleFonts.inter(color: Colors.white70, fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Soru
          Text(
            q.question,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Seçenekler
          ...q.options.asMap().entries.map((entry) {
            final i = entry.key;
            final option = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => _answerQuestion(i),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF132038),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF00BFA5).withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF00BFA5).withOpacity(0.4)),
                        ),
                        child: Center(
                          child: Text(
                            String.fromCharCode(65 + i),
                            style: GoogleFonts.robotoMono(color: const Color(0xFF00BFA5), fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          option,
                          style: GoogleFonts.inter(color: Colors.white70, fontSize: 13, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildResult() {
    final success = _correctAnswers >= 3;
    final color = success ? const Color(0xFF66BB6A) : const Color(0xFFEF5350);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              success ? Icons.gavel : Icons.warning_amber_rounded,
              color: color,
              size: 72,
            ),
            const SizedBox(height: 24),
            Text(
              success ? 'SAVUNMA KABUL EDİLDİ' : 'SAVUNMA REDDEDİLDİ',
              style: GoogleFonts.poppins(color: color, fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              success
                  ? 'Etik kurul savunmanızı kabul etti. İtibar puanınız +15 iyileşti. Bundan sonra daha dikkatli olun.'
                  : 'Etik kurul savunmanızı yeterli bulmadı. İtibar puanınız değişmedi. Daha dikkatli olmanız gerekiyor.',
              style: GoogleFonts.inter(color: Colors.white60, fontSize: 14, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Sonuç: $_correctAnswers/${_questions.length} doğru',
              style: GoogleFonts.robotoMono(color: Colors.white38, fontSize: 13),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color.withOpacity(0.15),
                  foregroundColor: color,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: color.withOpacity(0.3)),
                  ),
                ),
                child: Text(
                  'DEVAM ET',
                  style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BoardQuestion {
  final String scenario;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const _BoardQuestion({
    required this.scenario,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}
