import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/ai_service.dart';
import '../../core/services/speech_service.dart';
import '../../models/chat_message.dart';
import '../../models/place_result.dart';
import 'widgets/guide_overlay.dart';
import 'widgets/info_panel.dart';
import 'widgets/chat_input_bar.dart';

class GuideScreen extends ConsumerStatefulWidget {
  final PlaceResult place;
  const GuideScreen({super.key, required this.place});

  @override
  ConsumerState<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends ConsumerState<GuideScreen> {
  final List<ChatMessage> _messages = [];
  bool _isSpeaking = false;
  bool _isWaitingForAI = false;

  @override
  void initState() {
    super.initState();
    // Initial greeting from guide
    _messages.add(ChatMessage(
      text: "Welcome to ${widget.place.name}! ${widget.place.description}",
      sender: MessageSender.guide,
      timestamp: DateTime.now(),
    ));
    _speakGuideMessage(_messages.last.text);
  }

  void _speakGuideMessage(String text) async {
    if (_isSpeaking) return;
    final speechService = ref.read(speechServiceProvider);
    await speechService.init();
    await speechService.speak(text);
  }

  Future<void> _handleSendMessage(String text) async {
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        sender: MessageSender.user,
        timestamp: DateTime.now(),
      ));
      _isWaitingForAI = true;
    });

    try {
      final aiService = ref.read(aiServiceProvider);
      final response = await aiService.askFollowUp(text, widget.place);
      
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            text: response,
            sender: MessageSender.guide,
            timestamp: DateTime.now(),
          ));
          _isWaitingForAI = false;
        });
        _speakGuideMessage(response);
      }
    } catch (e) {
       if (mounted) {
        setState(() => _isWaitingForAI = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error getting AI response: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place.name),
        actions: [
          IconButton(
            icon: Icon(_isSpeaking ? Icons.volume_up : Icons.volume_off),
            onPressed: () {
              setState(() => _isSpeaking = !_isSpeaking);
              if (!_isSpeaking) {
                ref.read(speechServiceProvider).stopSpeaking();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child: GuideOverlay(),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      InfoPanel(place: widget.place),
                      ..._messages.map((m) => _ChatBubble(message: m)),
                      if (_isWaitingForAI)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  ),
                ),
                ChatInputBar(onSendMessage: _handleSendMessage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;
  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MessageSender.user;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isUser ? Colors.deepPurple : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(isUser ? 12 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 12),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
