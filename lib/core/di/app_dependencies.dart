import 'package:http/http.dart';
import 'package:space_anywhere/features/curiosity/domain/curiosity_controller.dart';
import 'package:space_anywhere/features/translation/domain/language_controller.dart';
import 'package:space_anywhere/features/quiz/domain/question_controller.dart';
import 'package:space_anywhere/features/translation/domain/translation_controller.dart';
import 'package:space_anywhere/features/wallpaper/domain/wallpaper_controller.dart';
import 'package:space_anywhere/features/curiosity/data/repositories/curiosity_implementation.dart';
import 'package:space_anywhere/features/translation/data/repositories/language_implementation.dart';
import 'package:space_anywhere/features/quiz/data/repositories/question_inplementation.dart';
import 'package:space_anywhere/features/translation/data/repositories/translation_implementation.dart';
import 'package:space_anywhere/features/wallpaper/data/repositories/wallpaper_implementation.dart';
import 'package:space_anywhere/features/curiosity/data/repositories/sqlite_implementation.dart';

class AppDependencies {
  static final db = SqliteImplementation.instance();

  static final _client = Client();

  static CuriosityController get curiosityController =>
    CuriosityController(curiosityRepository: CuriosityImplementation(client: _client));

  static QuestionController get questionController =>
    QuestionController(questionRepository: QuestionInplementation(client: _client));

  static WallpaperController get wallpaperController =>
    WallpaperController(wallpaperRepository: WallpaperImplementation(client: _client));

  static LanguageController get languageController =>
    LanguageController(languageRepository: LanguageImplementation(client: _client));

  static TranslationController get translationController =>
    TranslationController(translationRepository: TranslationImplementation(client: _client));
}
