import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/shared/widgets/button.dart';

void main() {
  group("Check Button widget", () {
    testWidgets("button label should be displayed", (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: Button(label: "Press!")),
        ),
      );
      final response = find.text("Press!");

      expect(response, findsOneWidget);
    });

    testWidgets("button function should works", (tester) async {
      bool checkFunction = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Button(label: "Press!", function: () => checkFunction = true),
          ),
        ),
      );
      await tester.tap(find.text("Press!"));

      expect(checkFunction, isTrue);
    });

    testWidgets("button async function should works", (tester) async {
      bool checkFunction = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Button(
              label: "Press!",
              asyncFunction: () async {
                await Future.delayed(const Duration(milliseconds: 200));
                checkFunction = true;
              },
            ),
          ),
        ),
      );
      await tester.tap(find.text("Press!"));

      expect(checkFunction, isFalse);

      await tester.pumpAndSettle();

      expect(checkFunction, isTrue);
    });

    testWidgets("async function runs when both functions are supplied", (
      tester,
    ) async {
      bool checkFunction = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Button(
              label: "Press!",
              asyncFunction: () async {
                await Future.delayed(const Duration(milliseconds: 200));
                checkFunction = true;
              },
              function: () => checkFunction = false,
            ),
          ),
        ),
      );
      await tester.tap(find.text("Press!"));
      await tester.pumpAndSettle();

      expect(checkFunction, isTrue);
    });
  });
}
