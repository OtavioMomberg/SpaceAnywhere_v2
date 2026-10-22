import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/calculator/domain/calculator_service.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';

class const CalculusResult({
  required final CalculatorService _calculatorService, 
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: <Widget>[
        const Text(
          "Resultado:",
          style: TextStyle(
            color: AppThemes.whitePremium,
            fontWeight: .bold,
            fontSize: 16,
          ),
        ),
        GlassContainer(
          height: 200,
          child: Center(
            child: Text(
              _calculatorService.result == null
                ? "Erro ao realizar cálculo."
                : "O seu peso em ${_calculatorService.objectName}\n"
                  "é: ${_calculatorService.result!.toStringAsFixed(2)} kg",
              style: const TextStyle(
                color: AppThemes.whitePremium,
                fontWeight: .bold,
                fontSize: 16,
              ),
              textAlign: .center,
            ),
          ),
        ),
      ],
    );
  }
}