import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_typography.dart';
import '../../core/providers/language_provider.dart';
import '../../core/theme/app_strings.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/editorial_message_block.dart';
import '../../core/widgets/outlined_chip.dart';
import '../../core/widgets/pinned_context_bar.dart';
import '../../core/widgets/thin_ring_loader.dart';
import '../monument/models/monument_model.dart';
import 'providers/chat_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final MonumentModel? initialMonument;
  final String? initialPrompt;
  const ChatScreen({super.key, this.initialMonument, this.initialPrompt});
  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _scrollController = ScrollController();
  final _inputController = TextEditingController();
  final _picker = ImagePicker();
  final _tts = FlutterTts();
  final _speech = stt.SpeechToText();
  final _inputFocusNode = FocusNode();
  bool _isListening = false;
  int _spokenOffset = 0;
  bool _ttsPaused = false;
  String _lastSpokenChunk = '';

  @override
  void initState() {
    super.initState();
    _tts.setQueueMode(1);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialMonument != null) {
        ref
            .read(chatProvider.notifier)
            .setMonumentContext(widget.initialMonument!);
      }
      if (widget.initialPrompt?.isNotEmpty == true) {
        _handleSend(widget.initialPrompt!);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _inputController.dispose();
    _inputFocusNode.dispose();
    _tts.stop();
    super.dispose();
  }

  void _handleSend(String text) {
    if (text.trim().isEmpty) return;
    _spokenOffset = 0;
    _ttsPaused = false;
    _lastSpokenChunk = '';
    final language = ref.read(languageProvider);
    ref.read(chatProvider.notifier).sendMessage(text, language: language);
    _inputController.clear();
  }

  Future<void> _toggleGeneration() async {
    final notifier = ref.read(chatProvider.notifier);
    final wasPaused = ref.read(chatProvider).isPaused;
    notifier.togglePause();
    if (wasPaused) {
      _ttsPaused = false;
      if (_lastSpokenChunk.isNotEmpty) {
        await _tts.speak(_lastSpokenChunk);
      }
    } else {
      _ttsPaused = true;
      await _tts.pause();
    }
  }

  void _speakStreamingText(String text, {required bool isComplete}) {
    if (_ttsPaused || text.length <= _spokenOffset) return;
    final remaining = text.substring(_spokenOffset);
    final boundary = remaining.lastIndexOf(RegExp(r'[.!?。！？]'));
    if (!isComplete && boundary < 24 && remaining.length < 64) return;
    final end = isComplete
        ? text.length
        : boundary >= 0
        ? _spokenOffset + boundary + 1
        : (_spokenOffset + 64).clamp(0, text.length);
    final chunk = text.substring(_spokenOffset, end).trim();
    if (chunk.isEmpty) return;
    _spokenOffset = end;
    _lastSpokenChunk = chunk;
    _tts.setLanguage(ref.read(languageProvider.notifier).localeCode);
    _tts.speak(chunk);
  }

  Future<void> _pickImage(ImageSource source) async {
    final image = await _picker.pickImage(source: source);
    if (image == null || !mounted) return;
    _spokenOffset = 0;
    _ttsPaused = false;
    _lastSpokenChunk = '';
    final language = ref.read(languageProvider);
    ref
        .read(chatProvider.notifier)
        .sendMessage('', imagePath: image.path, language: language);
  }

  Future<void> _openCamera() => _pickImage(ImageSource.camera);

  Future<void> _openGallery() => _pickImage(ImageSource.gallery);

  Future<void> _toggleVoiceSearch() async {
    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
      return;
    }
    final available = await _speech.initialize();
    if (!available) return;
    _inputFocusNode.requestFocus();
    setState(() => _isListening = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _inputFocusNode.requestFocus();
        SystemChannels.textInput.invokeMethod<void>('TextInput.show');
      }
    });
    await _speech.listen(
      listenOptions: stt.SpeechListenOptions(
        localeId: ref.read(languageProvider.notifier).localeCode,
      ),
      onResult: (result) {
        _inputController.text = result.recognizedWords;
        _inputController.selection = TextSelection.collapsed(
          offset: _inputController.text.length,
        );
        if (result.finalResult && mounted) setState(() => _isListening = false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(chatProvider);
    final language = ref.watch(languageProvider);
    String text(String key) => AppStrings.get(language, key);
    ref.listen(chatProvider, (previous, next) {
      if (next.messages.isEmpty) return;
      final message = next.messages.last;
      final wasStreaming =
          previous?.messages.isNotEmpty == true &&
          previous!.messages.last.id == message.id &&
          previous.messages.last.isStreaming;
      if (message.role == MessageRole.assistant &&
          message.text.isNotEmpty &&
          (message.isStreaming || wasStreaming)) {
        _speakStreamingText(message.text, isComplete: !message.isStreaming);
      }
    });
    final messages = state.messages;
    final prompts = [
      text('prompt1'),
      text('prompt2'),
      text('prompt3'),
      text('prompt4'),
    ];
    return Scaffold(
      backgroundColor: AppColors.bgPrimary(isDark),
      appBar: AppBar(
        title: Text(
          'Darshan',
          style: AppTypography.h4(AppColors.textPrimary(isDark)),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Choose language',
            icon: const Icon(Icons.translate_outlined),
            onSelected: (language) async {
              ref.read(languageProvider.notifier).select(language);
              await _tts.setLanguage(
                ref.read(languageProvider.notifier).localeCode,
              );
            },
            itemBuilder: (context) {
              final selectedLanguage = ref.read(languageProvider);
              return [
                for (final language in const [
                  'English',
                  'नेपाली',
                  'हिन्दी',
                  'Español',
                  'Français',
                  '中文',
                ])
                  PopupMenuItem<String>(
                    value: language,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24,
                          child: language == selectedLanguage
                              ? const Icon(Icons.check, size: 18)
                              : null,
                        ),
                        Text(language),
                      ],
                    ),
                  ),
              ];
            },
          ),
        ],
      ),
      drawer: _HistoryDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            if (messages.isNotEmpty)
              PinnedContextBar(
                monumentName: state.activeMonument.name,
                zone: state.activeMonument.zone,
                imageUrl: state.activeMonument.imageUrl,
                onChangeTap: () {},
              ),
            Expanded(
              child: messages.isEmpty
                  ? _EmptyChat(onPrompt: _handleSend, language: language)
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                      itemCount: messages.length + (state.isGenerating ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                ThinRingLoader(size: 16),
                                SizedBox(width: 8),
                                Text(text('responding')),
                              ],
                            ),
                          );
                        }
                        final message = messages[index];
                        return EditorialMessageBlock(
                          text: message.text,
                          role: message.role,
                          imagePath: message.imagePath,
                          isStreaming: message.isStreaming,
                        );
                      },
                    ),
            ),
            if (messages.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 12, bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: prompts
                              .map(
                                (p) => Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: OutlinedChip(
                                    label: p,
                                    onTap: () => _handleSend(p),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _ComposerAction(
                      isGenerating: state.isGenerating,
                      isPaused: state.isPaused,
                      isDark: isDark,
                      onTap: state.isGenerating
                          ? _toggleGeneration
                          : () => _handleSend(_inputController.text),
                    ),
                  ],
                ),
              ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.borderHairline(isDark)),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _inputController,
                      focusNode: _inputFocusNode,
                      prefixIcon: GestureDetector(
                        onTap: _openGallery,
                        child: Icon(
                          Icons.attach_file,
                          size: 20,
                          color: AppColors.textSecondary(isDark),
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: _toggleVoiceSearch,
                        child: _isListening
                            ? _VoiceListeningIndicator(
                                color: AppColors.accent(isDark),
                              )
                            : Icon(
                                Icons.mic_none,
                                size: 20,
                                color: AppColors.textSecondary(isDark),
                              ),
                      ),
                      hintText: text('ask'),
                      onSubmitted: _handleSend,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _ComposerIconButton(
                    icon: Icons.camera_alt_outlined,
                    label: 'Open camera',
                    color: AppColors.textSecondary(isDark),
                    onTap: _openCamera,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComposerAction extends StatelessWidget {
  final bool isGenerating;
  final bool isPaused;
  final bool isDark;
  final VoidCallback onTap;

  const _ComposerAction({
    required this.isGenerating,
    required this.isPaused,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: isGenerating && !isPaused ? 'Pause response' : 'Play response',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.button),
          onTap: onTap,
          child: Ink(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.accent(isDark),
              borderRadius: BorderRadius.circular(AppRadius.button),
            ),
            child: Icon(
              isGenerating && !isPaused ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class _ComposerIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ComposerIconButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: IconButton(
        onPressed: onTap,
        tooltip: label,
        icon: Icon(icon, size: 22, color: color),
        constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
        padding: EdgeInsets.zero,
      ),
    );
  }
}

class _VoiceListeningIndicator extends StatefulWidget {
  final Color color;
  const _VoiceListeningIndicator({required this.color});

  @override
  State<_VoiceListeningIndicator> createState() =>
      _VoiceListeningIndicatorState();
}

class _VoiceListeningIndicatorState extends State<_VoiceListeningIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              final height = 8 + (((_controller.value + index / 3) % 1) * 12);
              return Container(
                width: 3,
                height: height,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class _EmptyChat extends StatelessWidget {
  final ValueChanged<String> onPrompt;
  final String language;
  const _EmptyChat({required this.onPrompt, required this.language});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final prompts = [
      AppStrings.get(language, 'prompt1'),
      AppStrings.get(language, 'prompt2'),
      AppStrings.get(language, 'prompt3'),
      AppStrings.get(language, 'prompt4'),
    ];
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.get(language, 'hello'),
              style: AppTypography.h2(AppColors.textSecondary(isDark)),
            ),
            const SizedBox(height: 4),
            Text(
              AppStrings.get(language, 'help'),
              style: AppTypography.h1(AppColors.textPrimary(isDark)),
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.get(language, 'description'),
              style: AppTypography.bodyLarge(AppColors.textSecondary(isDark)),
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = (constraints.maxWidth - 10) / 2;
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: prompts
                      .map(
                        (prompt) => SizedBox(
                          width: width,
                          child: OutlinedChip(
                            label: prompt,
                            onTap: () => onPrompt(prompt),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryDrawer extends StatelessWidget {
  const _HistoryDrawer();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Drawer(
      width: (MediaQuery.sizeOf(context).width * .82).clamp(0, 320),
      backgroundColor: AppColors.surface(isDark),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 12, 16),
              child: Text(
                'Conversations',
                style: AppTypography.h2(AppColors.textPrimary(isDark)),
              ),
            ),
            Divider(color: AppColors.borderHairline(isDark), height: 1),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'No saved conversations',
                style: AppTypography.body(AppColors.textSecondary(isDark)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
