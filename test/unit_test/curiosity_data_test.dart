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
    late final CuriosityRepository repo;

    setUpAll(() {
      client = MockClient((request) async {
        final id = request.url.path.split("/").last;

        if (int.parse(id) > 2) {
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
        }

        return Response(
          jsonEncode({
            "id": int.parse(id),
            "title": "Title2",
            "short_answer": "Short Answer2...",
            "long_answer": "Long Answer2...",
            "content_font": ["font_1", "font_2", "font_3"],
          }),
          200,
        );
      });
      repo = CuriosityImplementation(client: client);
    });

    test("verify the curiosty data returned", () async {
      final map = await repo.getCuriosity(id: 2);

      expect(map.id, 2);
      expect(map.title, "Title2");
      expect(map.shortAnswer, "Short Answer2...");
      expect(map.longAnswer, "Long Answer2...");
      expect(map.contentFont, ["font_1", "font_2", "font_3"]);

    });

    test("return the first curiosity when the requested ID does not exist", () async {
      final response = await repo.getCuriosity(id: 3);

      expect(response.id, 1);
      expect(response.title, "Title");
      expect(response.shortAnswer, "Short Answer...");
      expect(response.longAnswer, "Long Answer...");
      expect(response.contentFont, ["font_1", "font_2", "font_3"]);
    });
  });
}