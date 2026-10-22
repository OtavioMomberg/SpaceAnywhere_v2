import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';

typedef OnTap = Future<void> Function({required int index});

class const AnswerCard({
  required final int index,
  required final String option,
  required final OnTap onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: AppThemes.borderRadius,
      color: AppThemes.whitePremium.withValues(alpha: 0.01),
      child: InkWell(
        onTap: () async => await onTap(index: index),
        borderRadius: AppThemes.borderRadius,
        child: GlassContainer(
          borderRadius: AppThemes.borderRadius,
          child: Padding(
            padding: const .symmetric(horizontal: 8, vertical: 6),
            child: Text(
              option,
              textAlign: .start,
              softWrap: true,
              style: TextStyle(color: AppThemes.whitePremium),
            ),
          ),
        ),
      ),
    );
  }
}