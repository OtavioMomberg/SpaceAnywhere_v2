import 'package:space_anywhere/features/curiosity/domain/curiosity_controller.dart';
import 'package:space_anywhere/features/curiosity/data/repositories/sqlite_implementation.dart';
import 'package:space_anywhere/shared/utils/internet_helper.dart';
import 'package:space_anywhere/features/curiosity/data/models/curiosity_db_model.dart';

class CuriosityService {
  static const _curiosityId = 1;
  late InternetHelper _internet;
  String _text = "";
  String _extraText = "";
  String _title = "";
  String? _error;
  bool _isLoading = true;
  bool _showActionButtons = false;
  CuriosityDbModel? _selectCuriosity;
  final _fonts = <String>[];
  final _selectFonts = <FontDbModel>[];
  late final bool Function() checkMounted;
  late final void Function() setState;

  final SqliteImplementation db;
  final CuriosityController curiosityController;

  CuriosityService({required this.db, required this.curiosityController});

  bool get checkInternet => _internet.checkInternet;
  bool get checkAPI => _internet.checkAPI;
  String get text => _text;
  String get extraText => _extraText;
  String get title => _title;
  String? get error => _error;
  bool get isLoading => _isLoading;
  bool get showActionButtons => _showActionButtons;
  List<String> get fonts => _fonts;

  set generalError(String value) => _error = value;

  void postInit({
    required bool Function() checkMountedFunc,
    required void Function() setStateFunc,
  }) {
    checkMounted = checkMountedFunc;
    setState = setStateFunc;
  }

  Future<void> _controlCuriosityFlow() async {
    await _controlCuriosity();

    if (!checkMounted()) {
      return;
    }

    if (_internet.checkInternet && _internet.checkAPI) {
      _showActionButtons = true;
    }

    if (_internet.currentRetryAttempt != _internet.retryAttempts) {
      return;
    }

    _isLoading = false;
    setState();
  }

  void buildInternetInstance() {
    _internet = InternetHelper.withoutFunctionParameter(
      function: _controlCuriosityFlow,
    );
  }

  void initializeConnectionSystem() {
    try {
      _internet.retryConnectionSystem();
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

  Future<bool> _checkDatabaseIsNull() async {
    _selectCuriosity = await db.selectCuriosity();

    _selectFonts.clear();
    _selectFonts.addAll(await db.selectFonts());

    return _selectCuriosity == null;
  }

  String cleanText({required String text}) {
    return text
        .replaceAll('\\n', '\n')
        .replaceAll('\\r', '')
        .replaceAll('\\"', '"');
  }

  Future<void> _getCuriosity({
    required int curiosityId,
    required DatabaseActions action,
  }) async {
    await _internet.hasInternet();

    if (!_internet.checkInternet) {
      return;
    }

    await _internet.isApiAwake();

    if (!_internet.checkAPI) {
      return;
    }

    await curiosityController.onGetCuriosity(id: curiosityId);

    if (curiosityController.getErrorCuriosity == null) {
      _text = cleanText(
        text: curiosityController.getCuriosityModel!.shortAnswer,
      );
      _extraText = cleanText(
        text: curiosityController.getCuriosityModel!.longAnswer,
      );
      _title = curiosityController.getCuriosityModel!.title;
      _fonts.addAll(curiosityController.getCuriosityModel!.contentFont);
      action == DatabaseActions.add
          ? await _addCuriosity()
          : await _updateCuriosity();
    } else {
      _error = curiosityController.getErrorCuriosity!;
    }
  }

  Future<void> _controlCuriosity() async {
    bool checkDatabaseEmpty = await _checkDatabaseIsNull();

    if (!checkDatabaseEmpty) {
      final currentDate = DateTime.now();
      final date = DateTime.parse(_selectCuriosity!.time);

      if (currentDate.difference(date).inHours >= 24) {
        await _getCuriosity(
          curiosityId: _selectCuriosity!.curiosityId + 1,
          action: DatabaseActions.update,
        );
        return;
      }

      _fonts.clear();
      _internet.updateInternetStatus(status: true);
      _internet.updateAPIStatus(status: true);
      _text = cleanText(text: _selectCuriosity!.shortAnswer);
      _extraText = cleanText(text: _selectCuriosity!.longAnswer);
      _title = _selectCuriosity!.title;
      for (var font in _selectFonts) {
        _fonts.add(font.font);
      }
    } else {
      await _getCuriosity(
        curiosityId: _curiosityId,
        action: DatabaseActions.add,
      );
    }
  }

  Future<void> _addCuriosity() async {
    final curiosityModel = CuriosityDbModel(
      curiosityId: curiosityController.getCuriosityModel!.id,
      shortAnswer: cleanText(
        text: curiosityController.getCuriosityModel!.shortAnswer,
      ),
      longAnswer: cleanText(
        text: curiosityController.getCuriosityModel!.longAnswer,
      ),
      title: curiosityController.getCuriosityModel!.title,
      time: DateTime.now().toIso8601String(),
    );

    await db.addCuriosity(curiosityModel: curiosityModel);

    await _addFonts();
  }

  Future<void> _addFonts() async {
    final len = curiosityController.getCuriosityModel!.contentFont.length;
    final fonts = curiosityController.getCuriosityModel!.contentFont;

    final fontModel = List.generate(
      len,
      (index) => FontDbModel(font: fonts[index]),
    );

    for (var font in fontModel) {
      await db.addFonts(fontModel: font);
    }
  }

  Future<void> _updateCuriosity() async {
    final curiosityModel = CuriosityDbModel(
      curiosityId: curiosityController.getCuriosityModel!.id,
      shortAnswer: cleanText(
        text: curiosityController.getCuriosityModel!.shortAnswer,
      ),
      longAnswer: cleanText(
        text: curiosityController.getCuriosityModel!.longAnswer,
      ),
      title: curiosityController.getCuriosityModel!.title,
      time: DateTime.now().toIso8601String(),
    );

    await db.updateCuriosity(
      curiosityModel: curiosityModel,
      previousCuriosityId: _selectCuriosity!.curiosityId,
    );

    await db.deleteFonts();

    await _addFonts();
  }
}
