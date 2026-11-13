import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/editorial_message_block.dart';
import '../../monument/models/monument_model.dart';
import '../../monument/providers/monument_provider.dart';
import '../models/chat_message.dart';

class ChatState {
  final List<ChatMessage> messages;
  final bool isGenerating;
  final bool isPaused;
  final MonumentModel activeMonument;

  const ChatState({
    required this.messages,
    this.isGenerating = false,
    this.isPaused = false,
    required this.activeMonument,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isGenerating,
    bool? isPaused,
    MonumentModel? activeMonument,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isGenerating: isGenerating ?? this.isGenerating,
      isPaused: isPaused ?? this.isPaused,
      activeMonument: activeMonument ?? this.activeMonument,
    );
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier(MonumentModel defaultMonument)
    : super(ChatState(messages: [], activeMonument: defaultMonument));

  void setMonumentContext(MonumentModel monument) {
    state = state.copyWith(activeMonument: monument);
  }

  void startNewConversation() {
    state = state.copyWith(messages: [], isGenerating: false, isPaused: false);
  }

  void togglePause() {
    if (state.isGenerating) {
      state = state.copyWith(isPaused: !state.isPaused);
    }
  }

  Future<void> sendMessage(
    String text, {
    String? imagePath,
    String language = 'English',
  }) async {
    if (text.trim().isEmpty && imagePath == null) return;

    final userMsgId = 'user_${DateTime.now().millisecondsSinceEpoch}';
    final userMsg = ChatMessage(
      id: userMsgId,
      role: MessageRole.user,
      text: text.trim().isEmpty
          ? _copy(language, 'I added a monument image.')
          : text,
      timestamp: DateTime.now(),
      imagePath: imagePath,
    );

    state = state.copyWith(
      messages: [...state.messages, userMsg],
      isGenerating: true,
      isPaused: false,
    );

    // Thinking delay (~600ms)
    await Future.delayed(const Duration(milliseconds: 600));

    final aiMsgId = 'ai_${DateTime.now().millisecondsSinceEpoch}';
    final responseText = imagePath == null
        ? _generateGuideResponse(text, state.activeMonument, language)
        : _identifyImage(state.activeMonument, language);

    final aiMsg = ChatMessage(
      id: aiMsgId,
      role: MessageRole.assistant,
      text: '',
      timestamp: DateTime.now(),
      isStreaming: true,
      monumentContext: state.activeMonument,
    );

    state = state.copyWith(messages: [...state.messages, aiMsg]);

    // Typewriter streaming character reveal without shimmer
    for (int i = 1; i <= responseText.length; i++) {
      while (state.isPaused) {
        await Future<void>.delayed(const Duration(milliseconds: 100));
      }
      await Future.delayed(const Duration(milliseconds: 18));
      final currentText = responseText.substring(0, i);

      state = state.copyWith(
        messages: state.messages.map((m) {
          if (m.id == aiMsgId) {
            return m.copyWith(
              text: currentText,
              isStreaming: i < responseText.length,
            );
          }
          return m;
        }).toList(),
      );
    }
    state = state.copyWith(isGenerating: false, isPaused: false);
  }

  String _generateGuideResponse(
    String query,
    MonumentModel monument,
    String language,
  ) {
    final q = query.toLowerCase();
    if (q.contains('eye') || q.contains('eyes') || q.contains('symbol')) {
      return _copy(
        language,
        'The painted eyes on ${monument.name} represent Buddha’s Wisdom Eyes. The symbol between them represents unity and the non-dual path to enlightenment.',
      );
    } else if (q.contains('restore') ||
        q.contains('restored') ||
        q.contains('earthquake')) {
      return _copy(
        language,
        'Following the 2015 earthquake, ${monument.name} underwent careful heritage restoration with traditional materials and local guthi knowledge.',
      );
    } else if (q.contains('ritual') ||
        q.contains('sunset') ||
        q.contains('worship')) {
      return _copy(
        language,
        'At sunset, pilgrims walk clockwise around ${monument.name}. Prayer wheels turn as butter lamps are lit around the sacred site.',
      );
    } else {
      return _copy(
        language,
        '${monument.name} is an example of ${monument.architecturalStyle}. Built in the ${monument.builtCentury}, it remains a living heritage site in ${monument.zone}.',
      );
    }
  }

  String _identifyImage(MonumentModel monument, String language) {
    return _copy(
      language,
      'This demo RAG match identifies the site as ${monument.name}. It is a ${monument.architecturalStyle} from the ${monument.builtCentury}, and the image can be examined for its structure, materials, and cultural setting.',
    );
  }

  String _copy(String language, String english) {
    if (language == 'नेपाली') {
      return 'यो डेमो RAG परिणामले यो स्थल ${state.activeMonument.name} हो भनी पहिचान गर्छ। यसको इतिहास, वास्तुकला र सांस्कृतिक अर्थबारे थप प्रश्न सोध्न सक्नुहुन्छ।';
    }
    if (language == 'हिन्दी') {
      return 'यह डेमो RAG परिणाम इस स्थल को ${state.activeMonument.name} के रूप में पहचानता है। आप इसके इतिहास, वास्तुकला और सांस्कृतिक अर्थ के बारे में और पूछ सकते हैं।';
    }
    if (language == 'Español') {
      return 'Este resultado RAG de demostración identifica el sitio como ${state.activeMonument.name}. Puedes preguntar más sobre su historia, arquitectura y significado cultural.';
    }
    if (language == 'Français') {
      return 'Ce résultat RAG de démonstration identifie le site comme ${state.activeMonument.name}. Vous pouvez demander son histoire, son architecture et sa signification culturelle.';
    }
    if (language == '中文') {
      return '这个演示 RAG 结果将遗址识别为 ${state.activeMonument.name}。你可以继续询问它的历史、建筑和文化意义。';
    }
    return english;
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final defaultMonument = ref.watch(featuredMonumentProvider);
  return ChatNotifier(defaultMonument);
});
