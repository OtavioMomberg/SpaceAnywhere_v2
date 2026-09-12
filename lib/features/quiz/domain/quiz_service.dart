import 'package:space_anywhere/features/quiz/domain/question_controller.dart';
import 'package:space_anywhere/shared/utils/internet_helper.dart';

class QuizService<T>({required final QuestionController questionController}) {
  static const _id = 0;
  static const alternativesNumber = 5;
  late InternetHelper<T> _internet;
  String? _error;
  bool _quizStarted = false;
  bool _isLoading = true;
  bool _retrySucced = false;
  
  late final void Function({
    required bool isCorrect, 
    String? correctAnswer}) showResponse;
  late final Future<void> Function() closeAnswerPage;
  late final bool Function() checkMounted;
  late final void Function() setState;
  late final void Function({bool error}) snackBar;

  bool get checkInternet => _internet.checkInternet;
  bool get checkAPI => _internet.checkAPI;
  bool get quizStarted => _quizStarted;
  bool get isLoading => _isLoading;
  bool get retrySucced => _retrySucced;
  String? get error => _error;

  set generalError(String value) => _error = value;

  void initializeQuiz() => _quizStarted = false;

  void postInit({
    required void Function({required bool isCorrect, String? correctAnswer})
    showResponseFunc,
    required Future<void> Function() closeAnswerPageFunc,
    required bool Function() checkMountedFunc,
    required Function() setStateFunc,
    required void Function({bool error}) snackBarFunc,
  }) {
    showResponse = showResponseFunc;
    closeAnswerPage = closeAnswerPageFunc;
    checkMounted = checkMountedFunc;
    setState = setStateFunc;
    snackBar = snackBarFunc;
  }

  Future<void> controlQuizFlow({T? param}) async {
    await getQuestion(questionId: param as int?);

    if (!checkMounted()) { return; }

    if (param != null) {
      if (!_internet.checkInternet || !_internet.checkAPI) {
        if (_internet.currentRetryAttempt == _internet.retryAttempts) {
          _internet.sendParam(value: param);
          _internet.retryConnectionSystemWithParam();
          _retrySucced = true;
          setState();
        }
        return;
      }
      snackBar();
    }

    await Future.delayed(const Duration(milliseconds: 800));

    if (!questionController.isSucced) { return; }

    if (!checkMounted()) { return; }

    _isLoading = false;
    _retrySucced = false;

    setState();
  }

  void buildInternetInstance() {
    _internet = InternetHelper.withFunctionParameter(functionWithParam: controlQuizFlow);
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

  Future<void> startQuiz() async {
    if (error != null) {
      snackBar(error: true);
      return;
    }

    if (!checkMounted()) { return; }

    _changeQuizState();

    setState();
  }

  void _changeQuizState() => _quizStarted = !_quizStarted;

  Future<void> getQuestion({int? questionId}) async {
    await _internet.hasInternet();

    if (questionId != null && !_internet.checkInternet) {
      await Future.delayed(const Duration(seconds: 2));
    }

    if (!_internet.checkInternet) { return; }

    await _internet.isApiAwake();

    if (!_internet.checkAPI) { return; }

    questionController.initIsSucced = false;
    await questionController.onGetQuestion(id: questionId ?? _id);

    if (questionController.getErrorQuestion != null) {
      _error = questionController.getErrorQuestion!;
    }
  }

  Future<void> onTapAnswer({required int index}) async {
    var controller = questionController.getQuestionModel!;
    if (controller.rightAnswerIndex == index) {
      showResponse(isCorrect: true);
    } else {
      showResponse(
        isCorrect: false,
        correctAnswer: controller.alternatives[controller.rightAnswerIndex],
      );
    }
    await closeAnswerPage();
  }
}
