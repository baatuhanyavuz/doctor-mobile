import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/sound_manager.dart';
import 'package:doctor/data/models/medical_data.dart';
import '../../../data/models/deduction.dart';
import '../../providers/board_controller.dart';
import '../../providers/solved_contradictions_provider.dart';

/// Tanı Tahtası - Tıbbi verileri birleştirme ve not alma paneli
class DetectiveBoardTab extends ConsumerStatefulWidget {
  final List<MedicalData> medicalData;
  final List<Deduction> deductions;
  final String caseId;

  const DetectiveBoardTab({
    super.key,
    required this.medicalData,
    required this.deductions,
    required this.caseId,
  });

  @override
  ConsumerState<DetectiveBoardTab> createState() => _DetectiveBoardTabState();
}

class _DetectiveBoardTabState extends ConsumerState<DetectiveBoardTab> {
  late BoardController _boardController;
  final TransformationController _transformController = TransformationController();
  final GlobalKey _boardKey = GlobalKey();
  
  // Pano sabit boyutu
  static const double _boardWidth = 1500.0;
  static const double _boardHeight = 2000.0;
  
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _boardController = BoardController(
      deductions: widget.deductions,
      onDeductionFound: _onDeductionFound,
    );
    _boardController.addListener(_onBoardChanged);
    
