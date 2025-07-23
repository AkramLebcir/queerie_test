import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/features/movie/pages/widgets/movie_search_bar.dart';
import '../../../../helpers/root_widget.dart';

void main() {
  group('MovieSearchBar', () {
    late TextEditingController controller;
    late VoidCallback onFilter;
    late VoidCallback onClear;
    late VoidCallback onSearch;
    late ValueChanged<String> onSubmitted;

    setUp(() {
      controller = TextEditingController();
      onFilter = () {};
      onClear = () {};
      onSearch = () {};
      onSubmitted = (value) {};
    });

    tearDown(() {
      controller.dispose();
    });

    Widget createWidget({bool hasText = false}) {
      return rootWidget(
        MovieSearchBar(
          controller: controller,
          hasText: hasText,
          onFilter: onFilter,
          onClear: onClear,
          onSearch: onSearch,
          onSubmitted: onSubmitted,
        ),
      );
    }

    testWidgets('shows filter button always', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());
      
      expect(find.byIcon(Icons.filter_list), findsOneWidget);
    });

    testWidgets('shows clear and search buttons when hasText is true', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(hasText: true));
      
      expect(find.byIcon(Icons.clear), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('shows clear and search buttons when focused', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());
      
      // Initially buttons should not be visible
      expect(find.byIcon(Icons.clear), findsNothing);
      expect(find.byIcon(Icons.search), findsNothing);
      
      // Focus the text field
      await tester.tap(find.byType(TextField));
      await tester.pump();
      
      // Buttons should now be visible
      expect(find.byIcon(Icons.clear), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('shows clear and search buttons when focused', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget());
      
      // Initially buttons should not be visible
      expect(find.byIcon(Icons.clear), findsNothing);
      expect(find.byIcon(Icons.search), findsNothing);
      
      // Focus the text field
      await tester.tap(find.byType(TextField));
      await tester.pump();
      
      // Buttons should now be visible
      expect(find.byIcon(Icons.clear), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('keeps buttons visible when hasText is true even when unfocused', (WidgetTester tester) async {
      await tester.pumpWidget(createWidget(hasText: true));
      
      // Buttons should be visible initially
      expect(find.byIcon(Icons.clear), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      
      // Tap outside to unfocus
      await tester.tapAt(const Offset(0, 0));
      await tester.pump();
      
      // Buttons should still be visible because hasText is true
      expect(find.byIcon(Icons.clear), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('calls onClear when clear button is tapped', (WidgetTester tester) async {
      bool clearCalled = false;
      onClear = () => clearCalled = true;
      
      await tester.pumpWidget(createWidget(hasText: true));
      
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();
      
      expect(clearCalled, isTrue);
    });

    testWidgets('calls onSearch when search button is tapped', (WidgetTester tester) async {
      bool searchCalled = false;
      onSearch = () => searchCalled = true;
      
      await tester.pumpWidget(createWidget(hasText: true));
      
      await tester.tap(find.byIcon(Icons.search));
      await tester.pump();
      
      expect(searchCalled, isTrue);
    });

    testWidgets('calls onFilter when filter button is tapped', (WidgetTester tester) async {
      bool filterCalled = false;
      onFilter = () => filterCalled = true;
      
      await tester.pumpWidget(createWidget());
      
      await tester.tap(find.byIcon(Icons.filter_list));
      await tester.pump();
      
      expect(filterCalled, isTrue);
    });

    testWidgets('calls onSubmitted when search is submitted', (WidgetTester tester) async {
      String? submittedValue;
      onSubmitted = (value) => submittedValue = value;
      
      await tester.pumpWidget(createWidget());
      
      await tester.enterText(find.byType(TextField), 'test search');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();
      
      expect(submittedValue, equals('test search'));
    });
  });
} 