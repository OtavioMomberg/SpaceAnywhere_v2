import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:space_anywhere/features/curiosity/data/models/curiosity_model.dart';
import 'package:space_anywhere/features/curiosity/data/repositories/curiosity_implementation.dart';
import 'package:space_anywhere/features/curiosity/data/repositories/curiosity_repository.dart';

void main() {
  test("Check parsing from Map<String, dynamic> to CuriosityModel", () {
    final map = {
      "id": 1,
      "title": "Title",
      "short_answer": "Short Answer...",
      "long_answer": "Long Answer...",
      "content_font": ["font_1", "font_2", "font_3"]
    };
    final model = CuriosityModel.fromMap(map: map);

    expect(model.id, 1);
    expect(model.title, "Title");
    expect(model.shortAnswer, "Short Answer...");
    expect(model.longAnswer, "Long Answer...");
    expect(model.contentFont, ["font_1", "font_2", "font_3"]);
  });

  group("Check API responses", () {
    late final MockClient client;
    late final CuriosityRepository implementation;

    setUpAll(() {
      client = MockClient((request) async {
        return Response(
          jsonEncode({
            "id": 1,
            "title": "Title",
            "short_answer": "Short Answer...",
            "long_answer": "Long Answer...",
            "content_font": ["font_1", "font_2", "font_3"],
          }),
          200,
        );
      });
      implementation = CuriosityImplementation(client: client);
    });

    test("verify the curiosty data returned", () async {
      final map = await implementation.getCuriosity(id: 1);

      expect(map.id, 1);
      expect(map.title, "Title");
      expect(map.shortAnswer, "Short Answer...");
      expect(map.longAnswer, "Long Answer...");
      expect(map.contentFont, ["font_1", "font_2", "font_3"]);

    });

    test("throw an Exception", () async {
      await expectLater(
        implementation.getCuriosity(id: 2),
        throwsException,
      );
    });
  });
}