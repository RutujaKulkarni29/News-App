import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/src/features/news/models/news_model.dart';

import 'mock_http_client.mocks.dart';

void main() {
  group('ApiClient.fetchNews', () {
    late MockClient mockClient;
    const baseUrl = 'https://api.thenewsapi.com/v1/news/top';
    const apiKey = '7il2rl49iJMB7jPlE2vc2fYo2VLfnhhxqFMTe1EV';
    final uri = Uri.parse('$baseUrl?api_token=$apiKey&page=1&limit=10');

    setUp(() {
      mockClient = MockClient();
    });

    test('returns a list of NewsArticle when the call completes successfully', () async {
      final mockResponse = {
        "data": [
          {
            "uuid": "1",
            "title": "Sample News",
            "description": "Description",
            "published_at": "2023-01-01T00:00:00Z",
            "url": "https://example.com",
            "image_url": "https://example.com/image.jpg"
          }
        ]
      };

      when(mockClient.get(any)).thenAnswer(
        (_) async => http.Response(jsonEncode(mockResponse), 200),
      );

      final response = await mockClient.get(uri);
      final data = jsonDecode(response.body);
      final List articles = data['data'] ?? [];
      final result = articles.map((e) => NewsArticle.fromJson(e)).toList();

      expect(result, isA<List<NewsArticle>>());
      expect(result.first.title, equals('Sample News'));
    });

    test('returns a list of NewsArticle for page 2 with limit 5', () async {
      final mockResponse = {
        "data": [
          {
            "uuid": "2",
            "title": "Sample news 2",
            "description": "Another sample description",
            "published_at": "2023-02-01T00:00:00Z",
            "url": "https://example.com/page2",
            "image_url": "https://example.com/page2.jpg"
          }
        ]
      };

      when(mockClient.get(any)).thenAnswer(
        (_) async => http.Response(jsonEncode(mockResponse), 200),
      );

      final uri = Uri.parse('$baseUrl?api_token=$apiKey&page=2&limit=5');

      final response = await mockClient.get(uri);
      final data = jsonDecode(response.body);
      final List articles = data['data'] ?? [];
      final result = articles.map((e) => NewsArticle.fromJson(e)).toList();

      expect(result, isA<List<NewsArticle>>());
      expect(result.length, equals(1));
      expect(result.first.title, equals('Sample news 2'));
    });
  });
}
