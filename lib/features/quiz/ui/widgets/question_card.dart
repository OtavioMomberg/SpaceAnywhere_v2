import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';

class const QuestionCard({
  required final String question, 
  required final Color color, 
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: AppThemes.borderRadius,
      child: Center(
        child: Text(
          question,
          style: const TextStyle(color: AppThemes.whitePremium),
          textAlign: .justify,
        ),
      ),
    );
  }
}