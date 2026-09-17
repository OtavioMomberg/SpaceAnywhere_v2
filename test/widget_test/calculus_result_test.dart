import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/calculator/domain/calculator_service.dart';
import 'package:space_anywhere/features/calculator/presentation/widgets/calculus_result.dart';

void main() {
  group("Check CalculusResult widget", () {
    late CalculatorService service;

    setUp(() => service = CalculatorService());

    testWidgets("verify positive result state", (tester) async {
      service.changeObjectName(index: 1);
      service.calculate(weight: "70");

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalculusResult(calculatorService: service)
          ),
        ),
      );

      expect(find.text("Erro ao realizar cálculo."), findsNothing);
      expect(find.text("O seu peso em Vênus\né: 63.00 kg"), findsOneWidget);
    });

    testWidgets("invalid result should display 'Erro ao realizar cálculo.'", (tester) async {
      service.changeObjectName(index: 1);
      service.calculate(weight: "Error");

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalculusResult(calculatorService: service)
          ),
        ),
      );

      expect(find.text("Erro ao realizar cálculo."), findsOneWidget);
      expect(find.text("O seu peso em Vênus\né: 63.00 kg"), findsNothing);
    });
  });
}
