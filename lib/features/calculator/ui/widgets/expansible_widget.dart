import 'package:material_ui/material_ui.dart';

class const ExpansibleWidget({
  required final Widget header,
  required final Widget body,
  required final ExpansibleController controller,
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expansible(
      controller: controller,
      headerBuilder: (context, _) => header,
      bodyBuilder: (context, _) => body
    );
  }
}