import '../../../core/widgets/editorial_message_block.dart';
import '../../monument/models/monument_model.dart';

class ChatMessage {
  final String id;
  final MessageRole role;
  final String text;
  final DateTime timestamp;
  final bool isStreaming;
  final MonumentModel? monumentContext;
  final String? imagePath;

  const ChatMessage({
    required this.id,
    required this.role,
    required this.text,
    required this.timestamp,
    this.isStreaming = false,
    this.monumentContext,
    this.imagePath,
  });

  ChatMessage copyWith({
    String? id,
    MessageRole? role,
    String? text,
    DateTime? timestamp,
    bool? isStreaming,
    MonumentModel? monumentContext,
    String? imagePath,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      role: role ?? this.role,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      isStreaming: isStreaming ?? this.isStreaming,
      monumentContext: monumentContext ?? this.monumentContext,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
