import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/phone_data.dart';
import 'phone_apps/messages_app.dart';
import 'phone_apps/gallery_app.dart';
import 'phone_apps/dialer_app.dart';
import 'package:easy_localization/easy_localization.dart';

/// Sahte telefon arayüzü ana ekranı
class FakePhoneScreen extends StatefulWidget {
  final PhoneData phoneData;
  final String? ownerName;

  final String cdnBaseUrl;

  const FakePhoneScreen({
    super.key,
    required this.phoneData,
    this.ownerName,
    required this.cdnBaseUrl,
  });

  @override
  State<FakePhoneScreen> createState() => _FakePhoneScreenState();
}

class _FakePhoneScreenState extends State<FakePhoneScreen> {
  Widget? _currentApp;

  @override
  void initState() {
    super.initState();
    // Tam ekran mod
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    // Normal moda dön
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _openApp(Widget app) {
    setState(() => _currentApp = app);
  }

  void _closeApp() {
    setState(() => _currentApp = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            // Telefon duvar kağıdı
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1a1a2e),
                const Color(0xFF16213e),
                const Color(0xFF0f3460),
              ],
            ),
          ),
          child: Column(
            children: [
              // Status Bar
              _buildStatusBar(),
              
              // Ana içerik
              Expanded(
                child: _currentApp ?? _buildHomeScreen(),
              ),
              
              // Navigation Bar
              _buildNavigationBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Saat
          Text(
            '21:15',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          // Notch space
          Container(
            width: 80,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          
          // Sağ ikonlar
          Row(
            children: [
              Icon(Icons.signal_cellular_4_bar, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Icon(Icons.wifi, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Icon(Icons.battery_full, color: Colors.white, size: 16),
              Text(
                ' 87%',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHomeScreen() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Spacer(),
          
          // Telefon sahibi
          if (widget.ownerName != null) ...[
            Text(
              widget.ownerName!,
              style: GoogleFonts.roboto(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
          ],
          
          // App Grid
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85,
            children: [
              _buildAppIcon(
                icon: Icons.message,
                label: 'phone.messages'.tr(),
                color: Colors.green,
                badge: widget.phoneData.chats.length,
                onTap: () => _openApp(
                  MessagesApp(
                    chats: widget.phoneData.chats,
                    onBack: _closeApp,
                    cdnBaseUrl: widget.cdnBaseUrl,
                  ),
                ),
              ),
              _buildAppIcon(
                icon: Icons.phone,
                label: 'phone.phone'.tr(),
                color: Colors.orange,
                badge: widget.phoneData.callHistory.where((c) => c.status == CallStatus.missed).length,
                onTap: () => _openApp(
                  DialerApp(
                    calls: widget.phoneData.callHistory,
                    onBack: _closeApp,
                  ),
                ),
              ),
              _buildAppIcon(
                icon: Icons.photo_library,
                label: 'phone.gallery'.tr(),
                color: Colors.purple,
                onTap: () => _openApp(
                  GalleryApp(
                    images: widget.phoneData.galleryImages,
                    onBack: _closeApp,
                    cdnBaseUrl: widget.cdnBaseUrl,
                  ),
                ),
              ),
              _buildAppIcon(
                icon: Icons.settings,
                label: 'phone.settings'.tr(),
                color: Colors.grey,
                onTap: () {
                  // Ayarlar şu an aktif değil
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('phone.no_settings_access'.tr())),
                  );
                },
              ),
            ],
          ),
          
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget _buildAppIcon({
    required IconData icon,
    required String label,
    required Color color,
    int badge = 0,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              if (badge > 0)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      badge.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Geri butonu
          IconButton(
            onPressed: () {
              if (_currentApp != null) {
                _closeApp();
              } else {
                Navigator.of(context).pop();
              }
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white54,
              size: 20,
            ),
          ),
          
          // Home butonu
          GestureDetector(
            onTap: () {
              if (_currentApp != null) {
                _closeApp();
              }
            },
            child: Container(
              width: 100,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          
          // Recent apps
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.close,
              color: Colors.white54,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
