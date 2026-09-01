import 'package:space_anywhere/features/wallpaper/domain/wallpaper_controller.dart';
import 'package:space_anywhere/features/wallpaper/domain/cache_manager_helper.dart';
import 'package:space_anywhere/shared/utils/internet_helper.dart';

class WallpaperService {
  late InternetHelper _internet;
  int _offset = 0;
  String? _error;
  bool _isLoading = true;
  late final bool Function() checkMounted;
  late final void Function() setState;

  final WallpaperController wallpaperController;

  WallpaperService({required this.wallpaperController});

  bool get checkInternet => _internet.checkInternet;
  bool get checkAPI => _internet.checkAPI;
  int get offset => _offset;
  String? get error => _error;
  bool get isLoading => _isLoading;

  set generalError(String value) => _error = value;

  Future<void> postInit({
    required bool Function() checkMountedFunc,
    required void Function() setStateFunc,
  }) async {
    checkMounted = checkMountedFunc;
    setState = setStateFunc;
  }

  Future<void> _controlWallpaperFlow() async {
    await getImages();

    await Future.delayed(Duration(seconds: 1));
    if (!checkMounted()) {
      return;
    }

    if (_internet.currentRetryAttempt != _internet.retryAttempts) {
      return;
    }

    _isLoading = false;
    setState();
  }

  Future<void> buildInternetInstance() async {
    _internet = InternetHelper.withoutFunctionParameter(
      function: _controlWallpaperFlow,
    );
  }

  void initializeConnectionSystem() {
    if (!checkImageCache()) {
      _isLoading = false;
      setState();
      return;
    }
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

  void updateOffset({required int newOffset}) => _offset = newOffset;

  bool checkImageCache() {
    if (CacheManagerHelper.wallpapers != null) {
      _internet.updateInternetStatus(status: true);
      _internet.updateAPIStatus(status: true);
      return false;
    }
    return true;
  }

  Future<void> getImages() async {
    await _internet.hasInternet();

    if (!_internet.checkInternet) {
      return;
    }

    await _internet.isApiAwake();

    if (!_internet.checkAPI) {
      return;
    }

    await wallpaperController.onGetWallpaper(offset: _offset);

    if (wallpaperController.getErrorWallpaper == null) {
      CacheManagerHelper.wallpapers = wallpaperController.getWallpaperModel;
    } else {
      _error = wallpaperController.getErrorWallpaper!;
    }
  }
}
