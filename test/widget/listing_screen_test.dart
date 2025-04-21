import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:newsapp/src/features/news/bloc/news_bloc.dart';
import 'package:newsapp/src/features/news/bloc/news_event.dart';
import 'package:newsapp/src/features/news/bloc/news_state.dart';
import 'package:newsapp/src/features/news/models/news_model.dart';
import 'package:newsapp/src/features/news/screens/listing_screen.dart';
import 'package:newsapp/src/features/news/widgets/news_tile.dart';

///widget tests
class MockNewsBloc extends Mock implements NewsBloc {}

class MockNewsEvent extends Fake implements NewsEvent {}

class MockNewsState extends Fake implements NewsState {}

void main() {
  late MockNewsBloc mockNewsBloc;

  // Sample news articles for testing
  final testArticles = [
    NewsArticle(
      title: 'Test Article 1',
      imageUrl: 'https://example.com/image1.jpg',
      publishedAt: DateTime.now().toIso8601String(),
      url: 'https://example.com/article1',
    ),
    NewsArticle(
      title: 'Test Article 2',
      imageUrl: 'https://example.com/image2.jpg',
      publishedAt: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      url: 'https://example.com/article2',
    ),
  ];

  setUpAll(() {
    // Register fallbacks for blocTest to work with Mocktail
    registerFallbackValue(MockNewsEvent());
    registerFallbackValue(MockNewsState());
  });

  setUp(() {
    mockNewsBloc = MockNewsBloc();
  });

  testWidgets('should show loading state initially', (WidgetTester tester) async {
    when(() => mockNewsBloc.state).thenReturn(NewsLoading());
    when(() => mockNewsBloc.stream).thenAnswer((_) => Stream.value(NewsLoading()));
    when(() => mockNewsBloc.add(any())).thenReturn(null);
    when(() => mockNewsBloc.close()).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: ListingScreen(newsBloc: mockNewsBloc),
      ),
    );
    await tester.pump();

    expect(find.text('Top Stories'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);

    verify(() => mockNewsBloc.add(any(that: isA<FetchNews>()))).called(1);
  });

  testWidgets('should display news articles when loaded', (WidgetTester tester) async {
    when(() => mockNewsBloc.state).thenReturn(NewsLoaded(testArticles));
    when(() => mockNewsBloc.stream).thenAnswer((_) => Stream.value(NewsLoaded(testArticles)));
    when(() => mockNewsBloc.add(any())).thenReturn(null);
    when(() => mockNewsBloc.close()).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: ListingScreen(newsBloc: mockNewsBloc),
      ),
    );
    await tester.pump();

    expect(find.text('Top Stories'), findsOneWidget);
    expect(find.byType(NewsTile), findsNWidgets(2));
    expect(find.text('Test Article 1'), findsOneWidget);
    expect(find.text('Test Article 2'), findsOneWidget);
  });

  testWidgets('should display error UI when error occurs', (WidgetTester tester) async {
    when(() => mockNewsBloc.state).thenReturn(NewsError('Failed to load news'));
    when(() => mockNewsBloc.stream).thenAnswer((_) => Stream.value(NewsError('Failed to load news')));
    when(() => mockNewsBloc.add(any())).thenReturn(null);
    when(() => mockNewsBloc.close()).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: ListingScreen(newsBloc: mockNewsBloc),
      ),
    );
    await tester.pump();

    expect(find.text('Oops! Something went wrong.'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Try Again'), findsOneWidget);

    await tester.tap(find.text('Try Again'));
    await tester.pump();

    verify(() => mockNewsBloc.add(any(that: isA<FetchNews>()))).called(2); // Once on init, once on tap
  });

  testWidgets('should trigger RefreshNews when pull-to-refresh is used', (WidgetTester tester) async {
    when(() => mockNewsBloc.state).thenReturn(NewsLoaded(testArticles));
    when(() => mockNewsBloc.stream).thenAnswer((_) => Stream.value(NewsLoaded(testArticles)));
    when(() => mockNewsBloc.add(any())).thenReturn(null);
    when(() => mockNewsBloc.close()).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: ListingScreen(newsBloc: mockNewsBloc),
      ),
    );
    await tester.pump();

    await tester.drag(find.byType(ListView), const Offset(0, 300));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    verify(() => mockNewsBloc.add(any(that: isA<RefreshNews>()))).called(1);
  });
}
