import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/translation/domain/flutter_tts_helper.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';
import 'package:space_anywhere/features/translation/domain/translation_service.dart';

class const TranslatedObjects({
  required final TranslationService translationService,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.separated(
        separatorBuilder: (context, index) =>
          const Padding(padding: .symmetric(vertical: 8)),
        itemCount: translationService.objectsLength,
        itemBuilder: (context, index) {
          return GlassContainer(
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
          );
        },
      ),
    );
  }
}