import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

class Button extends StatelessWidget {
  final String label;
  final double? height;
  final VoidCallback? function;
  final Future<void> Function()? awaitFunction;

  const new({
    required this.label,
    this.height = 60,
    this.function,
    this.awaitFunction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: AppThemes.borderRadius,
      color: Colors.transparent,
      shadowColor: AppThemes.whitePremium.withValues(alpha: 0.1),
      elevation: 5,
      child: InkWell(
        borderRadius: AppThemes.borderRadius,
        onTap: () async {
          if (awaitFunction != null) {
            await awaitFunction!();
            return;
          }
          if (function != null) { function!(); }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppThemes.borderRadius,
            border: Border.all(
              color: AppThemes.whitePremium.withValues(alpha: 0.5),
            ),
          ),
          height: height,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: AppThemes.whitePremium.withValues(alpha: 0.8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
