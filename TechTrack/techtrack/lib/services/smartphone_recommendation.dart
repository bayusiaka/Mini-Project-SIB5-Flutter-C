import 'package:dio/dio.dart';

class SmartphoneRecommendationService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>?> getRecommendations({
    required String budget,
    required String brandPreference,
    required String operatingSystem,
  }) async {
    try {
      _dio.options = BaseOptions(
        baseUrl: 'https://api.openai.com/v1/chat/',
        headers: {
          'Authorization': 'Bearer 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',
        },
      );

      final response = await _dio.post('completions', data: {
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "system",
            "content":
                "Berikan saya 5 rekomendasi smartphone dengan budget maksimum $budget, dengan merek $brandPreference dan sistem operasi $operatingSystem. Berikan juga deskripsi produk beserta harganya."
          },
        ]
      });

      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (error) {
      print('Error: $error');
    }
    return null;
  }
}
