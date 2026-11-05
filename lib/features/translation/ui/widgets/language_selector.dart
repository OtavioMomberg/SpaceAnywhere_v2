import 'package:material_ui/material_ui.dart';
import 'package:custom_feedback/custom_feedback.dart';
import 'package:space_anywhere/core/constants/app_constants.dart';
import 'package:space_anywhere/features/translation/domain/translation_cache_helper.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

typedef Translation = Future<void> Function({String? param});

class const LanguageSelector({
  required final Translation controlTranslationFlow, 
  super.key
}) extends StatefulWidget {
  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  late Map<String, String> _langInfo;
  late int _length;

  @override
  void initState() {
    super.initState();
    _langInfo = {"emoji": defaultEmoji, "lang_flag": defaultLangFlag};
    _length = TranslationCacheHelper.language.length;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: .circular(10),
      color: Colors.transparent,
      shadowColor: AppThemes.whitePremium.withValues(alpha: 0.05),
      elevation: 5,
      child: InkWell(
        borderRadius: .circular(10),
        onTap: () async {
          final response = await getLangInfo();
          if (response == null) { return; }

          _langInfo.clear();
          _langInfo.addAll(response);
          setState(() {});

          await widget.controlTranslationFlow(param: _langInfo["lang_flag"]);
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            border: .all(
              color: AppThemes.whitePremium.withValues(alpha: 0.5),
            ),
            borderRadius: .circular(10),
          ),
          child: Center(  
            child: Text(
              _langInfo["emoji"]!,
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
          ...List.generate(_length, (index) {
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