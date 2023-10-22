import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/utils/widget_finder.dart';

void registerWidgetFinderTests() {
  group('Find textFields on screen -', () {
    testWidgets(
        'When we we have a Material app with 3 TextField widgets, getAllTextFieldsOnScreen should return 3 information records',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: Column(
          children: [
            TextField(controller: TextEditingController()),
            TextField(controller: TextEditingController()),
            TextField(controller: TextEditingController()),
          ],
        )),
      ));
      await tester.pumpAndSettle();

      final widgetFinder = WidgetFinder();

      final result = widgetFinder.getAllTextFieldsOnScreen();

      expect(result.length, 3);
    });

    testWidgets(
        'When we we have an app with 2 TextFormField widgets, getAllTextFieldsOnScreen should return 2 information records',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: TextEditingController(),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: TextEditingController(),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: print,
                ),
              ],
            ),
          )),
        ),
      ));
      await tester.pumpAndSettle();

      final widgetFinder = WidgetFinder();

      final result = widgetFinder.getAllTextFieldsOnScreen();

      expect(result.length, 2);
    });
  });
}
