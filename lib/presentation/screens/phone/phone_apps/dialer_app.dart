import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/models/phone_data.dart';
import 'package:easy_localization/easy_localization.dart';

/// Telefon uygulaması (Arama geçmişi)
class DialerApp extends StatelessWidget {
  final List<PhoneCall> calls;
  final VoidCallback onBack;

  const DialerApp({
    super.key,
    required this.calls,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // App Bar
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(
                'phone.phone'.tr(),
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        
        // Tabs
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildTab('phone.recent_calls'.tr(), true),
              _buildTab('phone.contacts'.tr(), false),
              _buildTab('phone.keypad'.tr(), false),
            ],
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Call history
        Expanded(
          child: calls.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.phone_missed, size: 64, color: Colors.white24),
                      const SizedBox(height: 16),
                      Text(
                        'phone.no_call_history'.tr(),
                        style: TextStyle(color: Colors.white38),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: calls.length,
                  itemBuilder: (context, index) {
                    final call = calls[index];
                    return _buildCallTile(call);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? Colors.blue : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            color: isActive ? Colors.blue : Colors.white54,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildCallTile(PhoneCall call) {
    IconData icon;
    Color iconColor;
    
    switch (call.status) {
      case CallStatus.incoming:
        icon = Icons.call_received;
        iconColor = Colors.green;
        break;
      case CallStatus.outgoing:
        icon = Icons.call_made;
        iconColor = Colors.blue;
        break;
      case CallStatus.missed:
        icon = Icons.call_missed;
        iconColor = Colors.red;
        break;
      case CallStatus.unknown:
        icon = Icons.help_outline;
        iconColor = Colors.grey;
        break;
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade800,
        child: Icon(Icons.person, color: Colors.white54),
      ),
      title: Row(
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              call.contactName,
              style: GoogleFonts.roboto(
                color: call.status == CallStatus.missed 
                    ? Colors.red 
                    : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      subtitle: Text(
        call.phoneNumber ?? 'common.unknown'.tr(),
        style: TextStyle(color: Colors.white54, fontSize: 12),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            call.timestamp,
            style: TextStyle(color: Colors.white38, fontSize: 12),
          ),
          if (call.duration != null)
            Text(
              call.duration!,
              style: TextStyle(color: Colors.white38, fontSize: 11),
            ),
        ],
      ),
      onTap: () {
        // Arama detayları - şimdilik bir şey yapmıyor
      },
    );
  }
}
