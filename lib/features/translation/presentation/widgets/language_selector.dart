import 'package:custom_feedback/custom_feedback.dart';
import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/constants/app_constants.dart';
import 'package:space_anywhere/features/translation/domain/translation_cache_helper.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

class LanguageSelector extends StatefulWidget {
  final Future<void> Function({String? param}) controlTranslationFlow;

  const new({
    required this.controlTranslationFlow, 
    super.key
  });

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  late Map<String, String> langInfo;
  late int length;

  @override
  void initState() {
    super.initState();

    langInfo = {"emoji": defaultEmoji, "lang_flag": defaultLangFlag};

    length = TranslationCacheHelper.language.length;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      shadowColor: AppThemes.whitePremium.withValues(alpha: 0.1),
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          final response = await getLangInfo();
          if (response == null) {
            return;
          }

          langInfo.clear();
          langInfo.addAll(response);

          setState(() {});

          await widget.controlTranslationFlow(param: langInfo["lang_flag"]);
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppThemes.whitePremium.withValues(alpha: 0.5),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              langInfo["emoji"]!,
              style: const TextStyle(fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }

  Future<Map<String, String>?> getLangInfo() async {
    return await CustomFeedback.rawDialog<Map<String, String>?>(
      context: context,
      title: Center(
        child: const Text(
          "Idiomas",
          style: TextStyle(color: AppThemes.blue1, fontWeight: FontWeight.bold),
        ),
      ),
      content: Column(
        mainAxisSize: .min,
        children: <Widget>[
          ...List.generate(length, (index) {
            return InkWell(
              onTap: () {
                final response = {
                  "emoji": TranslationCacheHelper.language[index]!.emoji,
                  "lang_flag": TranslationCacheHelper.language[index]!.langFlag,
                };
                Navigator.pop(context, response);
              },
              child: ListTile(
                title: Text(
                  TranslationCacheHelper.language[index]!.lang,
                  style: TextStyle(color: AppThemes.blue1),
                ),
                trailing: Text(TranslationCacheHelper.language[index]!.emoji),
              ),
            );
          }),
        ],
      ),
    );
  }
}
