import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

class MainHeader extends StatelessWidget {
  final Widget title;

  const new({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: const Icon(
            Icons.menu,
            color: AppThemes.whitePremium,
            size: 25,
          ),
        ),
        title
      ],
    );
  }
}
