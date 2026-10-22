import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';

class const InfoErrorWidget({
  required final String message,
  required final double height,
  required final IconData icon,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: height,
      child: Column(
        mainAxisAlignment: .center,
        children: <Widget>[
          Text(
            message,
            style: const TextStyle(
              color: AppThemes.whitePremium,
              fontWeight: .bold,
              fontSize: 16,
            ),
            maxLines: 2,
            textAlign: .center,
          ),
          Icon(icon, color: AppThemes.whitePremium, size: 40),
        ],
      ),
    );
  }
}