import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';
import 'package:space_anywhere/features/translation/domain/translation_service.dart';
import 'package:space_anywhere/shared/widgets/header.dart';

class const HowInstallVoiceScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppThemes.blue3,
      body: SafeArea(
        top: false,
        child: Container(
          padding: AppThemes.padding,
          decoration: const BoxDecoration(gradient: AppThemes.mainGradient),
          child: Column(
            crossAxisAlignment: .start,
            children: <Widget>[
              const Header(
                title: Text(
                  "Como Instalar a Voz",
                  style: TextStyle(
                    color: AppThemes.whitePremium,
                    fontWeight: .bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              ....generate(
                TranslationService.stepsToInstallVoice.length,
                (index) {
                  return Padding(
                    padding: const .symmetric(vertical: 5),
                    child: GlassContainer(
                      child: Text(
                        TranslationService.stepsToInstallVoice[index],
                        style: const TextStyle(
                          color: AppThemes.whitePremium,
                          fontWeight: .bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}