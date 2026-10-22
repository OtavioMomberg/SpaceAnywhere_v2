import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

class const GlassContainer({
  final BorderRadius? borderRadius,
  final Color? borderColor,
  final Color? backgroundColor,
  final double? height,
  final double? width,
  final Widget? child,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? .infinity,
      padding: const .all(10),
      decoration: BoxDecoration(
        borderRadius: borderRadius == null
          ? AppThemes.borderRadius
          : borderRadius!,
        border: .all(
          color: borderColor == null
          ? AppThemes.whitePremium.withValues(alpha: 0.5)
          : borderColor!.withValues(alpha: 0.5),
        ),
      ),
      child: height != null ? Center(child: child) : child,
    );
  }
}