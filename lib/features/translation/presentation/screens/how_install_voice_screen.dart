import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/features/translation/presentation/widgets/stars.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';
import 'package:space_anywhere/features/translation/domain/translation_service.dart';

class HowInstallVoiceScreen extends StatelessWidget {
  const HowInstallVoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppThemes.blue3,
      body: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          decoration: const BoxDecoration(gradient: AppThemes.mainGradient),
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              crossAxisAlignment: .start,
              children: <Widget>[
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Como Instalar a Voz",
                    style: TextStyle(
                      color: AppThemes.whitePremium,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Stars(differentSizes: true, differentSpacing: true),

                ...List.generate(
                  TranslationService.stepsToInstallVoice.length,
                  (index) {
                    return GlassContainer(
                      child: Text(
                        TranslationService.stepsToInstallVoice[index],
                        style: const TextStyle(
                          color: AppThemes.whitePremium,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),

                const Stars(differentPaddings: true),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
