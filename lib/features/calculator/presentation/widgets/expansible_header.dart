import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/calculator/domain/calculator_service.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';

class ExpansibleHeader extends StatefulWidget {
  final ExpansibleController controller;
  final CalculatorService _calculatorService;

  const new({
    required this.controller,
    required this._calculatorService,
    super.key,
  });

  @override
  State<ExpansibleHeader> createState() => _ExpansibleHeaderState();
}

class _ExpansibleHeaderState extends State<ExpansibleHeader> {
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: <Widget>[
          Padding(
            padding: const .only(left: 10),
            child: Text(
              widget._calculatorService.objectName,
              style: TextStyle(
                color: AppThemes.whitePremium.withValues(alpha: 0.8),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              widget.controller.isExpanded 
                ? widget.controller.collapse()
                : widget.controller.expand();
              setState(() {});
            },
            icon: Icon(
              widget.controller.isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
              color: AppThemes.whitePremium.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
