import 'package:flutter/material.dart';
import 'package:queerie_test/core/core.dart';
import 'package:go_router/go_router.dart';


class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      context.goNamed(Routes.root.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      child: ColoredBox(
        color: Theme.of(context).extension<CustomColors>()!.background!,
        child: Center(
          child: Image.asset(Images.icLauncher, height: Dimens.space36),
        ),
      ),
    );
  }
}
