import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

class Header extends StatelessWidget {
  final Widget title;

  const new({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            color: AppThemes.whitePremium,
            size: 35,
          ),
        ),
        title
      ],
    );
  }
}
