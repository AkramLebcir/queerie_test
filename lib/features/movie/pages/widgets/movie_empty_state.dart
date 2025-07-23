import 'package:flutter/material.dart';
import 'package:queerie_test/core/localization/generated/strings.dart';

class MovieEmptyState extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;
  const MovieEmptyState({super.key, this.message, this.onRetry});

  bool get _isConnectionError =>
      message != null && message!.toLowerCase().contains('connection error');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message ?? Strings.of(context)!.noResults,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            if (_isConnectionError && onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 