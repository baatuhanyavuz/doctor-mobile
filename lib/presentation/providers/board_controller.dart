import 'package:flutter/material.dart';
import '../../data/models/deduction.dart';

/// Board üzerindeki bir tıbbi veri kartı
class BoardItem {
  final String evidenceId;
  Offset position;
  double rotation;

  BoardItem({
    required this.evidenceId,
    required this.position,
    this.rotation = 0,
  });

  BoardItem copyWith({Offset? position, double? rotation}) {
    return BoardItem(
      evidenceId: evidenceId,
      position: position ?? this.position,
      rotation: rotation ?? this.rotation,
    );
  }
}

/// Board üzerindeki not kartı
class BoardNote {
  final String id;
  String text;
  Offset position;
  double rotation;
  Color color;

  BoardNote({
    required this.id,
    required this.text,
    required this.position,
    this.rotation = 0,
    this.color = const Color(0xFFFFF9C4),
  });

  BoardNote copyWith({String? text, Offset? position, double? rotation, Color? color}) {
    return BoardNote(
      id: id,
      text: text ?? this.text,
      position: position ?? this.position,
      rotation: rotation ?? this.rotation,
      color: color ?? this.color,
    );
  }
}

/// Board State Controller - ChangeNotifier ile
class BoardController extends ChangeNotifier {
  final List<Deduction> deductions;
  final Function(Deduction)? onDeductionFound;
  
  final Map<String, BoardItem> _items = {};
  final Map<String, BoardNote> _notes = {};
  final Set<String> _unlockedDeductionIds = {};
  final Set<String> _contradictionDeductionIds = {};
  final List<(String, String)> _connections = [];

  BoardController({
    required this.deductions,
    this.onDeductionFound,
  });

  // Getters
  Map<String, BoardItem> get items => Map.unmodifiable(_items);
  Map<String, BoardNote> get notes => Map.unmodifiable(_notes);
  Set<String> get unlockedDeductionIds => Set.unmodifiable(_unlockedDeductionIds);
  Set<String> get contradictionDeductionIds => Set.unmodifiable(_contradictionDeductionIds);
  List<(String, String)> get connections => List.unmodifiable(_connections);
  
  bool isOnBoard(String evidenceId) => _items.containsKey(evidenceId);

  /// Panoya tıbbi veri ekle
  void addToBoard(String evidenceId, Offset position) {
    if (_items.containsKey(evidenceId)) return;
    
    final rotation = (evidenceId.hashCode % 20 - 10) * 0.02;
    _items[evidenceId] = BoardItem(
      evidenceId: evidenceId,
      position: position,
      rotation: rotation,
    );
    notifyListeners();
  }

  /// Panodan tıbbi veri kaldır
  void removeFromBoard(String evidenceId) {
    _items.remove(evidenceId);
    _connections.removeWhere((c) => c.$1 == evidenceId || c.$2 == evidenceId);
    notifyListeners();
  }

  /// Tıbbi Veri konumunu güncelle
  void updatePosition(String evidenceId, Offset newPosition) {
    if (!_items.containsKey(evidenceId)) return;
    _items[evidenceId] = _items[evidenceId]!.copyWith(position: newPosition);
    notifyListeners();
  }

  /// Not ekle
  void addNote(String text, Offset position, {Color? color}) {
    final id = 'note_${DateTime.now().millisecondsSinceEpoch}';
    final rotation = (id.hashCode % 20 - 10) * 0.03;
    _notes[id] = BoardNote(
      id: id,
      text: text,
      position: position,
      rotation: rotation,
      color: color ?? const Color(0xFFFFF9C4),
    );
    notifyListeners();
  }

  /// Not güncelle
  void updateNote(String noteId, {String? text, Offset? position}) {
    if (!_notes.containsKey(noteId)) return;
    _notes[noteId] = _notes[noteId]!.copyWith(
      text: text,
      position: position,
    );
    notifyListeners();
  }

  /// Not sil
  void removeNote(String noteId) {
    _notes.remove(noteId);
    notifyListeners();
  }

  /// İki tıbbi veriyi birleştirmeyi dene
  Deduction? checkCombination(String id1, String id2) {
    for (final deduction in deductions) {
      if (_unlockedDeductionIds.contains(deduction.id)) continue;
      
      final required = Set<String>.from(deduction.requiredEvidenceIds);
      final provided = {id1, id2};
      
      if (required.length == 2 && required.containsAll(provided)) {
        _unlockedDeductionIds.add(deduction.id);
        if (deduction.isContradiction) {
          _contradictionDeductionIds.add(deduction.id);
        }
        _connections.add((id1, id2));
        notifyListeners();
        onDeductionFound?.call(deduction);
        return deduction;
      }
    }
    return null;
  }

  /// Belirli bir evidence, celiski cikariminda kullanildi mi?
  bool isInvolvedInContradiction(String evidenceId) {
    for (final deduction in deductions) {
      if (deduction.isContradiction &&
          _unlockedDeductionIds.contains(deduction.id) &&
          deduction.requiredEvidenceIds.contains(evidenceId)) {
        return true;
      }
    }
    return false;
  }

  /// Bir connection celiski baglantisi mi?
  bool isContradictionConnection(String id1, String id2) {
    for (final deduction in deductions) {
      if (!deduction.isContradiction) continue;
      if (!_unlockedDeductionIds.contains(deduction.id)) continue;
      final req = Set<String>.from(deduction.requiredEvidenceIds);
      if (req.contains(id1) && req.contains(id2)) return true;
    }
    return false;
  }

  /// Tahtayı temizle
  void clearBoard() {
    _items.clear();
    _notes.clear();
    _connections.clear();
    _unlockedDeductionIds.clear();
    _contradictionDeductionIds.clear();
    notifyListeners();
  }
}
