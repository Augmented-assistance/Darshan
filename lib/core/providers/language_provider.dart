import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageNotifier extends StateNotifier<String> {
  LanguageNotifier() : super('English');

  void select(String language) => state = language;

  String get localeCode {
    switch (state) {
      case 'नेपाली':
        return 'ne-NP';
      case 'हिन्दी':
        return 'hi-IN';
      case 'Español':
        return 'es-ES';
      case 'Français':
        return 'fr-FR';
      case '中文':
        return 'zh-CN';
      default:
        return 'en-US';
    }
  }
}

final languageProvider = StateNotifierProvider<LanguageNotifier, String>(
  (ref) => LanguageNotifier(),
);
