import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:queerie_test/dependencies_injection.dart';
import 'package:queerie_test/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Register Service locator
  await serviceLocator();

  return SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then((_) => runApp(MyApp()));
}