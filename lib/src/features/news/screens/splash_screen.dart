import 'dart:async';
import 'package:flutter/material.dart';
import 'package:newsapp/src/features/news/bloc/news_bloc.dart';
import 'listing_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  NewsBloc newsBloc = NewsBloc();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _animationController.forward();

    // Navigate to listing screen after delay
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ListingScreen(newsBloc: newsBloc)),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: currentTheme.brightness == Brightness.light ? Colors.white : Colors.black87,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.35,
                          decoration: BoxDecoration(
                            color: currentTheme.brightness == Brightness.light
                                ? Colors.deepPurple
                                : Colors.deepPurple.shade200,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: currentTheme.brightness == Brightness.light
                                    ? const Color.fromRGBO(103, 58, 183, 0.3)
                                    : const Color.fromRGBO(179, 157, 219, 0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.article_rounded,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'News App',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: currentTheme.brightness == Brightness.light ? Colors.black87 : Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
