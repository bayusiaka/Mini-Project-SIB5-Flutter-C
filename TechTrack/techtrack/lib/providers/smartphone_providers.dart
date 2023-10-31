import 'package:flutter/material.dart';
import 'package:techtrack/services/smartphone_recommendation.dart';

class SmartphoneRecommendationProvider extends ChangeNotifier {
  final SmartphoneRecommendationService _service = SmartphoneRecommendationService();
  Map<String, dynamic>? recommendation;

  Future<void> getRecommendations({
    required String budget,
    required String brandPreference,
    required String operatingSystem,
  }) async {
    recommendation = await _service.getRecommendations(
      budget: budget,
      brandPreference: brandPreference,
      operatingSystem: operatingSystem,
    );
    notifyListeners();
  }
}