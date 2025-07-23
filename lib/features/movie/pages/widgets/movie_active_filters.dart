import 'package:flutter/material.dart';
import 'package:queerie_test/core/localization/generated/strings.dart';

class MovieActiveFilters extends StatelessWidget {
  final String? type;
  final String? year;
  final VoidCallback onClearAll;
  final VoidCallback? onRemoveType;
  final VoidCallback? onRemoveYear;

  const MovieActiveFilters({
    super.key,
    this.type,
    this.year,
    required this.onClearAll,
    this.onRemoveType,
    this.onRemoveYear,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> chips = [];
    if (type != null && type!.isNotEmpty) {
      chips.add(Padding(
        padding: const EdgeInsets.only(right: 6),
        child: InputChip(
          label: Row(
            children: [
              const Icon(Icons.category, size: 16),
              const SizedBox(width: 4),
              Text('${Strings.of(context)!.type}: ${type!.toUpperCase()}'),
            ],
          ),
          onDeleted: onRemoveType,
        ),
      ));
    }
    if (year != null && year!.isNotEmpty) {
      chips.add(Padding(
        padding: const EdgeInsets.only(right: 6),
        child: InputChip(
          label: Row(
            children: [
              const Icon(Icons.calendar_today, size: 16),
              const SizedBox(width: 4),
              Text('${Strings.of(context)!.year}: ${year!}'),
            ],
          ),
          onDeleted: onRemoveYear,
        ),
      ));
    }
    if (chips.isEmpty) return const SizedBox.shrink();
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: chips),
          ),
        ),
        TextButton.icon(
          onPressed: onClearAll,
          icon: const Icon(Icons.clear),
          label: Text(Strings.of(context)!.clearAll),
        ),
      ],
    );
  }
} 