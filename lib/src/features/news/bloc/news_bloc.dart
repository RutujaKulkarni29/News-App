import 'package:flutter_bloc/flutter_bloc.dart';
import 'news_event.dart';
import 'news_state.dart';
import '../../../core/network/api_client.dart';
import '../../../features/news/models/news_model.dart';

/// BLoC (Business Logic Component) responsible for managing the state of news data.
/// Events handled: `FetchNews` and  `RefreshNews`
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  int _currentPage = 1;
  bool _isFetching = false;
  final int _pageSize = 10;
  List<NewsArticle> _allArticles = [];
  final ApiClient _apiClient = ApiClient();

  NewsBloc() : super(NewsInitial()) {
    on<FetchNews>((event, emit) async {
      if (_isFetching) return;
      _isFetching = true;
      if (_currentPage == 1) emit(NewsLoading());
      try {
        final articles = await _apiClient.fetchNews(page: _currentPage, limit: _pageSize);
        if (_currentPage == 1) {
          _allArticles = articles;
        } else {
          _allArticles.addAll(articles);
        }
        emit(NewsLoaded(List.from(_allArticles)));
        _currentPage++;
      } catch (e) {
        emit(NewsError(e.toString()));
      } finally {
        _isFetching = false;
      }
    });
    on<RefreshNews>((event, emit) async {
      _currentPage = 1;
      _allArticles.clear();
      add(FetchNews());
    });
  }
}
