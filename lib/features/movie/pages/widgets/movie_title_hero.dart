import 'package:flutter/material.dart';

class MovieTitleHero extends StatelessWidget {
  final String title;
  final String heroTitleTag;

  const MovieTitleHero({
    super.key,
    required this.title,
    required this.heroTitleTag,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTitleTag,
      child: Material(
        type: MaterialType.transparency,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
} 