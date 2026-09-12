import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

class InputNumber extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final void Function(String)? onFieldSubmitted;

  const new({
    required this.controller,
    required this.label,
    required this.onFieldSubmitted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      cursorColor: AppThemes.whitePremium,
      style: TextStyle(color: AppThemes.whitePremium.withValues(alpha: 0.8)),
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hint: Text(
          label,
          style: TextStyle(
            color: AppThemes.whitePremium.withValues(alpha: 0.8),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: AppThemes.borderRadius,
          borderSide: BorderSide(
            width: 1.5,
            color: AppThemes.whitePremium.withValues(alpha: 0.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppThemes.borderRadius,
          borderSide: BorderSide(
            width: 1.5,
            color: AppThemes.whitePremium.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppThemes.borderRadius,
          borderSide: BorderSide(
            width: 1.5,
            color: AppThemes.whitePremium.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}
