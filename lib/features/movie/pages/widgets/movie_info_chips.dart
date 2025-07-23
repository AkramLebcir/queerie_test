import 'package:flutter/material.dart';

class MovieInfoChips extends StatelessWidget {
  final String? rated;
  final String? runtime;
  final String? genre;

  const MovieInfoChips({
    super.key,
    this.rated,
    this.runtime,
    this.genre,
  });

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[];

    if (rated != null && rated != 'N/A') {
      chips.add(_buildChip(
        rated!,
        icon: Icons.star_border,
        color: _getRatedColor(rated!),
      ));
    }

    if (runtime != null && runtime != 'N/A') {
      chips.add(_buildChip(
        runtime!,
        icon: Icons.timer_outlined,
      ));
    }

    if (genre != null && genre != 'N/A') {
      final genres = genre!.split(',');
      for (final g in genres) {
        chips.add(_buildChip(
          g.trim(),
          icon: Icons.movie_outlined,
        ));
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < chips.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            chips[i],
          ],
        ],
      ),
    );
  }

  Widget _buildChip(String label, {IconData? icon, Color? color}) {
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
          ],
          Text(label, style: TextStyle(color: color)),
        ],
      ),
      backgroundColor: color?.withOpacity(0.1),
    );
  }

  Color _getRatedColor(String rated) {
    switch (rated.toUpperCase()) {
      case 'G':
        return Colors.green;
      case 'PG':
        return Colors.blue;
      case 'PG-13':
        return Colors.orange;
      case 'R':
        return Colors.red;
      case 'NC-17':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
} 