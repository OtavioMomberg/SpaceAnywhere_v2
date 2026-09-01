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
    CustomFeedback.snackBar(
      context: context,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
      backgroundColor: backgroundColor.withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(
        borderRadius: AppThemes.borderRadius,
        side: BorderSide(color: backgroundColor.withValues(alpha: 0.5)),
      ),
      behavior: SnackBarBehavior.floating,
      content: Center(
        child: Text(msm, style: const TextStyle(color: AppThemes.white)),
      ),
      duration: duration,
    );
  }
}
