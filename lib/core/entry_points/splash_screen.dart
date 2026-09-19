import 'package:material_ui/material_ui.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:space_anywhere/core/routes/app_routes.dart';
import 'package:space_anywhere/core/entry_points/drawer_screen.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

class SplashScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      body: Container(
        width: .infinity,
        height: .infinity,
        padding: const .all(10),
        alignment: .center,
        decoration: const BoxDecoration(gradient: AppThemes.mainGradient),
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 32.0, fontWeight: .bold),
          child: AnimatedTextKit(
            animatedTexts: [
              FadeAnimatedText(
                "Space Anywhere\n",
                textStyle: const TextStyle(fontFamily: "Electrolize"),
              ),
              FadeAnimatedText(
                "Bem Vindo(a)\n",
                duration: const Duration(milliseconds: 1500),
                textStyle: const TextStyle(fontFamily: "Electrolize"),
              ),
            ],
            isRepeatingAnimation: false,
            onFinished: () {
              Navigator.pushReplacement(
                context,
                AppRoutes.getRoute(page: const DrawerPage(), type: .scale),
              );
            },
          ),
        ),
      ),
    );
  }
}
