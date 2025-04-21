abstract class NewsEvent {}

///Fetches news articles with pagination.
class FetchNews extends NewsEvent {}

///Clears current news data and reloads from the first page.
class RefreshNews extends NewsEvent {}
