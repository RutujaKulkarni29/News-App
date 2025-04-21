import '../models/news_model.dart';

/// Abstract base class for all possible states in the NewsBloc.
abstract class NewsState {}

/// Initial state
class NewsInitial extends NewsState {}

/// Loading state, emitted when news articles are being fetched from the API.
class NewsLoading extends NewsState {}

/// State emitted when news articles are successfully fetched.
class NewsLoaded extends NewsState {
  final List<NewsArticle> articles;
  NewsLoaded(this.articles);
}

/// State emitted when an error occurs
class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
}
