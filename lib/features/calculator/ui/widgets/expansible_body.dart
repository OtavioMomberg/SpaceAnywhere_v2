import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/calculator/domain/calculator_service.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

class const ExpansibleBody({
  required final ExpansibleController controller,
  required final CalculatorService _calculatorService,
  required final VoidCallback setState,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const .only(top: 10),
      height: 250,
      decoration: BoxDecoration(
        borderRadius: AppThemes.borderRadius,
        border: .all(
          color: AppThemes.whitePremium.withValues(alpha: 0.5),
        ),
      ),
      child: ListView.builder(
        itemCount: _calculatorService.planetsGravity.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              _calculatorService.changeObjectName(index: index);
              setState();
              controller.collapse();
            },
            title: Center(
              child: Text(
                _calculatorService.planetsGravity[index].name,
                style: const TextStyle(color: AppThemes.whitePremium),
              ),
            )
          );
        }
      )
    );
  }
}