import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/src/features/news/widgets/loading_widget.dart';
import '../bloc/news_bloc.dart';
import '../bloc/news_event.dart';
import '../bloc/news_state.dart';
import '../widgets/news_tile.dart';

/// This screen displays the news articles
class ListingScreen extends StatefulWidget {
  final NewsBloc newsBloc;
  const ListingScreen({super.key, required this.newsBloc});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  late NewsBloc _newsBloc;

  @override
  void initState() {
    super.initState();
    _newsBloc = widget.newsBloc..add(FetchNews());
  }

  @override
  void dispose() {
    _newsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BlocProvider<NewsBloc>(
      create: (_) => _newsBloc,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            decoration: BoxDecoration(
              color: isDarkMode ? const Color.fromRGBO(0, 0, 0, 0.8) : const Color.fromRGBO(255, 255, 255, 0.9),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: AppBar(
              title: Text(
                'Top Stories',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode == true ? Colors.white : Colors.black87,
                  letterSpacing: 0.5,
                ),
              ),
              centerTitle: true,
              backgroundColor: isDarkMode ? const Color.fromRGBO(0, 0, 0, 0.4) : Colors.grey.shade200,
              elevation: 0,
              foregroundColor: Colors.black87,
              toolbarHeight: 70,
            ),
          ),
        ),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                itemCount: 10,
                itemBuilder: (context, index) => const LoadNewsTile(),
              );
            } else if (state is NewsLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  _newsBloc.add(RefreshNews());
                },
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  itemCount: state.articles.length,
                  itemBuilder: (context, index) {
                    return NewsTile(article: state.articles[index]);
                  },
                ),
              );
            } else if (state is NewsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red[300],
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Oops! Something went wrong.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? Colors.white : Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => _newsBloc.add(FetchNews()),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
