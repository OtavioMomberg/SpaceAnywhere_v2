import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/di/app_dependencies.dart';
import 'package:space_anywhere/features/quiz/presentation/screens/result_screen.dart';
import 'package:space_anywhere/core/routes/app_routes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';
import 'package:space_anywhere/features/quiz/domain/quiz_service.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/utils/glass_snackbar_helper.dart';
import 'package:space_anywhere/features/quiz/presentation/widgets/answer_card.dart';
import 'package:space_anywhere/shared/widgets/button.dart';
import 'package:space_anywhere/shared/widgets/check_connection.dart';
import 'package:space_anywhere/features/quiz/presentation/widgets/question_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with GlassSnackBarHelper {
  final _quizService = QuizService<int>(
    questionController: AppDependencies.questionController,
  );

  @override
  void initState() {
    super.initState();

    _quizService.initializeQuiz();
    _quizService.postInit(
      showResponseFunc: _showResponse,
      closeAnswerPageFunc: _closeAnswerPage,
      checkMountedFunc: _checkMounted,
      setStateFunc: _setStateCallback,
      snackBarFunc: _showSnackBar,
    );

    _quizService.buildInternetInstance();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _quizService.initializeConnectionSystem();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      mainAxisAlignment: .start,
      children: <Widget>[
        if (!_quizService.quizStarted) ...[
          Text(
            "Quiz",
            style: TextStyle(
              color: AppThemes.whitePremium,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 20),
          GlassContainer(
            height: size.height * 0.4,
            borderRadius: AppThemes.borderRadius,
            child: Column(
              mainAxisAlignment: .center,
              spacing: 20,
              children: <Widget>[
                const Text(
                  "Quiz de Astronômia",
                  style: TextStyle(color: AppThemes.whitePremium, fontSize: 18),
                ),
                const Icon(
                  Icons.rocket_launch,
                  color: AppThemes.whitePremium,
                  size: 30,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: Button(
              label: "Jogar",
              awaitFunction: _quizService.startQuiz,
            ),
          ),
        ] else if (_quizService.checkState()) ...[
          CheckConnection(
            isLoading: _quizService.isLoading,
            checkInternet: _quizService.checkInternet,
            checkAPI: _quizService.checkAPI,
            height: size.height * 0.6,
          ),
        ] else if (_quizService.error == null) ...[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: QuestionCard(
                question:
                    _quizService.questionController.getQuestionModel!.question,
                color: AppThemes.whitePremium,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: <Widget>[
                  ...List.generate(QuizService.alternativesNumber, (index) {
                    return AnswerCard(
                      index: index,
                      option: _quizService
                          .questionController
                          .getQuestionModel!
                          .alternatives[index],
                      color: AppThemes.whitePremium,
                      onTap: ({required int index}) async =>
                          await _quizService.onTapAnswer(index: index),
                    );
                  }),
                ],
              ),
            ),
          ),
        ] else ...[
          GlassContainer(
            height: size.height * 0.6,
            child: Text(
              _quizService.error!,
              style: const TextStyle(color: AppThemes.whitePremium),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _closeAnswerPage() async {
    await _quizService.controlQuizFlow(
      param: _quizService.questionController.getQuestionModel!.id,
    );

    if (!mounted) {
      return;
    }
    Navigator.pop(context);
  }

  bool _checkMounted() => mounted == true;

  void _setStateCallback() => setState(() {});

  void _showSnackBar({bool error = false}) {
    showGlassSnackBar(
      context: context,
      msm: error == false
          ? _quizService.retrySucced
                ? "Conexão Reestabelecida!"
                : "Próxima pergunta!"
          : "Não foi possível se conectar ao servidor.",
      backgroundColor: error == false
          ? _quizService.retrySucced
                ? AppThemes.lightBlue
                : AppThemes.white
          : AppThemes.red,
      duration: const Duration(seconds: 1)
    );
  }

  void _showResponse({required bool isCorrect, String? correctAnswer}) {
    if (!mounted) return;
    Navigator.push(
      context,
      AppRoutes.getRoute(
        page: ResultScreen(isCorrect: isCorrect, correctAnswer: correctAnswer),
        type: TransitionType.scale,
      ),
    );
  }
}
