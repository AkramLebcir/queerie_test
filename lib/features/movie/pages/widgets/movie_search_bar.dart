import 'package:flutter/material.dart';
import 'package:queerie_test/core/localization/generated/strings.dart';

class MovieSearchBar extends StatefulWidget {
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
  State<MovieSearchBar> createState() => _MovieSearchBarState();
}

class _MovieSearchBarState extends State<MovieSearchBar> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final shouldShowButtons = widget.hasText || _isFocused;

    return Row(
      children: [
        Expanded(
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(12),
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
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
                      onPressed: widget.onFilter,
                    ),
                    if (shouldShowButtons)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        tooltip: Strings.of(context)!.clear,
                        onPressed: widget.onClear,
                      ),
                    if (shouldShowButtons)
                      IconButton(
                        icon: const Icon(Icons.search),
                        tooltip: Strings.of(context)!.search,
                        onPressed: widget.onSearch,
                      ),
                  ],
                ),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: widget.onSubmitted,
            ),
          ),
        ),
      ],
    );
  }
} 