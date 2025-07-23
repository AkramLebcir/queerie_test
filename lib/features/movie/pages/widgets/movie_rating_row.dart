import 'package:flutter/material.dart';

class MovieRatingRow extends StatelessWidget {
  final String? imdbRating;
  final String? imdbVotes;

  const MovieRatingRow({
    super.key,
    this.imdbRating,
    this.imdbVotes,
  });

  @override
  Widget build(BuildContext context) {
    if ((imdbRating == null || imdbRating == 'N/A') &&
        (imdbVotes == null || imdbVotes == 'N/A')) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        if (imdbRating != null && imdbRating != 'N/A') ...[
          const Icon(Icons.star, color: Colors.amber),
          const SizedBox(width: 4),
          Text(
            imdbRating!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
        if (imdbVotes != null && imdbVotes != 'N/A') ...[
          const SizedBox(width: 16),
          const Icon(Icons.people_outline),
          const SizedBox(width: 4),
          Text(
            _formatVotes(imdbVotes!),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ],
    );
  }

  String _formatVotes(String votes) {
    // Remove commas and convert to number
    final number = int.tryParse(votes.replaceAll(',', ''));
    if (number == null) return votes;

    // Format in K or M
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
} 