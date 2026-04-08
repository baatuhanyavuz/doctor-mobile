import 'package:freezed_annotation/freezed_annotation.dart';

part 'sticky_note.freezed.dart';
part 'sticky_note.g.dart';

/// Yapışkan Not (Post-it) Modeli
/// 
/// Teşhis tahtasına eklenen kullanıcı notları.
@freezed
class StickyNote with _$StickyNote {
  const factory StickyNote({
    /// Benzersiz not ID'si
    required String id,
    
    /// Not metni
    required String text,
    
    /// Not rengi (hex değeri)
    @Default(0xFFFFF9C4) int color, // Sarı
    
    /// Panodaki X koordinatı
    @Default(100) double x,
    
    /// Panodaki Y koordinatı
    @Default(100) double y,
    
    /// Oluşturulma tarihi
    String? createdAt,
  }) = _StickyNote;

  factory StickyNote.fromJson(Map<String, dynamic> json) =>
      _$StickyNoteFromJson(json);
}
