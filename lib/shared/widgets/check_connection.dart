import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';
import 'package:space_anywhere/shared/widgets/info_error_widget.dart';

class const CheckConnection({
  required final bool isLoading,
  required final bool checkInternet,
  required final bool checkAPI,
  required final double height,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return GlassContainer(
        height: height,
        child: Column(
          spacing: 10,
          mainAxisAlignment: .center,
          children: <Widget>[
            const Text(
              "Carregando...",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppThemes.whitePremium,
              ),
            ),
            const CircularProgressIndicator.adaptive(
              backgroundColor: AppThemes.whitePremium,
            ),
          ],
        ),
      );
    }
    if (!checkInternet) {
      return InfoErrorWidget(
        message: "Erro. Sem conexão com a internet",
        icon: Icons.wifi_off,
        height: height,
      );
    }
    if (!checkAPI) {
      return InfoErrorWidget(
        message: "Erro. Não foi possível se conectar ao servidor",
        icon: Icons.dns,
        height: height,
      );
    }
    return const SizedBox.shrink();
  }
}