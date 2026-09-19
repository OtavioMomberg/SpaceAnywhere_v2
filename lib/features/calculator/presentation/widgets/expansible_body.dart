import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/calculator/domain/calculator_service.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

class ExpansibleBody extends StatefulWidget {
  final ExpansibleController controller;
  final CalculatorService _calculatorService;

  const new({
    required this.controller,
    required this._calculatorService,
    super.key,
  });

  @override
  State<ExpansibleBody> createState() => _ExpansibleBodyState();
}

class _ExpansibleBodyState extends State<ExpansibleBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const .only(top: 10),
      height: 250,
      decoration: BoxDecoration(
        borderRadius: AppThemes.borderRadius,
        border: Border.all(
          color: AppThemes.whitePremium.withValues(alpha: 0.5),
        ),
      ),
      child: ListView.builder(
        itemCount: widget._calculatorService.planetsGravity.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              widget._calculatorService.changeObjectName(index: index);
              setState(() {});
              widget.controller.collapse();
            },
            title: Center(
              child: Text(
                widget._calculatorService.planetsGravity[index].name,
                style: const TextStyle(color: AppThemes.whitePremium),
              ),
            )
          );
        }
      )
    );
  }
}
