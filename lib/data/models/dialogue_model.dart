import 'package:freezed_annotation/freezed_annotation.dart';

part 'dialogue_model.freezed.dart';
part 'dialogue_model.g.dart';

@freezed
class DialogueNode with _$DialogueNode {
  const factory DialogueNode({
    @Default('') String id,
    @Default('') String text, // Hastanın söylediği
    required List<DialogueOption> options,
    @Default(false) bool isEnd, // Konuşma sonu mu?
  }) = _DialogueNode;

  factory DialogueNode.fromJson(Map<String, dynamic> json) => _$DialogueNodeFromJson(json);
}

@freezed
class DialogueOption with _$DialogueOption {
  const factory DialogueOption({
    @Default('') String text, // Seçenek metni
    String? nextNodeId, // Sonraki node ID (null ise konuşma biter veya aynı yerde kalır)
  }) = _DialogueOption;

  factory DialogueOption.fromJson(Map<String, dynamic> json) => _$DialogueOptionFromJson(json);
}

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    @Default('') String id,
    @Default('') String text,
    required bool isPlayer, // true: Doktor, false: Hasta
    required DateTime timestamp,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);
}
