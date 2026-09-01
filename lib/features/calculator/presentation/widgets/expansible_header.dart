import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/calculator/domain/calculator_service.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

class ExpansibleHeader extends StatelessWidget {
  final ExpansibleController controller;
  final CalculatorService _calculatorService;

  const ExpansibleHeader({
    required this.controller,
    required CalculatorService calculatorService,
    super.key,
  }) : _calculatorService = calculatorService;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppThemes.borderRadius,
        border: Border.all(
          width: 1.5,
          color: AppThemes.whitePremium.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              _calculatorService.defaultText,
              style: TextStyle(
                color: AppThemes.whitePremium.withValues(alpha: 0.8),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              controller.isExpanded
                  ? controller.collapse()
                  : controller.expand();
            },
            icon: Icon(
              controller.isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
              color: AppThemes.whitePremium.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
