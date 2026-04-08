import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/app_image.dart';
import 'package:easy_localization/easy_localization.dart';

/// Galeri uygulaması
class GalleryApp extends StatefulWidget {
  final List<String> images;
  final VoidCallback onBack;

  final String cdnBaseUrl;

  const GalleryApp({
    super.key,
    required this.images,
    required this.onBack,
    required this.cdnBaseUrl,
  });

  @override
  State<GalleryApp> createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  String? _selectedImage;

  @override
  Widget build(BuildContext context) {
    if (_selectedImage != null) {
      return _buildFullscreenImage(_selectedImage!);
    }
    return _buildGalleryGrid();
  }

  Widget _buildGalleryGrid() {
    return Column(
      children: [
        // App Bar
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              IconButton(
                onPressed: widget.onBack,
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(
                'phone.gallery'.tr(),
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '${widget.images.length} fotoğraf',
                style: TextStyle(color: Colors.white54),
              ),
            ],
          ),
        ),
        
        // Photo grid
        Expanded(
          child: widget.images.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.photo_library, size: 64, color: Colors.white24),
                      const SizedBox(height: 16),
                      Text(
                        'phone.no_photos'.tr(),
                        style: TextStyle(color: Colors.white38),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(4),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: widget.images.length,
                  itemBuilder: (context, index) {
                    final imagePath = widget.images[index];
                    return GestureDetector(
                      onTap: () => setState(() => _selectedImage = imagePath),
                      child: AppImage(
                        path: imagePath,
                        cdnBaseUrl: widget.cdnBaseUrl,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFullscreenImage(String imagePath) {
    return GestureDetector(
      onTap: () => setState(() => _selectedImage = null),
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                child: AppImage(
                  path: imagePath,
                  cdnBaseUrl: widget.cdnBaseUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            // Close button
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                onPressed: () => setState(() => _selectedImage = null),
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
