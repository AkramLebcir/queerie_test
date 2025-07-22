import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/features/general/pages/splashscreen/splash_screen_page.dart';
import '../../../../helpers/root_widget.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('SplashScreenPage renders launcher image', (WidgetTester tester) async {
    await tester.pumpWidget(rootWidget(const SplashScreenPage()));
    // The image asset is Images.icLauncher, but we can check for an Image widget
    expect(find.byType(Image), findsOneWidget);
  });
} 