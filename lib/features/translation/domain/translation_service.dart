import 'package:space_anywhere/features/translation/domain/language_controller.dart';
import 'package:space_anywhere/features/translation/domain/translation_controller.dart';
import 'package:space_anywhere/core/constants/app_constants.dart';
import 'package:space_anywhere/features/translation/domain/translation_cache_helper.dart';
import 'package:space_anywhere/shared/utils/internet_helper.dart';

class TranslationService<T> {
  static const stepsToInstallVoice = [
    "1- Abra as Configurações do celular",
    "2- Entre em Acessibilidade",
    "3- Procure Conversão de texto em voz / Saída de texto para fala",
    "4- Encontre a opção Língua",
    "5- Selecione uma língua e instale-a",
    "6- Reinicie o SpaceAnywhere e tente novamente!",
  ];

  late InternetHelper<T> _internet;
  late final bool Function() checkMounted;
  late final void Function() setState;
  String? _error;
  bool _isLoading = true;

  final TranslationController translationController;
  final LanguageController languageController;

  TranslationService({
    required this.translationController,
    required this.languageController,
  });

  bool get checkInternet => _internet.checkInternet;
  bool get checkAPI => _internet.checkAPI;
  String? get error => _error;
  bool get isLoading => _isLoading;

  set generalError(String value) => _error = value;

  void postInit({
    required bool Function() checkMountedFunc,
    required void Function() setStateFunc,
  }) {
    checkMounted = checkMountedFunc;
    setState = setStateFunc;
  }

  Future<void> controlTranslationFlow({T? param}) async {
    await getTranslations(langFlag: param as String?);

    if (_internet.currentRetryAttempt != _internet.retryAttempts) { return; }

    if (!checkMounted()) { return; }

    _isLoading = false;
    setState();
  }

  void buildInternetInstance() {
    _internet = InternetHelper.withFunctionParameter(
      functionWithParam: controlTranslationFlow,
    );
  }

  void initializeConnectionSystem() {
    try {
      _internet.retryConnectionSystemWithParam();
    } on Exception catch (error) {
      generalError = error.toString();
      _internet.updateInternetStatus(status: true);
      _internet.updateAPIStatus(status: true);
      _isLoading = false;
      setState();
    }
  }

  bool checkState() {
    return _isLoading || !_internet.checkInternet || !_internet.checkAPI;
  }

  Future<bool> check() async {
    await _internet.hasInternet();

    if (!_internet.checkInternet) { return false; }

    await _internet.isApiAwake();

    if (!_internet.checkAPI) { return false; }

    return true;
  }

  Future<void> getTranslations({String? langFlag}) async {
    langFlag ??= defaultLangFlag;

    if (TranslationCacheHelper.translation[langFlag] != null) {
      final value = TranslationCacheHelper.translation[langFlag]!;
      translationController.cacheTranslationModel = value;
      _internet.updateInternetStatus(status: true);
      _internet.updateAPIStatus(status: true);
      return;
    }

    if (!await check()) { return; }

    await getLanguages();

    await translationController.onGetTranslations(langFlag: langFlag);

    if (translationController.error == null) {
      TranslationCacheHelper.translation[langFlag] =
          translationController.translationModel;
    } else {
      _error = translationController.error!;
    }
  }

  Future<void> getLanguages() async {
    if (!_checkLanguageCache()) {
      return;
    }

    await languageController.onGetLanguages();

    if (languageController.error == null) {
      TranslationCacheHelper.language.addAll(languageController.languageModel);

      for (var lang in TranslationCacheHelper.language) {
        TranslationCacheHelper.translation[lang!.langFlag] = null;
      }
    } else {
      _error = languageController.error!;
    }
  }

  bool _checkLanguageCache() {
    if (TranslationCacheHelper.language.isEmpty) {
      return true;
    }

    _internet.updateInternetStatus(status: true);
    _internet.updateAPIStatus(status: true);
    return false;
  }
}
