import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/comparison/ui/comparison_screen.dart';
import 'package:space_anywhere/features/calculator/ui/calculator_screen.dart';
import 'package:space_anywhere/features/curiosity/ui/curiosity_screen.dart';
import 'package:space_anywhere/features/quiz/ui/screens/quiz_screen.dart';
import 'package:space_anywhere/features/translation/ui/screens/translation_screen.dart';
import 'package:space_anywhere/features/wallpaper/screens/wallpaper_screen.dart';

enum TransitionType { slideLtoR, slideRtoL, fade, scale }

Widget _getTranslation({
  required Animation<double> animation,
  required Widget child,
  required TransitionType type,
}) {
  switch (type) {
    case .slideLtoR:
      const begin = Offset(-1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      final tween = Tween(
        begin: begin,
        end: end,
      ).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);

    case .slideRtoL:
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      final tween = Tween(
        begin: begin,
        end: end,
      ).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);

    case .fade:
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: child,
      );

    case .scale:
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: child,
      );
  }
}

final class AppRoutes._() {
  static const pages = [
    CuriosityScreen(),
    QuizScreen(),
    ComparisonScreen(),
    WallpaperScreen(),
    CalculatorScreen(),
    TranslationScreen(),
  ];

  static const pageNames = [
    "Início",
    "Quiz",
    "Metrícas",
    "Wallpaper",
    "Calculadora",
    "Idiomas",
  ];

  static Route<dynamic> getRoute({
    required Widget screen,
    required TransitionType type,
  }) {
    return PageRouteBuilder(
      pageBuilder: (_, _, _) => screen,
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, _, child) {
        return _getTranslation(
          animation: animation, 
          child: child, 
          type: type
        );
      },
    );
  }
}
