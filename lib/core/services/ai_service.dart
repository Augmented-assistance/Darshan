import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/place_result.dart';

abstract class AIService {
  Future<PlaceResult> analyzeImage(File image);
  Future<String> askFollowUp(String question, PlaceResult context);
}

class MockAIService implements AIService {
  @override
  Future<PlaceResult> analyzeImage(File image) async {
    // Simulate processing delay
    await Future.delayed(const Duration(seconds: 2));
    
    // TODO: Replace with real AI/ML image analysis logic
    return PlaceResult(
      name: "Sample Landmark",
      description: "This is placeholder text describing the place. Replace with real AI output later. It is a beautiful historical site with rich cultural heritage.",
      confidence: 0.95,
    );
  }

  @override
  Future<String> askFollowUp(String question, PlaceResult context) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // TODO: Replace with real LLM/AI chat logic
    return "This is a placeholder answer to: \"$question\" about ${context.name}.";
  }
}

final aiServiceProvider = Provider<AIService>((ref) {
  return MockAIService();
});
