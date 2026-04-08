import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/models/phone_data.dart';
import '../../../../core/widgets/app_image.dart';
import 'package:easy_localization/easy_localization.dart';

/// Mesajlar uygulaması (WhatsApp/iMessage benzeri)
class MessagesApp extends StatefulWidget {
  final List<PhoneChat> chats;
  final VoidCallback onBack;

  final String cdnBaseUrl;

  const MessagesApp({
    super.key,
    required this.chats,
    required this.onBack,
    required this.cdnBaseUrl,
  });

  @override
  State<MessagesApp> createState() => _MessagesAppState();
}

class _MessagesAppState extends State<MessagesApp> {
  PhoneChat? _selectedChat;

  @override
  Widget build(BuildContext context) {
    if (_selectedChat != null) {
      return _buildChatDetail(_selectedChat!);
    }
    return _buildChatList();
  }

  Widget _buildChatList() {
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
                'phone.messages'.tr(),
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        
        // Chat list
        Expanded(
          child: ListView.builder(
            itemCount: widget.chats.length,
            itemBuilder: (context, index) {
              final chat = widget.chats[index];
              final lastMessage = chat.messages.isNotEmpty 
                  ? chat.messages.last 
                  : null;
              
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.primaries[index % Colors.primaries.length],
                   backgroundImage: chat.contactAvatar != null 
                       ? appImageProvider(chat.contactAvatar!, widget.cdnBaseUrl)
                       : null,
                  child: chat.contactAvatar == null 
                      ? Text(chat.contactName[0].toUpperCase())
                      : null,
                ),
                title: Text(
                  chat.contactName,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: lastMessage != null
                    ? Text(
                        lastMessage.text,
                        style: TextStyle(color: Colors.white54),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : null,
                trailing: lastMessage != null
                    ? Text(
                        lastMessage.timestamp,
                        style: TextStyle(color: Colors.white38, fontSize: 12),
                      )
                    : null,
                onTap: () => setState(() => _selectedChat = chat),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChatDetail(PhoneChat chat) {
    return Column(
      children: [
        // Chat App Bar
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black26,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => setState(() => _selectedChat = null),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
                 CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 18,
                    backgroundImage: chat.contactAvatar != null
                        ? appImageProvider(chat.contactAvatar!, widget.cdnBaseUrl)
                        : null,
                    child: chat.contactAvatar == null ? Text(chat.contactName[0]) : null,
                  ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.contactName,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'phone.online'.tr(),
                      style: TextStyle(color: Colors.greenAccent, fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.videocam, color: Colors.white54),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.call, color: Colors.white54),
              ),
            ],
          ),
        ),
        
        // Messages
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF0A0A0A),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: chat.messages.length,
              itemBuilder: (context, index) {
                final message = chat.messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
        ),
        
        // Input bar (disabled - sadece görsel)
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.black38,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    'Mesaj yaz...',
                    style: TextStyle(color: Colors.white38),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.mic, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(PhoneMessage message) {
    final isMe = message.isFromMe;
    
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 8,
          left: isMe ? 60 : 0,
          right: isMe ? 0 : 60,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? Colors.green.shade700 : Colors.grey.shade800,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.text,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.timestamp,
              style: TextStyle(
                color: Colors.white54,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
