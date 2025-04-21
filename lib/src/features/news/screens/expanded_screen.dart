import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Displays a full-screen version of an image.
class ExpandedScreen extends StatelessWidget {
  final String imageUrl;
  const ExpandedScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.black,
        child: Center(
          child: InteractiveViewer(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.white)),
              errorWidget: (context, url, error) => const Center(child: Icon(Icons.error, color: Colors.red)),
            ),
          ),
        ),
      ),
    );
  }
}
