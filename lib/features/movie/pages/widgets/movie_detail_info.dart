import 'package:flutter/material.dart';
import 'package:queerie_test/core/localization/generated/strings.dart';

class MovieDetailInfo extends StatelessWidget {
  final String? plot;
  final String? director;
  final String? writer;
  final String? actors;
  final String? released;
  final String? awards;
  final String? boxOffice;
  final String? production;

  const MovieDetailInfo({
    super.key,
    this.plot,
    this.director,
    this.writer,
    this.actors,
    this.released,
    this.awards,
    this.boxOffice,
    this.production,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (plot != null && plot != 'N/A') ...[
          _buildSection(Strings.of(context)!.plot, plot!),
          const SizedBox(height: 16),
        ],
        if (director != null && director != 'N/A') ...[
          _buildSection(Strings.of(context)!.director, director!),
          const SizedBox(height: 16),
        ],
        if (writer != null && writer != 'N/A') ...[
          _buildSection(Strings.of(context)!.writer, writer!),
          const SizedBox(height: 16),
        ],
        if (actors != null && actors != 'N/A') ...[
          _buildSection(Strings.of(context)!.cast, actors!),
          const SizedBox(height: 16),
        ],
        if (released != null && released != 'N/A') ...[
          _buildSection(Strings.of(context)!.releaseDate, released!),
          const SizedBox(height: 16),
        ],
        if (awards != null && awards != 'N/A') ...[
          _buildSection(Strings.of(context)!.awards, awards!),
          const SizedBox(height: 16),
        ],
        if (boxOffice != null && boxOffice != 'N/A') ...[
          _buildSection(Strings.of(context)!.boxOffice, boxOffice!),
          const SizedBox(height: 16),
        ],
        if (production != null && production != 'N/A')
          _buildSection(Strings.of(context)!.production, production!),
      ],
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
} 