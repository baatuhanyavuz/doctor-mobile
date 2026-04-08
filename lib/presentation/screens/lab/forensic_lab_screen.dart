import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/widgets/app_image.dart';
import '../../../core/utils/sound_manager.dart';
import 'package:doctor/data/models/medical_data.dart';
import '../../../data/models/forensic_data.dart';

class ForensicLabScreen extends StatefulWidget {
  final MedicalData evidence;

  final String cdnBaseUrl;

  const ForensicLabScreen({
    super.key, 
    required this.evidence, 
    required this.cdnBaseUrl,
  });

  @override
  State<ForensicLabScreen> createState() => _ForensicLabScreenState();
}

class _ForensicLabScreenState extends State<ForensicLabScreen> {
  late ForensicData _data;
  bool _isAnalyzed = false;
  String? _currentImageUrl;
  String? _feedbackMessage;

  @override
  void initState() {
    super.initState();
    if (widget.evidence.labAnalysisData == null) {
      throw Exception('Forensic data is missing');
    }
    _data = widget.evidence.labAnalysisData!;
    _currentImageUrl = _data.initialImageUrl;
  }

  void _handleReagentDrop(DragTargetDetails<Reagent> details) {
    final reagent = details.data;
    if (_isAnalyzed) return;
    
    // Döküm sesi çal
    SoundManager.instance.playSfx('liquid_pour');
    
    if (reagent.isCorrect) {
      setState(() {
        _isAnalyzed = true;
        _currentImageUrl = _data.resultImageUrl;
        _feedbackMessage = null;
      });
      // Reaksiyon sesi çal
      Future.delayed(const Duration(milliseconds: 500), () {
        SoundManager.instance.playSfx('chemical_fizz');
      });
    } else {
      setState(() {
        _feedbackMessage = 'lab.no_reaction'.tr(args: [reagent.name]);
      });
      
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted && !_isAnalyzed) {
          setState(() {
            _feedbackMessage = null;
          });
        }
      });
    }
  }

  void _exitAndSave() {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white54),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'lab.title'.tr(),
              style: GoogleFonts.robotoMono(
                color: Colors.cyanAccent,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            Text(
              widget.evidence.title,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _isAnalyzed 
                  ? Colors.green.withOpacity(0.2) 
                  : Colors.cyan.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isAnalyzed ? Colors.green : Colors.cyan.withOpacity(0.5),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _isAnalyzed ? Colors.green : Colors.cyan,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  _isAnalyzed ? 'TAMAM' : 'HAZIR',
                  style: GoogleFonts.robotoMono(
                    color: _isAnalyzed ? Colors.green : Colors.cyan,
                    fontSize: 9,
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
          // Numune alanı
          Expanded(
            flex: 3,
            child: _buildSampleArea(),
          ),
          
          // Alt panel
          if (!_isAnalyzed) _buildReagentPanel(),
          if (_isAnalyzed) _buildResultPanel(),
        ],
      ),
    );
  }

  Widget _buildSampleArea() {
    return Center(
      child: DragTarget<Reagent>(
        onWillAcceptWithDetails: (data) => !_isAnalyzed,
        onAcceptWithDetails: _handleReagentDrop,
        builder: (context, candidateData, rejectedData) {
          final isHovering = candidateData.isNotEmpty;
          
          return Stack(
            alignment: Alignment.center,
            children: [
              // Mikroskop çerçevesi
              Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isHovering ? Colors.cyanAccent : Colors.cyan.withOpacity(0.3),
                    width: isHovering ? 3 : 2,
                  ),
                  boxShadow: isHovering ? [
                    BoxShadow(
                      color: Colors.cyanAccent.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ] : null,
                ),
                child: ClipOval(
                  child: Container(
                    color: Colors.black,
                    child: _currentImageUrl != null
                        ? AppImage(
                            path: _currentImageUrl!,
                            cdnBaseUrl: widget.cdnBaseUrl,
                            fit: BoxFit.cover,
                            errorWidget: Container(
                              color: Colors.grey[900],
                              child: const Icon(Icons.science, size: 50, color: Colors.cyan),
                            ),
                          )
                        : Container(
                            color: Colors.grey[900],
                            child: const Icon(Icons.science, size: 50, color: Colors.cyan),
                          ),
                  ),
                ),
              ),
              
              // Feedback
              if (_feedbackMessage != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.withOpacity(0.5)),
                  ),
                  child: Text(
                    _feedbackMessage!,
                    style: GoogleFonts.robotoMono(
                      color: Colors.redAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildReagentPanel() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1E24),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Text(
            'KİMYASAL REAKTİFLER',
            style: GoogleFonts.robotoMono(
              color: Colors.white54,
              fontSize: 11,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'lab.drag_instruction'.tr(),
            style: TextStyle(color: Colors.white30, fontSize: 11),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _data.reagents.map((reagent) {
              return Draggable<Reagent>(
                data: reagent,
                feedback: _buildReagentBottle(reagent, isDragging: true),
                childWhenDragging: Opacity(
                  opacity: 0.3,
                  child: _buildReagentBottle(reagent),
                ),
                child: _buildReagentBottle(reagent),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReagentBottle(Reagent reagent, {bool isDragging = false}) {
    final color = Color(int.parse(reagent.color.replaceFirst('#', '0xFF')));
    
    return Column(
      children: [
        Container(
          width: isDragging ? 55 : 45,
          height: isDragging ? 95 : 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.12),
                Colors.white.withOpacity(0.04),
              ],
            ),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(6),
              bottom: Radius.circular(22),
            ),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
          ),
          child: Column(
            children: [
              // Kapak
              Container(
                width: 26,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
                ),
              ),
              const SizedBox(height: 6),
              // Sıvı
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [color.withOpacity(0.4), color],
                    ),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isDragging) ...[
          const SizedBox(height: 6),
          Text(
            reagent.name,
            style: GoogleFonts.robotoMono(color: Colors.white60, fontSize: 9),
          ),
        ],
      ],
    );
  }

  Widget _buildResultPanel() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.green, size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                'ANALİZ TAMAMLANDI',
                style: GoogleFonts.robotoMono(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _data.resultText,
            style: GoogleFonts.roboto(
              color: Colors.white.withOpacity(0.85),
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _exitAndSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.withOpacity(0.2),
                foregroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.green),
                ),
              ),
              child: Text(
                'DEVAM ET',
                style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
