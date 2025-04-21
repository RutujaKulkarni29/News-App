import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../features/news/models/news_model.dart';

/// Class responsible for handling API calls and data fetching logic.
class ApiClient {
  final http.Client client;
  ApiClient({http.Client? client}) : client = client ?? http.Client();

  static const String baseUrl = 'https://api.thenewsapi.com/v1/news/top';
  static const String apiKey = '7il2rl49iJMB7jPlE2vc2fYo2VLfnhhxqFMTe1EV';

  Future<List<NewsArticle>> fetchNews({int page = 1, int limit = 10}) async {
    try {
      final uri = Uri.parse(
        '$baseUrl?api_token=$apiKey&page=$page&limit=$limit',
      );

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List articles = data['data'] ?? [];
        return articles.map((e) => NewsArticle.fromJson(e)).toList();
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error']?['message'] ?? 'Failed to fetch news');
      }
    } catch (e) {
      print('FetchNews Error: $e');
      throw Exception('Failed to fetch news: $e');
    }
  }
}
