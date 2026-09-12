import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/translation/domain/flutter_tts_helper.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';
import 'package:space_anywhere/features/translation/domain/translation_service.dart';

class TranslatedObjects extends StatelessWidget {
  final TranslationService translationService;

  const TranslatedObjects({
    required this.translationService,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: translationService.objectsLength,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: GlassContainer(
              height: 80,
              child: Row(
                spacing: 20,
                mainAxisAlignment: .center,
                children: <Widget>[
                  Text(
                    translationService
                      .translationController
                      .translationModel[index]!
                      .translation,
                    style: const TextStyle(color: AppThemes.whitePremium),
                  ),
                  IconButton(
                    onPressed: () async {
                      final response = translationService
                        .translationController
                        .translationModel[index]!
                        .translation;

                      await FlutterTtsHelper.play(translation: response);
                    },
                    icon: const Icon(
                      Icons.volume_up,
                      color: AppThemes.whitePremium,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
