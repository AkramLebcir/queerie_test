import 'package:flutter/material.dart';

class MoviePosterHero extends StatelessWidget {
  final String? posterUrl;
  final String heroPosterTag;

  const MoviePosterHero({
    super.key,
    required this.posterUrl,
    required this.heroPosterTag,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroPosterTag,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: posterUrl != null && posterUrl != 'N/A'
            ? Image.network(
                posterUrl!,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 50),
                  );
                },
              )
            : Container(
                height: 300,
                width: double.infinity,
                color: Colors.grey[300],
                child: const Icon(Icons.image_not_supported, size: 50),
              ),
      ),
    );
  }
} 