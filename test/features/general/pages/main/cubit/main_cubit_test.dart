import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/features/general/pages/main/cubit/main_cubit.dart';
import '../../../../../helpers/root_widget.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('MainCubit initMenu and updateIndex work with real context', (WidgetTester tester) async {
    late BuildContext capturedContext;
    await tester.pumpWidget(
      rootWidget(
        Builder(
          builder: (context) {
            capturedContext = context;
            return const SizedBox();
          },
        ),
      ),
    );

    final cubit = MainCubit();
    cubit.initMenu(capturedContext);
    cubit.updateIndex(1, context: capturedContext);

    expect(cubit.state, isA<MainState>());
    final state = cubit.state;
    final isSuccess = state.maybeWhen(success: (_) => true, orElse: () => false);
    expect(isSuccess, isTrue);
  });
} 