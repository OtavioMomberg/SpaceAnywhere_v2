import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final Color color;

  const new({
    required this.question, 
    required this.color, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: AppThemes.borderRadius,
      child: Center(
        child: Text(
          question,
          style: const TextStyle(color: AppThemes.whitePremium),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
