import 'package:material_ui/material_ui.dart';
import 'package:custom_feedback/custom_feedback.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

mixin GlassSnackBarHelper {
  void showGlassSnackBar({
    required BuildContext context,
    required String msm,
    required Color backgroundColor,
    Duration duration = const Duration(milliseconds: 1500),
  }) {
    CustomFeedback.responseSnackbar(
      context: context,
      content: msm,
      backgroundColor: backgroundColor.withValues(alpha: 0.15),
      txtColor: AppThemes.white,
      shape: RoundedRectangleBorder(
        borderRadius: AppThemes.borderRadius,
        side: BorderSide(color: backgroundColor.withValues(alpha: 0.5)),
      ),
      duration: duration
    );
  }
}
