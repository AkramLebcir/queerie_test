import 'package:flutter/material.dart';
import 'package:queerie_test/core/localization/generated/strings.dart';

class MovieSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final bool hasText;
  final VoidCallback onFilter;
  final VoidCallback onClear;
  final VoidCallback onSearch;
  final ValueChanged<String>? onSubmitted;

  const MovieSearchBar({
    super.key,
    required this.controller,
    required this.hasText,
    required this.onFilter,
    required this.onClear,
    required this.onSearch,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(12),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                hintText: Strings.of(context)!.searchHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      tooltip: Strings.of(context)!.filter,
                      onPressed: onFilter,
                    ),
                    if (hasText)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        tooltip: Strings.of(context)!.clear,
                        onPressed: onClear,
                      ),
                    if (hasText)
                      IconButton(
                        icon: const Icon(Icons.search),
                        tooltip: Strings.of(context)!.search,
                        onPressed: onSearch,
                      ),
                  ],
                ),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: onSubmitted,
            ),
          ),
        ),
      ],
    );
  }
} 