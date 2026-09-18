import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/calculator/presentation/widgets/input_number.dart';

void main() {
    testWidgets("verify is onFieldSubmitted is working", (tester) async {
      final controller = TextEditingController();
      bool simulateSetState = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InputNumber(
              controller: controller, 
              label: "Enter a number:", 
              onFieldSubmitted: (_) => simulateSetState = true
            )
          ),
        ),
      );

      await tester.showKeyboard(find.byType(TextFormField));

      await tester.enterText(find.byType(TextFormField), "70");

      await tester.testTextInput.receiveAction(TextInputAction.done);

      await tester.pumpAndSettle();

      expect(controller.text, "70");
      expect(simulateSetState, isTrue);
    });
}