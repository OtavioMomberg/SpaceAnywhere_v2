import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:space_anywhere/features/translation/data/models/translation_model.dart';
import 'package:space_anywhere/features/translation/data/repositories/translation_implementation.dart';
import 'package:space_anywhere/features/translation/data/repositories/translation_repository.dart';

void main() {
  test("Check parsing from json to List<TranslationModel>", () {
    final data = jsonEncode(
      [
        {
          "id": 1,
          "translation": "Terra",
          "lang_flag": "pt-BR"
        },
        {
          "id": 2,
          "translation": "Marte",
          "lang_flag": "pt-BR"
        }
      ]
    );
    final model = TranslationModel.fromList(source: data);

    expect(model.first.id, 1);
    expect(model.first.translation, "Terra");
    expect(model.first.langFlag, "pt-BR");
  });

  group("Check API responses", () {
    late final MockClient client;
    late final TranslationRepository repo;

    setUpAll(() {
      client = MockClient((request) async {
        final flag = request.url.queryParameters;

        if (flag["language"] != "pt-BR") {
          return Response(jsonEncode([]), 404);
        }

        return Response(
          jsonEncode(
            [
              {
                "id": 1,
                "translation": "Terra",
                "lang_flag": "pt-BR"
              },
              {
                "id": 2,
                "translation": "Marte",
                "lang_flag": "pt-BR"
              }
            ]
          ),
          200
        );
      });
      repo = TranslationImplementation(client: client);
    });

    test("verify the translated data returned", () async {
      final response = await repo.getTrasnlations(langFlag: "pt-BR");

      expect(response.first!.id, 1);
      expect(response.first!.translation, "Terra");
      expect(response.first!.langFlag, "pt-BR");
    });

    test("check invalid lang_flag", () async {
      await expectLater(repo.getTrasnlations(langFlag: "ja-JP"), throwsException);
    });
  });
}