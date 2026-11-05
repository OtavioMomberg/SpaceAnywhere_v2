import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

class const InputNumber({
  required final TextEditingController controller,
  required final String label,
  required final bool isPlanetSelected,
  required final VoidCallback onFieldSubmitted,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: .number,
      controller: controller,
      cursorColor: AppThemes.whitePremium,
      style: TextStyle(color: AppThemes.whitePremium.withValues(alpha: 0.8)),
      onFieldSubmitted: (_) {
        if (!isPlanetSelected) { return; }
        onFieldSubmitted();
      },
      decoration: InputDecoration(
        hint: Text(
          label,
          style: TextStyle(
            color: AppThemes.whitePremium.withValues(alpha: 0.8),
          ),
        ),
        border: AppThemes.outlineInputBorder,
        enabledBorder: AppThemes.outlineInputBorder,
        focusedBorder: AppThemes.outlineInputBorder,
      ),
    );
  }
}