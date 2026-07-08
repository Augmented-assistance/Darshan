import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/speech_service.dart';

class ChatInputBar extends ConsumerStatefulWidget {
  final Function(String) onSendMessage;
  const ChatInputBar({super.key, required this.onSendMessage});

  @override
  ConsumerState<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends ConsumerState<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  bool _isListening = false;

  void _handleSend() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSendMessage(_controller.text.trim());
      _controller.clear();
    }
  }

  void _toggleListening() async {
    final speechService = ref.read(speechServiceProvider);
    if (_isListening) {
      await speechService.stopListening();
      setState(() => _isListening = false);
    } else {
      setState(() => _isListening = true);
      speechService.listen(onResult: (text) {
        setState(() {
          _controller.text = text;
          _isListening = false;
        });
        // Optionally auto-send when speech is finished
        _handleSend();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                color: _isListening ? Colors.red : Colors.deepPurple,
              ),
              onPressed: _toggleListening,
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Ask about this place...',
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _handleSend(),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.deepPurple),
              onPressed: _handleSend,
            ),
          ],
        ),
      ),
    );
  }
}
