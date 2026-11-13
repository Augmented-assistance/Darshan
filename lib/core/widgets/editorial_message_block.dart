import 'package:flutter/material.dart';
import 'dart:io';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

enum MessageRole { user, assistant }

class EditorialMessageBlock extends StatelessWidget {
  final String text;
  final MessageRole role;
  final bool isStreaming;
  final String? imagePath;

  const EditorialMessageBlock({
    super.key,
    required this.text,
    required this.role,
    this.isStreaming = false,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (role == MessageRole.user) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          constraints: const BoxConstraints(maxWidth: 300),
          decoration: BoxDecoration(
            color: AppColors.surface(isDark),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (imagePath != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.file(
                      File(imagePath!),
                      width: 220,
                      height: 165,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Text(
                text,
                style: AppTypography.body(AppColors.textPrimary(isDark)),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface(isDark),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          text,
          style: AppTypography.body(AppColors.textPrimary(isDark)),
        ),
      ),
    );
  }
}
