import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queerie_test/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:queerie_test/dependencies_injection.dart';
import 'package:queerie_test/features/features.dart';

import '../../../../helpers/fake_path_provider_platform.dart';
import '../../../../helpers/root_widget.dart';
import 'package:queerie_test/features/general/pages/pages.dart';

class MockMainCubit extends MockCubit<MainState> implements MainCubit {}
class FakeBuildContext extends Fake implements BuildContext {}
class FakeScaffoldKey extends Fake implements GlobalKey<ScaffoldState> {}

void main() {
  late MainCubit mainCubit;

  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
    registerFallbackValue(FakeScaffoldKey());
    HttpOverrides.global = null;
  });

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    PathProviderPlatform.instance = FakePathProvider();
    await serviceLocator(isUnitTest: true, prefixBox: 'main_page_test_');
    mainCubit = MockMainCubit();
  });

  Widget rootWidgetWithCubit(Widget body) {
    return BlocProvider<MainCubit>.value(
      value: mainCubit,
      child: rootWidget(body),
    );
  }

  testWidgets(
    'MainPage renders its child',
    (tester) async {
      when(() => mainCubit.state).thenReturn(const MainState.loading());
      when(() => mainCubit.onBackPressed(any(), any())).thenAnswer((_) => true);
      when(() => mainCubit.dataMenus).thenReturn([
        DataHelper(title: 'Dashboard', isSelected: true),
        DataHelper(title: 'Settings', isSelected: false),
      ]);
      await tester.pumpWidget(rootWidgetWithCubit(const MainPage(child: Text('MainPageChild'))));
      expect(find.text('MainPageChild'), findsOneWidget);
    },
  );
} 