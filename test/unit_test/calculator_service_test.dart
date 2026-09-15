import 'package:flutter_test/flutter_test.dart';
import 'package:space_anywhere/features/calculator/domain/calculator_service.dart';

void main() {
  group("Before calculate the weight", () {
    late CalculatorService service;

    setUp(() => service = CalculatorService());

    test("result should start at 0", () {
      expect(service.result, 0);
    });

    test("text should start = 'Escolha um objeto'", () {
      expect(service.text, "Escolha um objeto");
    });

    test("defineNewText({required int index}) - success", () {
      final index = 1;
      service.defineNewText(index: index);

      expect(service.text, "Venûs");
    });

    test("defineNewText({required int index}) - should throw a range error", () {
      expect(() => service.defineNewText(index: 20), throwsRangeError);
    });

    test("setDefaultText() - should set the text value to the default", () {
      service.defineNewText(index: 1);
      service.setDefaultText();

      expect(service.text, "Escolha um objeto");
    });

    test("initializeResult() - should reset the result", () {
      service.defineNewText(index: 1);
      service.calculate(weight: "70");
      service.initializeResult();

      expect(service.result, 0);
    });

    test("checkFields({required String newText}) - success", () {
      final index = 1;
      service.defineNewText(index: index);

      expect(service.checkFields(newText: "70"), isTrue);
    });

    test("checkFields({required String newText}) - text = defaultOptionText should return false", () {
      expect(service.checkFields(newText: "70"), isFalse);
    });
  });

  group("Calculate method", () {
    late CalculatorService service;

    setUp(() => service = CalculatorService());

    test("calculate({required String weight}) - success", () {
      final index = 1;
      service.defineNewText(index: index);
      service.calculate(weight: "70");

      final response = (70 * 100) * 0.9 / 100;
      
      expect(service.result, response);
    });

    test("calculate({required String weight}) - positive and negative 'weight' should return the same result", () {
      service.defineNewText(index: 1);

      service.calculate(weight: "70");
      final result1 = service.result;

      service.calculate(weight: "-70");
      final result2 = service.result;
      
      expect(result1, result2);
    });

    test("calculate({required String weight}) - should convert negative weight to positive", () {
      final index = 1;
      service.defineNewText(index: index);
      service.calculate(weight: "-70");
      
      expect(service.result, isNonNegative);
    });

    test("calculate({required String weight}) - should throw a format exception", () {
      final index = 1;
      service.defineNewText(index: index);
      
      expect(() => service.calculate(weight: "error"), throwsFormatException);
    });

    test("calculate({required String weight}) - should return null", () {
      final index = 1;
      service.defineNewText(index: index);
      service.calculate(weight: "error");

      expect(service.result, null);
    });
  });
}