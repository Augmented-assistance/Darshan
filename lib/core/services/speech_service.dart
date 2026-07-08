import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SpeechService {
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();

  Future<void> init() async {
    await _speechToText.initialize();
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  Future<void> stopSpeaking() async {
    await _flutterTts.stop();
  }

  void listen({required Function(String) onResult}) {
    _speechToText.listen(onResult: (result) {
      if (result.finalResult) {
        onResult(result.recognizedWords);
      }
    });
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
  }

  bool get isListening => _speechToText.isListening;
}

final speechServiceProvider = Provider<SpeechService>((ref) {
  return SpeechService();
});
