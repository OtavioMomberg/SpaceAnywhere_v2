import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';

class ResultScreen extends StatelessWidget {
  final bool isCorrect;
  final String? correctAnswer;

  const ResultScreen({required this.isCorrect, this.correctAnswer, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppThemes.blue3,
      body: SafeArea(
        top: false,
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          decoration: const BoxDecoration(gradient: AppThemes.mainGradient),
          child: GlassContainer(
            height: size.height * 0.6,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Icon(
                    isCorrect ? Icons.check_circle : Icons.cancel,
                    color: AppThemes.whitePremium,
                    size: 60,
                  ),
                  Text(
                    isCorrect ? "Certa Resposta!" : "Resposta Incorreta!",
                    style: const TextStyle(
                      color: AppThemes.whitePremium,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!isCorrect) ...[
                    const SizedBox(height: 10),
                    const Text(
                      "Alternativa correta:",
                      style: TextStyle(
                        color: AppThemes.whitePremium,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      correctAnswer!,
                      style: const TextStyle(
                        color: AppThemes.whitePremium,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
