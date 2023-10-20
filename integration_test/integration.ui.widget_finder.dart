import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/utils/widget_finder.dart';

void registerWidgetFinderTests() {
  group('Find textFields on screen -', () {
    testWidgets(
        'When we we have a Material app with 3 TextField widgets, getAllTextFieldsOnScreen should return 3 text fields',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: Column(
          children: [
            TextField(),
            TextField(),
            TextField(),
          ],
        )),
      ));
      await tester.pumpAndSettle();

      final widgetFinder = WidgetFinder();

      final result = widgetFinder.getAllTextFieldsOnScreen();

      expect(result.length, 3);
    });
  });
}
