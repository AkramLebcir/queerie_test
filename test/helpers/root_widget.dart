import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queerie_test/core/localization/generated/strings.dart';
import 'package:queerie_test/core/resources/styles.dart';

Widget rootWidget(Widget body) {
  return ScreenUtilInit(
    designSize: const Size(375, 667),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (_, __) => MaterialApp(
      localizationsDelegates: Strings.localizationsDelegates,
      supportedLocales: Strings.supportedLocales,
      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          const CustomColors(
            background: Colors.white,
            card: Colors.white,
            buttonText: Colors.black,
            subtitle: Colors.grey,
            shadow: Colors.black12,
            green: Colors.green,
            roseWater: Colors.pink,
            flamingo: Colors.pinkAccent,
            pink: Colors.pink,
            mauve: Colors.purple,
            maroon: Colors.brown,
            peach: Colors.orange,
            yellow: Colors.yellow,
            teal: Colors.teal,
            sapphire: Colors.blue,
            sky: Colors.lightBlue,
            blue: Colors.blue,
            lavender: Colors.purpleAccent,
            red: Colors.red,
          ),
        ],
      ),
      home: Scaffold(body: body),
    ),
  );
} 