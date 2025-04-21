/// A model class representing a news article.
class NewsArticle {
  final String title;
  final String imageUrl;
  final String uuid;
  final String description;
  final String url;
  final String publishedAt;

  NewsArticle(
      {required this.title,
      required this.imageUrl,
      this.description = '',
      this.url = '',
      this.uuid = '',
      this.publishedAt = ''});

  /// Creates a `NewsArticle` instance from a JSON map
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
        title: json['title'] ?? 'No Title',
        imageUrl: json['image_url'] ?? '',
        description: json['description'] ?? '',
        url: json['url'] ?? '',
        uuid: json['uuid'] ?? '',
        publishedAt: json['publishedAt'] ?? '');
  }

  /// Converts a `NewsArticle` instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image_url': imageUrl,
      'description': description,
      'url': url,
      'uuid': uuid,
      'publishedAt': publishedAt,
    };
  }
}
