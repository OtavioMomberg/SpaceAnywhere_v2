import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/translation/data/models/language_model.dart';
import 'package:space_anywhere/features/translation/domain/translation_cache_helper.dart';
import 'package:space_anywhere/features/translation/presentation/widgets/language_selector.dart';

void main() {
  group("Check LanguageSelector widget", () {
    TranslationCacheHelper.language = [
      LanguageModel(lang: "Português", langFlag: "pt-BR", emoji: "🇧🇷"),
      LanguageModel(lang: "Inglês", langFlag: "en-US", emoji: "🇺🇸"),
    ];  

    testWidgets("Verify if langInfo is initializing correctly", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LanguageSelector(
              controlTranslationFlow: ({String? param}) async {}
            )
          ),
        ),
      );

      expect(find.text("🇧🇷"), findsOneWidget);
    });

    testWidgets("Verify if UI changes when new lang is selected", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LanguageSelector(
              controlTranslationFlow: ({String? param}) async {
                await Future.delayed(const Duration(milliseconds: 200));
              }
            )
          ),
        ),
      );

      expect(find.text("🇺🇸"), findsNothing);
      expect(find.text("🇧🇷"), findsOneWidget);

      await tester.tap(find.byType(InkWell));

      await tester.pump(const Duration(milliseconds: 200));

      await tester.tap(find.text("Inglês"));

      await tester.pumpAndSettle();

      expect(find.text("🇺🇸"), findsOneWidget);
      expect(find.text("🇧🇷"), findsNothing);
    });
  });
}