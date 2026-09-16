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
      expect(service.objectName, "Escolha um objeto");
    });

    test("defineNewText({required int index}) - success", () {
      service.changeObjectName(index: 1);

      expect(service.objectName, "Vênus");
    });

    test(
      "defineNewText({required int index}) - should throw a range error",
      () {
        expect(() => service.changeObjectName(index: 20), throwsRangeError);
      },
    );

    test("setDefaultText() - should set the text value to the default", () {
      service.changeObjectName(index: 1);
      service.setDefaultText();

      expect(service.objectName, "Escolha um objeto");
    });

    test("initializeResult() - should reset the result", () {
      service.changeObjectName(index: 1);
      service.calculate(weight: "70");
      service.initializeResult();

      expect(service.result, 0);
    });

    test("checkFields({required String newText}) - success", () {
      service.changeObjectName(index: 1);

      expect(service.checkFields(weight: "70"), isTrue);
    });

    test("checkFields({required String newText}) - objectName = defaultOptionText should return false", () {
      expect(service.checkFields(weight: "70"), isFalse);
    });
  });

  group("Calculate method", () {
    late CalculatorService service;

    setUp(() => service = CalculatorService());

    test("calculate({required String weight}) - success", () {
      service.changeObjectName(index: 1);
      service.calculate(weight: "70");

      final response = (70 * 100) * 0.9 / 100;

      expect(service.result, response);
    });

    test("calculate({required String weight}) - should convert negative weight to positive", () {
      final index = 1;
      service.changeObjectName(index: index);
      service.calculate(weight: "-70");

      expect(service.result, isNonNegative);
    });

    test("calculate({required String weight}) - non number values should return null", () {
      service.changeObjectName(index: 1);
      service.calculate(weight: "error");

      expect(service.result, isNull);
    });

    test("calculate({required String weight}) - empty weight should return null", () {
      service.changeObjectName(index: 1);
      service.calculate(weight: "");

      expect(service.result, isNull);
    });

    test("calculate({required String weight}) - weight = '0' or '.' or ',' should return null", () {
      service.changeObjectName(index: 1);

      service.calculate(weight: "0");
      expect(service.result, isNull);

      service.calculate(weight: ".");
      expect(service.result, isNull);

      service.calculate(weight: ",");
      expect(service.result, isNull);
    });
  });
}
