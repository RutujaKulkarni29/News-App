import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Widget that adds loading effect on the UI while fetching news articles
class LoadNewsTile extends StatelessWidget {
  const LoadNewsTile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: screenHeight * 0.25,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
