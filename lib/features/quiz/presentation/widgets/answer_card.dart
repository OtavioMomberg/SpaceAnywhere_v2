import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';

class AnswerCard extends StatelessWidget {
  final int index;
  final String option;
  final Color color;
  final Future<void> Function({required int index}) onTap;

  const new({
    required this.index,
    required this.option,
    required this.color,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: AppThemes.borderRadius,
      color: AppThemes.whitePremium.withValues(alpha: 0.01),
      child: InkWell(
        onTap: () => onTap(index: index),
        borderRadius: AppThemes.borderRadius,
        child: GlassContainer(
          borderRadius: AppThemes.borderRadius,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(
              option,
              textAlign: TextAlign.start,
              softWrap: true,
              style: TextStyle(color: AppThemes.whitePremium),
            ),
          ),
        ),
      ),
    );
  }
}
