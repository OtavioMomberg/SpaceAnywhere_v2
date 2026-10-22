import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';

class const Button({
  required final String label,
  final double? height = 60,
  final VoidCallback? function,
  final Future<void> Function()? asyncFunction,
  super.key,
  }) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: AppThemes.borderRadius,
      color: Colors.transparent,
      shadowColor: AppThemes.whitePremium.withValues(alpha: 0.05),
      elevation: 5,
      child: InkWell(
        borderRadius: AppThemes.borderRadius,
        onTap: () async {
          if (asyncFunction != null) {
            await asyncFunction!();
            return;
          }
          if (function != null) { function!(); }
        },
        child: GlassContainer(
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
