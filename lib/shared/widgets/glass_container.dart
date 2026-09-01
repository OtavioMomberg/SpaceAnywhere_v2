import 'package:material_ui/material_ui.dart';
import 'dart:ui';
import 'package:space_anywhere/core/themes/app_themes.dart';

class GlassContainer extends StatelessWidget {
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? backgroundColor;
  final Widget? child;
  final double? height;

  const GlassContainer({
    this.borderRadius,
    this.borderColor,
    this.backgroundColor,
    this.child,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: borderRadius == null
          ? AppThemes.borderRadius
          : borderRadius!,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Container(
            height: height,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: borderRadius == null
                  ? AppThemes.borderRadius
                  : borderRadius!,
              border: Border.all(
                color: borderColor == null
                  ? AppThemes.whitePremium.withValues(alpha: 0.5)
                  : borderColor!.withValues(alpha: 0.5),
              ),
              color: borderColor == null
                  ? AppThemes.whitePremium.withValues(alpha: 0.15)
                  : borderColor!.withValues(alpha: 0.15),
            ),
            child: height != null ? Center(child: child) : child,
          ),
        ),
      ),
    );
  }
}