    // Başlangıçta görünümü merkeze ayarla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _centerView();
    });
  }
  
  void _centerView() {
    if (!mounted) return;
    final size = MediaQuery.of(context).size;
    final x = (_boardWidth - size.width) / 2;
    final y = (_boardHeight - size.height) / 2;
    _transformController.value = Matrix4.identity()..translate(-x, -y);
  }

  @override
  void dispose() {
    _boardController.removeListener(_onBoardChanged);
    _boardController.dispose();
    _transformController.dispose();
    super.dispose();
  }

  void _onBoardChanged() {
    if (mounted) setState(() {});
  }

  void _onDeductionFound(Deduction deduction) {
    HapticFeedback.heavyImpact();
    SoundManager.instance.playSfx('string_tighten');

    // Çelişki deduction'ı ise, çözülen evidence ID'lerini provider'a kaydet
    if (deduction.isContradiction) {
      final current = ref.read(solvedContradictionEvidenceIdsProvider);
      ref.read(solvedContradictionEvidenceIdsProvider.notifier).state = {
        ...current,
        ...deduction.requiredEvidenceIds,
      };
    }

    showDialog(
      context: context,
      builder: (context) => _DeductionFoundDialog(deduction: deduction),
    );
  }

  /// Tıklayarak ekleme - görünür alanın ortasına rastgele yerleştir
  void _addEvidenceByTap(String evidenceId) {
    if (_boardController.isOnBoard(evidenceId)) return;
    
    // Mevcut görünür alanın merkezini hesapla
    final matrix = _transformController.value;
    final scale = matrix.getMaxScaleOnAxis();
    final translateX = matrix.storage[12];
    final translateY = matrix.storage[13];
    
    final screenSize = MediaQuery.of(context).size;
    
    // Görünür alanın merkezi (pano koordinatlarında)
    final visibleCenterX = (-translateX + screenSize.width / 2) / scale;
    final visibleCenterY = (-translateY + screenSize.height / 2) / scale;
    
    // Rastgele offset ekle (üst üste binmesin)
    final randomOffsetX = (_random.nextDouble() - 0.5) * 200;
    final randomOffsetY = (_random.nextDouble() - 0.5) * 200;
    
    final position = Offset(
      (visibleCenterX + randomOffsetX).clamp(100.0, _boardWidth - 150.0),
      (visibleCenterY + randomOffsetY).clamp(100.0, _boardHeight - 150.0),
    );
    
    _boardController.addToBoard(evidenceId, position);
  }
  
  /// Sürükleyerek bırakma - global koordinatı yerel koordinata çevir
  void _addEvidenceByDrop(String evidenceId, Offset globalPosition) {
    if (_boardController.isOnBoard(evidenceId)) return;
    
    // Board'un RenderBox'ını al
    final RenderBox? boardBox = _boardKey.currentContext?.findRenderObject() as RenderBox?;
    if (boardBox == null) {
      // Fallback: tıklama ile ekle
      _addEvidenceByTap(evidenceId);
      return;
    }
    
    // Global koordinatı board'un yerel koordinatına çevir
    final localPosition = boardBox.globalToLocal(globalPosition);
    
    // InteractiveViewer'ın scale değerini hesaba kat
    final matrix = _transformController.value;
    final scale = matrix.getMaxScaleOnAxis();
    
    // Scale'e göre düzelt (zoom yapılmışsa)
    final adjustedPosition = Offset(
      localPosition.dx / scale,
      localPosition.dy / scale,
    );
    
    // Sınır kontrolü
    final clampedPosition = Offset(
      adjustedPosition.dx.clamp(50.0, _boardWidth - 150.0),
      adjustedPosition.dy.clamp(50.0, _boardHeight - 150.0),
    );
    
    _boardController.addToBoard(evidenceId, clampedPosition);
  }

  void _showAddNoteDialog() {
    final textController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF132038),
        title: Row(
          children: [
            Icon(Icons.edit_note, color: const Color(0xFF00BFA5)),
            const SizedBox(width: 8),
            Text('detective_board.new_note'.tr(), style: TextStyle(color: Colors.white)),
          ],
        ),
        content: TextField(
          controller: textController,
          maxLines: 3,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'detective_board.note_hint'.tr(),
            hintStyle: TextStyle(color: Colors.white38),
            filled: true,
            fillColor: Colors.black26,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('common.cancel'.tr(), style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                // Görünür alanın merkezine ekle
                final matrix = _transformController.value;
                final scale = matrix.getMaxScaleOnAxis();
                final translateX = matrix.storage[12];
                final translateY = matrix.storage[13];
                final screenSize = MediaQuery.of(context).size;
                
                final visibleCenterX = (-translateX + screenSize.width / 2) / scale;
                final visibleCenterY = (-translateY + screenSize.height / 2) / scale;
                
                final position = Offset(
                  visibleCenterX + (_random.nextDouble() - 0.5) * 100,
                  visibleCenterY + (_random.nextDouble() - 0.5) * 100,
                );
                
                _boardController.addNote(textController.text, position);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00BFA5),
              foregroundColor: Colors.white,
            ),
            child: Text('common.add'.tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      body: Column(
        children: [
          // Ana pano alanı
          Expanded(
            child: InteractiveViewer(
              transformationController: _transformController,
              constrained: false,
              minScale: 0.3,
              maxScale: 2.5,
              boundaryMargin: const EdgeInsets.all(200),
              child: Container(
                key: _boardKey,
                width: _boardWidth,
                height: _boardHeight,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A1628),
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.2,
                    colors: [
                      const Color(0xFF132038),
                      const Color(0xFF0E1A30),
                      const Color(0xFF0A1628),
                    ],
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Clean grid pattern (medical board)
                    ..._buildGridPattern(),
                    
                    // Bağlantı çizgileri
                    CustomPaint(
                      size: const Size(_boardWidth, _boardHeight),
                      painter: _ConnectionPainter(
                        items: _boardController.items,
                        connections: _boardController.connections,
                        boardController: _boardController,
                      ),
                    ),
                    
                    // Tıbbi veri kartları
                    ..._boardController.items.entries.map((entry) {
                      if (widget.medicalData.isEmpty) return const SizedBox.shrink();

                      final item = entry.value;
                      final evidence = widget.medicalData.firstWhere(
                        (e) => e.id == item.evidenceId,
                        orElse: () => widget.medicalData.first,
                      );

                      final isContradictionCard = _boardController
                          .isInvolvedInContradiction(item.evidenceId);

                      return _DraggableBoardCard(
                        key: ValueKey('card_${item.evidenceId}'),
                        evidenceId: item.evidenceId,
                        evidence: evidence,
                        position: item.position,
                        rotation: item.rotation,
                        isContradiction: isContradictionCard,
                        onPositionChanged: (newPos) {
                          _boardController.updatePosition(item.evidenceId, newPos);
                          SoundManager.instance.playSfx('pin_push');
                        },
                        onDragStarted: () {
                          SoundManager.instance.playSfx('paper_slide');
                        },
                        onDroppedOnCard: (droppedId) {
                          final result = _boardController.checkCombination(
                            item.evidenceId,
                            droppedId,
                          );
                          if (result == null) {
                            HapticFeedback.lightImpact();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Bu iki bulgu arasında bağlantı yok.'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        },
                        onRemove: () {
                          _boardController.removeFromBoard(item.evidenceId);
                        },
                      );
                    }),
                    
                    // Yapışkan notlar
                    ..._boardController.notes.entries.map((entry) {
                      final note = entry.value;
                      return _DraggableNote(
                        key: ValueKey('note_${note.id}'),
                        note: note,
                        onPositionChanged: (newPos) {
                          _boardController.updateNote(note.id, position: newPos);
                        },
                        onRemove: () {
                          _boardController.removeNote(note.id);
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          
          // Alt çekmece - tıbbi veri listesi
          _buildEvidenceTray(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNoteDialog,
        backgroundColor: const Color(0xFF00BFA5),
        child: const Icon(Icons.note_add, color: Colors.white),
      ),
    );
  }

  List<Widget> _buildGridPattern() {
    final List<Widget> lines = [];
    // Vertical grid lines
    for (double x = 0; x < _boardWidth; x += 60) {
      lines.add(
        Positioned(
          left: x,
          top: 0,
          child: Container(
            width: 0.5,
            height: _boardHeight,
            color: const Color(0xFF00BFA5).withOpacity(0.06),
          ),
        ),
      );
    }
    // Horizontal grid lines
    for (double y = 0; y < _boardHeight; y += 60) {
      lines.add(
        Positioned(
          left: 0,
          top: y,
          child: Container(
            width: _boardWidth,
            height: 0.5,
            color: const Color(0xFF00BFA5).withOpacity(0.06),
          ),
        ),
      );
    }
    return lines;
  }

  Widget _buildEvidenceTray() {
    // Panoda olmayan tıbbi verileri filtrele
    final availableEvidences = widget.medicalData
        .where((e) => !_boardController.isOnBoard(e.id))
        .toList();

    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFF132038),
        border: Border(
          top: BorderSide(color: const Color(0xFF00BFA5).withOpacity(0.2), width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 4),
            child: Text(
              'TIBBİ VERİLER (dokun veya sürükle)',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 10,
              ),
            ),
          ),
          Expanded(
            child: availableEvidences.isEmpty
                ? Center(
                    child: Text(
                      '✓ Tüm tıbbi veriler panoda',
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: availableEvidences.length,
                    itemBuilder: (context, index) {
                      final evidence = availableEvidences[index];
                      return _TrayCard(
                        evidence: evidence,
                        onTap: () => _addEvidenceByTap(evidence.id),
                        onDragEnd: (details) {
                          // Sürükleyip bıraktığında
                          _addEvidenceByDrop(evidence.id, details.offset);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/// Çekmecedeki tıbbi veri kartı
class _TrayCard extends StatelessWidget {
  final MedicalData evidence;
  final VoidCallback onTap;
  final Function(DraggableDetails) onDragEnd;

  const _TrayCard({
    required this.evidence,
    required this.onTap,
    required this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Draggable<String>(
        data: evidence.id,
        onDragEnd: onDragEnd,
        feedback: Material(
          elevation: 12,
          borderRadius: BorderRadius.circular(8),
          child: _buildCard(isDragging: true),
        ),
        childWhenDragging: Opacity(
          opacity: 0.3,
          child: _buildCard(),
        ),
        child: _buildCard(),
      ),
    );
  }

  Widget _buildCard({bool isDragging = false}) {
    return Container(
      width: 65,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDragging ? const Color(0xFF00BFA5).withOpacity(0.15) : const Color(0xFF132038),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDragging ? const Color(0xFF00BFA5) : Colors.white24,
          width: isDragging ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getIconForType(evidence.type),
            color: isDragging ? const Color(0xFF00BFA5) : Colors.white70,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            evidence.title.length > 8
                ? '${evidence.title.substring(0, 8)}...'
                : evidence.title,
            style: TextStyle(
              color: isDragging ? const Color(0xFF00BFA5) : Colors.white70,
              fontSize: 9,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  IconData _getIconForType(MedicalDataType type) {
    switch (type) {
      case MedicalDataType.photo: return Icons.image;
      case MedicalDataType.document: return Icons.description;
      case MedicalDataType.audio: return Icons.audiotrack;
      case MedicalDataType.video: return Icons.videocam;
      case MedicalDataType.phone: return Icons.phone_android;
      default: return Icons.help_outline;
    }
  }
}

/// Panodaki sürüklenebilir tıbbi veri kartı
class _DraggableBoardCard extends StatefulWidget {
  final String evidenceId;
  final MedicalData evidence;
  final Offset position;
  final double rotation;
  final bool isContradiction;
  final Function(Offset) onPositionChanged;
  final Function(String) onDroppedOnCard;
  final VoidCallback onRemove;
  final VoidCallback? onDragStarted;

  const _DraggableBoardCard({
    super.key,
    required this.evidenceId,
    required this.evidence,
    required this.position,
    required this.rotation,
    this.isContradiction = false,
    required this.onPositionChanged,
    required this.onDroppedOnCard,
    required this.onRemove,
    this.onDragStarted,
  });

  @override
  State<_DraggableBoardCard> createState() => _DraggableBoardCardState();
}

class _DraggableBoardCardState extends State<_DraggableBoardCard> {
  late Offset _currentPosition;

  @override
  void initState() {
    super.initState();
    _currentPosition = widget.position;
  }

  @override
  void didUpdateWidget(covariant _DraggableBoardCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Dışarıdan pozisyon değişirse güncelle
    if (oldWidget.position != widget.position) {
      _currentPosition = widget.position;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _currentPosition.dx,
      top: _currentPosition.dy,
      child: GestureDetector(
        onDoubleTap: widget.onRemove,
        onPanStart: (_) {
          widget.onDragStarted?.call();
        },
        onPanUpdate: (details) {
          setState(() {
            _currentPosition = Offset(
              _currentPosition.dx + details.delta.dx,
              _currentPosition.dy + details.delta.dy,
            );
          });
        },
        onPanEnd: (_) {
          // Sürükleme bitince controller'a bildir
          widget.onPositionChanged(_currentPosition);
        },
        child: DragTarget<String>(
          onAcceptWithDetails: (details) {
            final droppedId = details.data;
            if (droppedId != widget.evidenceId && !droppedId.startsWith('note_')) {
              widget.onDroppedOnCard(droppedId);
            }
          },
          builder: (context, candidateData, rejectedData) {
            final isHighlighted = candidateData.isNotEmpty;
            return Transform.rotate(
              angle: widget.rotation,
              child: _buildCard(isHighlighted: isHighlighted),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard({bool isHighlighted = false}) {
    final isContra = widget.isContradiction;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 90,
          height: 110,
          decoration: BoxDecoration(
            color: isHighlighted
                ? Colors.green.shade100
                : isContra
                    ? const Color(0xFFFFEBEE)
                    : Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isHighlighted
                  ? Colors.green
                  : isContra
                      ? const Color(0xFFEF5350)
                      : Colors.grey.shade400,
              width: isHighlighted || isContra ? 3 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isContra
                    ? const Color(0xFFEF5350).withOpacity(0.3)
                    : Colors.black.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isContra
                        ? const Color(0xFFEF5350).withOpacity(0.08)
                        : Colors.grey.shade200,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
                  ),
                  child: Icon(
                    _getIconForType(widget.evidence.type),
                    size: 36,
                    color: isContra
                        ? const Color(0xFFEF5350)
                        : Colors.grey.shade600,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Text(
                  widget.evidence.title,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: isContra ? const Color(0xFFEF5350) : Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        // Celiski rozeti
        if (isContra)
          Positioned(
            top: -6,
            right: -6,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Color(0xFFEF5350),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x66EF5350),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  '!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  IconData _getIconForType(MedicalDataType type) {
    switch (type) {
      case MedicalDataType.photo: return Icons.image;
      case MedicalDataType.document: return Icons.description;
      case MedicalDataType.audio: return Icons.audiotrack;
      case MedicalDataType.video: return Icons.videocam;
      case MedicalDataType.phone: return Icons.phone_android;
      default: return Icons.help_outline;
    }
  }
}

/// Yapışkan not kartı
class _DraggableNote extends StatefulWidget {
  final BoardNote note;
  final Function(Offset) onPositionChanged;
  final VoidCallback onRemove;

  const _DraggableNote({
    super.key,
    required this.note,
    required this.onPositionChanged,
    required this.onRemove,
  });

  @override
  State<_DraggableNote> createState() => _DraggableNoteState();
}

class _DraggableNoteState extends State<_DraggableNote> {
  late Offset _currentPosition;

  @override
  void initState() {
    super.initState();
    _currentPosition = widget.note.position;
  }

  @override
  void didUpdateWidget(covariant _DraggableNote oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.note.position != widget.note.position) {
      _currentPosition = widget.note.position;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _currentPosition.dx,
      top: _currentPosition.dy,
      child: GestureDetector(
        onDoubleTap: widget.onRemove,
        onPanUpdate: (details) {
          setState(() {
            _currentPosition = Offset(
              _currentPosition.dx + details.delta.dx,
              _currentPosition.dy + details.delta.dy,
            );
          });
        },
        onPanEnd: (_) {
          widget.onPositionChanged(_currentPosition);
        },
        child: Transform.rotate(
          angle: widget.note.rotation,
          child: Container(
            width: 100,
            constraints: const BoxConstraints(minHeight: 80),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: widget.note.color,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Text(
              widget.note.text,
              style: GoogleFonts.caveat(
                fontSize: 14,
                color: Colors.black87,
                height: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Bağlantı çizgileri çizen painter
class _ConnectionPainter extends CustomPainter {
  final Map<String, BoardItem> items;
  final List<(String, String)> connections;
  final BoardController boardController;

  _ConnectionPainter({
    required this.items,
    required this.connections,
    required this.boardController,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final normalPaint = Paint()
      ..color = const Color(0xFF00BFA5)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final contradictionPaint = Paint()
      ..color = const Color(0xFFEF5350)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    for (final connection in connections) {
      final item1 = items[connection.$1];
      final item2 = items[connection.$2];

      if (item1 != null && item2 != null) {
        final start = Offset(item1.position.dx + 45, item1.position.dy + 55);
        final end = Offset(item2.position.dx + 45, item2.position.dy + 55);

        final isContra = boardController.isContradictionConnection(
          connection.$1,
          connection.$2,
        );

        canvas.drawLine(start, end, isContra ? contradictionPaint : normalPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ConnectionPainter oldDelegate) {
    return connections.length != oldDelegate.connections.length ||
           items.length != oldDelegate.items.length;
  }
}

/// Çıkarım bulundu dialog
class _DeductionFoundDialog extends StatelessWidget {
  final Deduction deduction;

  const _DeductionFoundDialog({required this.deduction});

  @override
  Widget build(BuildContext context) {
    final isContradiction = deduction.isContradiction;
    final accentColor = isContradiction
        ? const Color(0xFFEF5350)
        : const Color(0xFF00BFA5);

    return AlertDialog(
      backgroundColor: const Color(0xFF132038),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: accentColor, width: 2),
      ),
      title: Row(
        children: [
          Icon(
            isContradiction ? Icons.priority_high : Icons.lightbulb,
            color: accentColor,
            size: 32,
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              isContradiction ? 'CELiSKi COZULDU!' : 'BAGLANTI BULUNDU!',
              style: GoogleFonts.poppins(
                color: accentColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isContradiction) ...[
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF5350).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFEF5350).withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber, color: Color(0xFFEF5350), size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Hasta yaniltici bilgi vermis!',
                        style: GoogleFonts.inter(
                          color: const Color(0xFFEF5350),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Text(
              deduction.resultText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('ANLADIM'),
        ),
      ],
    );
  }
}
