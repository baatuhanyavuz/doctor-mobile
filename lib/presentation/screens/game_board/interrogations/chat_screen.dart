import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/app_image.dart';
import 'package:doctor/data/models/interview.dart';
import 'package:doctor/data/models/diagnosis.dart';
import '../../../../data/models/dialogue_model.dart';

class InterrogationScreen extends StatefulWidget {
  final Interview interrogation;
  final Diagnosis suspect;
  final String cdnBaseUrl;

  const InterrogationScreen({
    super.key,
    required this.interrogation,
    required this.suspect,
    required this.cdnBaseUrl,
  });

  @override
  State<InterrogationScreen> createState() => _InterrogationScreenState();
}

class _InterrogationScreenState extends State<InterrogationScreen> {
  late List<DialogueNode> _dialogueTree;
  DialogueNode? _currentNode;
  bool _isCompleted = false;
  final List<_DialogueEntry> _history = [];

  @override
  void initState() {
    super.initState();
    _dialogueTree = widget.interrogation.dialogueTree ?? [];
    _startDialogue();
  }

  void _startDialogue() {
    if (_dialogueTree.isEmpty) return;
    final startNode = _dialogueTree.firstWhere(
      (node) => node.id == 'start',
      orElse: () => _dialogueTree.first,
    );
    setState(() => _currentNode = startNode);
  }

  void _selectOption(DialogueOption option) {
    if (_currentNode == null) return;
    
    _history.add(_DialogueEntry(speaker: widget.suspect.name, text: _currentNode!.text, isPlayer: false));
    _history.add(_DialogueEntry(speaker: 'common.detective'.tr(), text: option.text, isPlayer: true));
    
    if (option.nextNodeId == null) {
      _completeInterrogation();
      return;
    }
    
    try {
      final nextNode = _dialogueTree.firstWhere((node) => node.id == option.nextNodeId);
      setState(() => _currentNode = nextNode);
      
      if (nextNode.isEnd) {
        _history.add(_DialogueEntry(speaker: widget.suspect.name, text: nextNode.text, isPlayer: false));
        Future.delayed(const Duration(seconds: 1), _completeInterrogation);
      }
    } catch (e) {
      _completeInterrogation();
    }
  }

  void _completeInterrogation() => setState(() => _isCompleted = true);
  void _exitAndSave() => Navigator.of(context).pop(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white54),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('interrogation.room_title'.tr(), style: GoogleFonts.robotoMono(color: Colors.amber, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2)),
      ),
      body: _isCompleted ? _buildReportScreen() : _buildInterrogationArea(),
    );
  }

  Widget _buildInterrogationArea() {
    return Column(
      children: [
        _buildSuspectCard(),
        Expanded(child: _buildDialogueArea()),
      ],
    );
  }

  Widget _buildSuspectCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 70, height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.amber.withOpacity(0.5), width: 2),
              image: widget.suspect.photoPath != null
                  ? DecorationImage(image: appImageProvider(widget.suspect.photoPath!, widget.cdnBaseUrl), fit: BoxFit.cover)
                  : null,
            ),
            child: widget.suspect.photoPath == null ? const Icon(Icons.person, size: 35, color: Colors.white30) : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.suspect.name.toUpperCase(), style: GoogleFonts.specialElite(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(widget.suspect.occupation ?? 'common.suspect_fallback'.tr(), style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogueArea() {
    if (_currentNode == null) {
      return const Center(child: Text('Diyalog verisi bulunamadı.', style: TextStyle(color: Colors.white54)));
    }
    
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(width: 4, height: 16, color: Colors.amber),
            const SizedBox(width: 8),
            Text(widget.suspect.name.split(' ').first.toUpperCase(), style: GoogleFonts.robotoMono(color: Colors.amber, fontSize: 11, fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Text(_currentNode!.text, style: GoogleFonts.merriweather(color: Colors.white.withOpacity(0.9), fontSize: 15, height: 1.6)),
            ),
          ),
          const SizedBox(height: 20),
          if (!_currentNode!.isEnd) ...(_currentNode!.options.map((o) => _buildOptionButton(o)).toList()),
          if (_currentNode!.isEnd) _buildEndMessage(),
        ],
      ),
    );
  }

  Widget _buildOptionButton(DialogueOption option) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => _selectOption(option),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
          ),
          child: Row(children: [
            Icon(Icons.chevron_right, size: 18, color: Colors.amber.withOpacity(0.7)),
            const SizedBox(width: 10),
            Expanded(child: Text(option.text, style: GoogleFonts.merriweather(color: Colors.white.withOpacity(0.85), fontSize: 13))),
          ]),
        ),
      ),
    );
  }

  Widget _buildEndMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Row(children: [
        Icon(Icons.check_circle, color: Colors.amber.withOpacity(0.8), size: 20),
        const SizedBox(width: 10),
        Text('interrogation.ended'.tr(), style: GoogleFonts.robotoMono(color: Colors.amber, fontSize: 13)),
      ]),
    );
  }

  Widget _buildReportScreen() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Container(
              width: 50, height: 50,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.amber.withOpacity(0.1), border: Border.all(color: Colors.amber, width: 2)),
              child: const Icon(Icons.description, color: Colors.amber, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('interrogation.report_title'.tr(), style: GoogleFonts.specialElite(color: Colors.amber, fontSize: 18, letterSpacing: 2)),
                Text(widget.suspect.name, style: const TextStyle(color: Colors.white54, fontSize: 12)),
              ]),
            ),
          ]),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) => _buildTranscriptEntry(_history[index]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _exitAndSave,
              icon: const Icon(Icons.check),
              label: Text('DOSYAYA EKLE VE ÇIK', style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold, letterSpacing: 1)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.withOpacity(0.2),
                foregroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: const BorderSide(color: Colors.amber)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTranscriptEntry(_DialogueEntry entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: 3, height: 14, color: entry.isPlayer ? Colors.cyan : Colors.amber),
          const SizedBox(width: 8),
          Text(entry.speaker.toUpperCase(), style: GoogleFonts.robotoMono(color: entry.isPlayer ? Colors.cyan : Colors.amber, fontSize: 10, fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 11),
          child: Text(entry.text, style: GoogleFonts.merriweather(color: Colors.white.withOpacity(0.8), fontSize: 13, height: 1.5)),
        ),
      ]),
    );
  }
}

class _DialogueEntry {
  final String speaker;
  final String text;
  final bool isPlayer;
  _DialogueEntry({required this.speaker, required this.text, required this.isPlayer});
}
