import 'package:material_ui/material_ui.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:space_anywhere/core/constants/app_images.dart';
import 'package:space_anywhere/core/routes/app_routes.dart';
import 'package:space_anywhere/features/entry_points/drawer_screen.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/image_widget.dart';

class const SplashScreen({super.key}) extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isImageVisible = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() => isImageVisible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      body: Container(
        width: .infinity,
        height: .infinity,
        padding: const .symmetric(vertical: 10, horizontal: 20),
        decoration: const BoxDecoration(gradient: AppThemes.mainGradient),
        child: Column(
          spacing: 10,
          mainAxisAlignment: .center,
          children: <Widget>[
            if (isImageVisible) ...[
              AnimatedOpacity(
                opacity: isImageVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  width: .infinity,
                  child: DefaultTextStyle(
                    style: const TextStyle(fontSize: 32.0, fontWeight: .bold),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          "SpaceAnywhere",
                          speed: const Duration(milliseconds: 200),
                          textAlign: .center,
                        ),
                      ],
                      isRepeatingAnimation: false,
                      onFinished: () {
                        Navigator.pushReplacement(
                          context,
                          AppRoutes.getRoute(
                            screen: const DrawerScreen(),
                            type: .scale,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
            AnimatedScale(
              scale: isImageVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Material(
                borderRadius: AppThemes.borderRadius,
                elevation: 10,
                shadowColor: AppThemes.blue2,
                child: SizedBox.square(
                  dimension: 250,
                  child: ImageWidget(
                    imagePath: AppImages.logo,
                    option: .asset,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
