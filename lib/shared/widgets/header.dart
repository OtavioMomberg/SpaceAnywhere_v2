import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/shared/widgets/icon_button_outlined.dart';

class const Header({
  required final Widget title, 
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: <Widget>[
        IconButtonOutlined(
          function: (_) => Navigator.pop(context), 
          icon: Icons.arrow_back,
          height: 40,
          width: 40,
        ),
        title
      ],
    );
  }
}