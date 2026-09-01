import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';

class InfoErrorWidget extends StatelessWidget {
  final String message;
  final double height;
  final IconData icon;

  const InfoErrorWidget({
    required this.message,
    required this.height,
    required this.icon,
    super.key,
  });

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
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          Icon(icon, color: AppThemes.whitePremium, size: 40),
        ],
      ),
    );
  }
}
