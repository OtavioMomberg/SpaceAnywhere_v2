import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/calculator/domain/calculator_service.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

class ExpansibleBody extends StatelessWidget {
  final ExpansibleController controller;
  final CalculatorService _calculatorService;
  final VoidCallback setStateCallback;

  const ExpansibleBody({
    required this.controller,
    required CalculatorService calculatorService,
    required this.setStateCallback,
    super.key,
  }) : _calculatorService = calculatorService;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 250,
      decoration: BoxDecoration(
        borderRadius: AppThemes.borderRadius,
        border: Border.all(
          width: 1.5,
          color: AppThemes.whitePremium.withValues(alpha: 0.5),
        ),
      ),
      child: ListView.builder(
        itemCount: _calculatorService.planetsGravity.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              _calculatorService.defineNewText(index: index);
              setStateCallback();
              controller.collapse();
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  _calculatorService.planetsGravity[index].name,
                  style: const TextStyle(color: AppThemes.whitePremium),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
