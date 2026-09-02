import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:space_anywhere/presentation/splash_screen.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString("assets/fonts/OFL.txt");
    yield LicenseEntryWithLineBreaks(<String>["Google Fonts - Electrolize"], license);
  });

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SpaceAnywhere",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: AppThemes.whitePremium,
        ),
        colorScheme: .fromSeed(seedColor: AppThemes.blue2),
        fontFamily: "Electrolize",
      ),
      home: const SplashScreen()
    );
  }
}