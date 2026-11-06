import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';

class const IconButtonOutlined<T>({
  required final void Function(T?) function,
  required final IconData icon,
  final T? param,
  final double height = 40,
  final double width = 40,
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: AppThemes.borderRadius,
      color: AppThemes.whitePremium.withValues(alpha: .01),
      child: InkWell(
        onTap: () => function(param),
        borderRadius: AppThemes.borderRadius,
        child: GlassContainer(
          height: height,
          width: width,
          child: Icon(
            icon,
            color: AppThemes.whitePremium,
            size: 20,
          ),
        ),
      ),
    );
  }
}
