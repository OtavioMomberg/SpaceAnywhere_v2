import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';

class Header extends StatelessWidget {
  final Widget title;

  const new({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: <Widget>[
        Material(
          borderRadius: .circular(12),
          color: AppThemes.whitePremium.withValues(alpha: .1),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: .circular(12),
            child: GlassContainer(
              height: 40,
              width: 40,
              child: const Icon(
                Icons.arrow_back, 
                color: AppThemes.whitePremium, 
                size: 20
              )
            )
          )
        ),
        title
      ],
    );
  }
}
