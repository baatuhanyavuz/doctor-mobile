import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// 1x1 transparent pixel — network bağımlılığı olmadan placeholder
final _kTransparentPixel = Uint8List.fromList([
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, // PNG header
  0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
  0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41,
  0x54, 0x78, 0x9C, 0x62, 0x00, 0x00, 0x00, 0x02,
  0x00, 0x01, 0xE5, 0x27, 0xDE, 0xFC, 0x00, 0x00,
  0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42,
  0x60, 0x82,
]);

/// CDN veya local asset'ten akıllı şekilde image yükleyen widget.
class AppImage extends StatelessWidget {
  final String? path;
  final String? cdnBaseUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AppImage({
    super.key,
    required this.path,
    this.cdnBaseUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (path == null || path!.isEmpty) {
      return _buildError();
    }

    final resolvedUrl = _resolveUrl(path!, cdnBaseUrl);

    // Eğer URL ise network'ten yükle
    if (resolvedUrl.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: resolvedUrl,
        fit: fit,
        width: width,
        height: height,
        placeholder: (context, url) =>
            placeholder ??
            Container(
              width: width ?? double.infinity,
              height: height ?? double.infinity,
              color: Colors.grey[900],
              child: const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white30,
                  ),
                ),
              ),
            ),
        errorWidget: (context, url, error) {
          debugPrint('❌ [AppImage] Error loading network image: $url');
          debugPrint('❌ [AppImage] Exception details: $error');
          return _buildError();
        },
      );
    }

    // Fallback: local asset
    return Image.asset(
      resolvedUrl,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('❌ [AppImage] Error loading local asset: $resolvedUrl');
        return _buildError();
      },
    );
  }

  Widget _buildError() {
    return errorWidget ??
        Container(
          width: width,
          height: height,
          color: Colors.grey[900],
          child: const Center(
            child: Icon(Icons.broken_image, color: Colors.white24, size: 40),
          ),
        );
  }

  /// URL çözümleme: path zaten http ile başlıyorsa olduğu gibi kullan,
  /// değilse cdnBaseUrl + path birleştir. Güvenli birleştirme yapar.
  static String _resolveUrl(String path, String? cdnBaseUrl) {
    if (path.startsWith('http')) return path;
    if (cdnBaseUrl != null && cdnBaseUrl.isNotEmpty) {
      // Çift slash (//) oluşmasını engellemek için trim yapıyoruz
      final cleanBase = cdnBaseUrl.endsWith('/') 
          ? cdnBaseUrl.substring(0, cdnBaseUrl.length - 1) 
          : cdnBaseUrl;
      final cleanPath = path.startsWith('/') ? path : '/$path';
      return '$cleanBase$cleanPath';
    }
    return path; // fallback to local asset path
  }
}

/// ImageProvider döndüren helper fonksiyon.
/// CircleAvatar.backgroundImage, DecorationImage.image gibi
/// ImageProvider bekleyen yerler için kullanılır.
ImageProvider appImageProvider(String? path, String? cdnBaseUrl) {
  if (path == null || path.isEmpty) {
    // Transparent 1px pixel — network bağımlılığı yok, 404 crash'i önler
    return MemoryImage(_kTransparentPixel);
  }

  final resolvedUrl = AppImage._resolveUrl(path, cdnBaseUrl);

  if (resolvedUrl.startsWith('http')) {
    return CachedNetworkImageProvider(
      resolvedUrl,
      errorListener: (err) {
        debugPrint('❌ [appImageProvider] Error loading network provider image: $resolvedUrl');
        debugPrint('❌ [appImageProvider] Exception details: $err');
      }
    );
  }

  return AssetImage(resolvedUrl);
}
