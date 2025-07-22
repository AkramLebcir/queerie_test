import 'package:flutter/material.dart';
import 'package:queerie_test/core/core.dart';

class Empty extends StatelessWidget {
  final String? errorMessage;

  const Empty({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Opacity(
              opacity: 0.7,
              child: Image.asset(
                Images.icEmpty,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(
          errorMessage ?? Strings.of(context)!.errorNoData,
        ),
      ],
    );
  }
}
