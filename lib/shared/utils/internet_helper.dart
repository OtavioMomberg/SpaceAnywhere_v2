import "package:http/http.dart" as http;
import "package:space_anywhere/core/constants/api_constants.dart";

class InternetHelper<T> {
  static const _retryAttempts = 15;
  int _currentRetryAttempt = 0;
  bool _checkInternet = false;
  bool _checkAPI = false;
  T? _param;
  Future<void> Function({T? param})? _functionWithParam;
  Future<void> Function()? _function;

  InternetHelper.withFunctionParameter({
    required this._functionWithParam,
  });

  InternetHelper.withoutFunctionParameter({
    required this._function,
  });

  bool get checkInternet => _checkInternet;
  bool get checkAPI => _checkAPI;
  int get retryAttempts => _retryAttempts;
  int get currentRetryAttempt => _currentRetryAttempt;

  void sendParam({T? value}) => _param = value;

  Future<void> hasInternet() async {
    try {
      final url = "https://www.google.com";
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 5));
      _checkInternet = response.statusCode == 200;
    } catch (e) {
      _checkInternet = false;
    }
  }

  Future<void> isApiAwake({
    Duration duration = const Duration(seconds: 45),
  }) async {
    try {
      final url = "$baseURL/health/";
      final response = await http.get(Uri.parse(url)).timeout(duration);
      _checkAPI = response.statusCode == 200;
    } catch (error) {
      _checkAPI = false;
    }
  }

  void updateInternetStatus({required bool status}) => _checkInternet = status;

  void updateAPIStatus({required bool status}) => _checkAPI = status;

  Future<void> retryConnectionSystem() async {
    _currentRetryAttempt = 0;
    while (_currentRetryAttempt < _retryAttempts) {
      await _function!();

      if (checkInternet && checkAPI) {
        _currentRetryAttempt = _retryAttempts;
        break;
      }
      _currentRetryAttempt++;
    }
  }

  Future<void> retryConnectionSystemWithParam() async {
    _currentRetryAttempt = 0;
    while (_currentRetryAttempt < _retryAttempts) {
      await _functionWithParam!(param: _param);

      if (checkInternet && checkAPI) {
        _currentRetryAttempt = _retryAttempts;
        break;
      }
      _currentRetryAttempt++;
    }
  }
}
