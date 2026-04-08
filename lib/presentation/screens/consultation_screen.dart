import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/consultant.dart';

/// Konsültasyon Ekranı — telefon görüşmesi tarzı NPC uzman doktor UI
class ConsultationScreen extends StatefulWidget {
  final Consultant consultant;
  final String caseTitle;
  final String hintText;

  const ConsultationScreen({
    super.key,
    required this.consultant,
    required this.caseTitle,
    required this.hintText,
  });

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  final List<_ChatMessage> _messages = [];
  bool _isTyping = false;
  int _phase = 0; // 0=bağlanıyor, 1=selamlama, 2=ipucu, 3=kapanış

  @override
  void initState() {
    super.initState();
    _startConversation();
  }

  Future<void> _startConversation() async {
    // Faz 0: Bağlanıyor
    setState(() => _isTyping = true);
    await Future.delayed(const Duration(milliseconds: 1500));

    // Faz 1: Selamlama
    _addMessage(widget.consultant.greeting, isDoctor: true);
    await Future.delayed(const Duration(milliseconds: 800));

    // Faz 2: Vaka sorusu
    _addMessage(
      '${widget.caseTitle} vakasını inceliyorum. Bir görüşünüzü almak istiyorum.',
      isDoctor: false,
    );
    await Future.delayed(const Duration(milliseconds: 1200));

    setState(() => _isTyping = true);
    await Future.delayed(const Duration(milliseconds: 2000));

    // Faz 3: İpucu
    _addMessage(widget.hintText, isDoctor: true);
    await Future.delayed(const Duration(milliseconds: 800));

    // Faz 4: Kapanış
    _addMessage(
      'Umarım yardımcı olabilmişimdir. İyi çalışmalar, meslektaşım.',
      isDoctor: true,
    );
    setState(() => _phase = 3);
  }

  void _addMessage(String text, {required bool isDoctor}) {
    setState(() {
      _isTyping = false;
      _messages.add(_ChatMessage(text: text, isDoctor: isDoctor));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      appBar: AppBar(
        backgroundColor: const Color(0xFF132038),
        leading: IconButton(
          icon: const Icon(Icons.phone_disabled, color: Color(0xFFEF5350)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFF00BFA5).withOpacity(0.2),
              child: const Icon(Icons.person, color: Color(0xFF00BFA5), size: 20),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.consultant.name,
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.consultant.specialty,
                  style: TextStyle(color: const Color(0xFF00BFA5), fontSize: 11),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Telefon animasyonu
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF66BB6A).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.phone_in_talk, color: const Color(0xFF66BB6A), size: 16),
                const SizedBox(width: 4),
                Text(
                  'Aktif',
                  style: GoogleFonts.robotoMono(
                    color: const Color(0xFF66BB6A),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat mesajları
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return _TypingIndicator(name: widget.consultant.name.split(' ').last);
                }
                return _ChatBubble(message: _messages[index]);
              },
            ),
          ),

          // Kapatma butonu
          if (_phase >= 3)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF132038),
                border: Border(top: BorderSide(color: Color(0x22FFFFFF))),
              ),
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.phone_disabled, size: 18),
                label: Text(
                  'GÖRÜŞMEYÜ SONLANDIR',
                  style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF5350).withOpacity(0.15),
                  foregroundColor: const Color(0xFFEF5350),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: const Color(0xFFEF5350).withOpacity(0.3)),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isDoctor;
  _ChatMessage({required this.text, required this.isDoctor});
}

class _ChatBubble extends StatelessWidget {
  final _ChatMessage message;
  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isDoctor ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: message.isDoctor
              ? const Color(0xFF132038)
              : const Color(0xFF00BFA5).withOpacity(0.12),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message.isDoctor ? 4 : 16),
            bottomRight: Radius.circular(message.isDoctor ? 16 : 4),
          ),
          border: Border.all(
            color: message.isDoctor
                ? Colors.white10
                : const Color(0xFF00BFA5).withOpacity(0.2),
          ),
        ),
        child: Text(
          message.text,
          style: GoogleFonts.inter(
            color: Colors.white70,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class _TypingIndicator extends StatefulWidget {
  final String name;
  const _TypingIndicator({required this.name});

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF132038),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${widget.name} yazıyor',
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
            const SizedBox(width: 8),
            AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (i) {
                    final delay = i * 0.3;
                    final value = (_controller.value - delay).clamp(0.0, 1.0);
                    final opacity = (value < 0.5) ? value * 2 : (1.0 - value) * 2;
                    return Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF00BFA5).withOpacity(opacity.clamp(0.2, 1.0)),
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
