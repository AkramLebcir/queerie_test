import 'package:flutter/material.dart';
import 'package:queerie_test/core/widgets/widgets.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String year;
  final String posterUrl;
  final String? type;
  final VoidCallback? onTap;
  final String? heroPosterTag;
  final String? heroTitleTag;

  const MovieCard({
    super.key,
    required this.title,
    required this.year,
    required this.posterUrl,
    this.type,
    this.onTap,
    this.heroPosterTag,
    this.heroTitleTag,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImage = posterUrl.isNotEmpty && posterUrl != 'N/A';
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0.5,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heroPosterTag != null
                ? Hero(
                    tag: heroPosterTag!,
                    child: hasImage
                        ? ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.network(
                              posterUrl,
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 160,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.movie, size: 60),
                                );
                              },
                            ),
                          )
                        : Container(
                            height: 160,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: const Icon(Icons.movie, size: 60),
                          ),
                  )
                : hasImage
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: Image.network(
                          posterUrl,
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 160,
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: const Icon(Icons.movie, size: 60),
                            );
                          },
                        ),
                      )
                    : Container(
                        height: 160,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(Icons.movie, size: 60),
                      ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heroTitleTag != null
                      ? Hero(
                          tag: heroTitleTag!,
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      : Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                  const SpacerV(value: 8),
                  Row(
                    children: [
                      Expanded(child: Text(
                        year,
                        style: const TextStyle(fontSize: 13, color: Colors.grey),
                      ),),
                      if (type != null && type!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Chip(
                            label: Text(
                              type!.toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            backgroundColor: Theme.of(context).chipTheme.backgroundColor ?? Theme.of(context).colorScheme.surfaceVariant,
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 