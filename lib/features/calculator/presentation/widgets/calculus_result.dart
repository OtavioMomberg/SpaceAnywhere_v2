import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/calculator/domain/calculator_service.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

class CalculusResult extends StatelessWidget {
  final CalculatorService _calculatorService;

  const CalculusResult({
    required CalculatorService calculatorService,
    super.key,
  }) : _calculatorService = calculatorService;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: <Widget>[
        const Text(
          "Resultado:",
          style: TextStyle(
            color: AppThemes.whitePremium,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: AppThemes.borderRadius,
            border: Border.all(
              color: AppThemes.whitePremium.withValues(alpha: 0.5),
            ),
            color: AppThemes.whitePremium.withValues(alpha: 0.15),
          ),
          child: Center(
            child: Text(
              _calculatorService.result == null
                  ? "Erro ao realizar cálculo."
                  : "O seu peso em ${_calculatorService.defaultText}\né: ${_calculatorService.result!.toStringAsFixed(2)} kg",
              style: const TextStyle(
                color: AppThemes.whitePremium,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
