import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/comparison/presentation/screens/comparison_screen.dart';
import 'package:space_anywhere/features/calculator/presentation/screens/calculator_screen.dart';
import 'package:space_anywhere/features/curiosity/screens/curiosity_screen.dart';
import 'package:space_anywhere/features/quiz/presentation/screens/quiz_screen.dart';
import 'package:space_anywhere/features/translation/presentation/screens/translation_screen.dart';
import 'package:space_anywhere/features/wallpaper/screens/wallpaper_screen.dart';

enum TransitionType { slideLtoR, slideRtoL, fade, scale }

final map = {
  TransitionType.slideLtoR: ({required Animation<double> animation, required Widget child}) {
    const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(position: animation.drive(tween), child: child);
  },
  TransitionType.slideRtoL: ({required Animation<double> animation, required Widget child}) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(position: animation.drive(tween), child: child);
  },
  TransitionType.fade:({required Animation<double> animation, required Widget child}) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      child: child,
    );
  },
  TransitionType.scale: ({required Animation<double> animation, required Widget child}) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      child: child,
    );
  }
};

class AppRoutes {
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
    required Widget page,
    required TransitionType type,
  }) {
    return PageRouteBuilder(
      pageBuilder: (_, _, _) => page,
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, _, child) {
        final transition = map[type];

        if (transition != null) {
          return transition(animation: animation, child: child);
        }
        return map[TransitionType.fade]!(
          animation: animation,
          child: child,
        );
      },
    );
  }
}
