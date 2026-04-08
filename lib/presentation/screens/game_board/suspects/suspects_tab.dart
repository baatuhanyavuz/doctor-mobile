import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/app_image.dart';
import 'package:doctor/data/models/diagnosis.dart';
import '../../../providers/config_provider.dart';

class SuspectsTab extends ConsumerWidget {
  final List<Diagnosis> suspects;

  const SuspectsTab({super.key, required this.suspects});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (suspects.isEmpty) {
      return Center(child: Text('suspects.no_suspects'.tr()));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: suspects.length,
      itemBuilder: (context, index) {
        final suspect = suspects[index];
        return _SuspectCard(suspect: suspect);
      },
    );
  }
}

class _SuspectCard extends ConsumerWidget {
  final Diagnosis suspect;

  const _SuspectCard({required this.suspect});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cdnBaseUrl = ref.watch(cdnBaseUrlProvider);
    return GestureDetector(
      onTap: () {
        _showSuspectDetails(context, suspect, cdnBaseUrl);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF132038),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF00BFA5).withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Üst Başlık: Olası Teşhis
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF00BFA5).withOpacity(0.15),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(7)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'OLASI TEŞHİS',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF00BFA5),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
            ),
            
            // Fotoğraf
            Expanded(
              child: Container(
                color: Colors.grey[900],
                child: suspect.photoPath != null && suspect.photoPath!.isNotEmpty
                    ? AppImage(
                        path: suspect.photoPath!,
                        cdnBaseUrl: cdnBaseUrl,
                        fit: BoxFit.cover,
                        errorWidget: const Icon(Icons.person, size: 50, color: Colors.white24),
                      )
                    : const Icon(Icons.person, size: 50, color: Colors.white24),
              ),
            ),
            
            // Alt Bilgiler
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(7)),
              ),
              child: Column(
                children: [
                  Text(
                    suspect.name.toUpperCase(),
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    suspect.category ?? '',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFF42A5F5),
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuspectDetails(BuildContext context, Diagnosis suspect, String? cdnBaseUrl) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0A1628),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[800],
                    backgroundImage: suspect.photoPath != null && suspect.photoPath!.isNotEmpty ? appImageProvider(suspect.photoPath!, cdnBaseUrl) : null,
                    child: suspect.photoPath == null || suspect.photoPath!.isEmpty ? const Icon(Icons.person, size: 40) : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          suspect.name,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          suspect.category ?? 'common.unknown'.tr(),
                          style: TextStyle(color: const Color(0xFF42A5F5)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              const Divider(color: Colors.white10),
              const SizedBox(height: 16),
              
              _DetailSection(title: 'AÇIKLAMA', content: suspect.biography ?? 'Bilgi yok.'),
              _DetailSection(title: 'TEŞHİS DETAYI', content: suspect.description ?? 'Bilinmiyor.'),
              _DetailSection(title: 'AYIRICI NOTLAR', content: suspect.differentialNotes ?? 'Yok.'),
              _DetailSection(title: 'KATEGORİ', content: suspect.category ?? 'Bilinmiyor'),

              if (suspect.personalityTraits != null) ...[
                const SizedBox(height: 16),
                Text(
                  'BELİRTİLER',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF00BFA5),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: suspect.personalityTraits!.map((trait) => Chip(
                    label: Text(trait),
                    backgroundColor: Colors.white10,
                    labelStyle: const TextStyle(color: Colors.white70, fontSize: 12),
                    padding: EdgeInsets.zero,
                  )).toList(),
                ),
              ],
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final String title;
  final String content;

  const _DetailSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.robotoMono(
              color: const Color(0xFF00BFA5),
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.inter(
              color: Colors.white70,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
