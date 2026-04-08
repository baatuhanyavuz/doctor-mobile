import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/case_providers.dart';

/// Şehir Haberleri — Dashboard'da canlı haber ticker
class NewsTicker extends ConsumerStatefulWidget {
  const NewsTicker({super.key});

  @override
  ConsumerState<NewsTicker> createState() => _NewsTickerState();
}

class _NewsTickerState extends ConsumerState<NewsTicker> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 6), (_) {
      if (mounted) setState(() => _currentIndex++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final completedAsync = ref.watch(completedCaseIdsProvider);
    final completedIds = completedAsync.valueOrNull ?? {};

    // Haberleri oluştur
    final news = _generateNews(completedIds);
    if (news.isEmpty) return const SizedBox.shrink();

    final current = news[_currentIndex % news.length];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF132038),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF00BFA5).withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFEF5350),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'ŞEHİR HABERLERİ',
                style: GoogleFonts.robotoMono(
                  color: Colors.white38,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const Spacer(),
              Text(
                '${(_currentIndex % news.length) + 1}/${news.length}',
                style: TextStyle(color: Colors.white24, fontSize: 9),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Haber içeriği (animasyonlu geçiş)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Row(
              key: ValueKey(_currentIndex),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(current.icon, color: current.color, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        current.title,
                        style: GoogleFonts.inter(
                          color: current.color,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        current.body,
                        style: TextStyle(color: Colors.white54, fontSize: 11, height: 1.3),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<_NewsItem> _generateNews(Set<String> completedIds) {
    final news = <_NewsItem>[];

    // Genel haberler (her zaman)
    news.add(const _NewsItem(
      icon: Icons.local_hospital,
      title: 'Sağlık Bakanlığı Açıklaması',
      body: 'Grip vakalarında artış gözleniyor. Vatandaşlardan dikkatli olmaları istendi.',
      color: Color(0xFF42A5F5),
    ));

    news.add(const _NewsItem(
      icon: Icons.science,
      title: 'Yeni Araştırma',
      body: 'Erken teşhisin tedavi başarısını %40 artırdığı bilimsel olarak kanıtlandı.',
      color: Color(0xFF66BB6A),
    ));

    // Tamamlanan vakalara göre kişiselleştirilmiş haberler
    if (completedIds.contains('case_001')) {
      news.add(const _NewsItem(
        icon: Icons.check_circle,
        title: 'Hasta Taburcu: Ahmet Yılmaz',
        body: 'Pulmoner emboli tedavisi tamamlanan hasta sağlığına kavuştu. Doktoruna teşekkürlerini iletti.',
        color: Color(0xFF00BFA5),
      ));
    }

    if (completedIds.contains('case_002')) {
      news.add(const _NewsItem(
        icon: Icons.vaccines,
        title: 'Aşı Kampanyası Başlatıldı',
        body: 'Kızamık vakası sonrası bölgede aşılama kampanyası başlatıldı. 500 çocuk aşılandı.',
        color: Color(0xFFFF9800),
      ));
    }

    if (completedIds.contains('case_003')) {
      news.add(const _NewsItem(
        icon: Icons.emoji_people,
        title: 'Hatice Koç İyileşti',
        body: 'Epley manevrası ile tedavi edilen hasta günlük hayatına döndü. "İnme sandım" dedi.',
        color: Color(0xFF00BFA5),
      ));
    }

    // Genel tıp dünyası haberleri
    news.add(const _NewsItem(
      icon: Icons.trending_up,
      title: 'Tıp Kongresi',
      body: 'Bu yılki ulusal tıp kongresinde yapay zeka destekli teşhis sistemleri tartışıldı.',
      color: Color(0xFF9C27B0),
    ));

    news.add(const _NewsItem(
      icon: Icons.warning_amber,
      title: 'Mevsimsel Uyarı',
      body: 'Kış aylarında D-vitamini eksikliğine dikkat! Düzenli tahlil yaptırmanız önerilir.',
      color: Color(0xFFFFB74D),
    ));

    return news;
  }
}

class _NewsItem {
  final IconData icon;
  final String title;
  final String body;
  final Color color;

  const _NewsItem({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });
}
