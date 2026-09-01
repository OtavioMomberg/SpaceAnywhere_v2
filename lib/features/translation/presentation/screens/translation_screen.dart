import 'package:material_ui/material_ui.dart';
import 'package:custom_feedback/custom_feedback.dart';
import 'package:space_anywhere/core/di/app_dependencies.dart';
import 'package:space_anywhere/core/routes/app_routes.dart';
import 'package:space_anywhere/features/translation/domain/flutter_tts_helper.dart';
import 'package:space_anywhere/shared/utils/glass_snackbar_helper.dart';
import 'package:space_anywhere/features/translation/domain/translation_cache_helper.dart';
import 'package:space_anywhere/features/translation/presentation/screens/how_install_voice_screen.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/check_connection.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';
import 'package:space_anywhere/features/translation/presentation/widgets/language_selector.dart';
import 'package:space_anywhere/features/translation/presentation/widgets/translated_objects.dart';
import 'package:space_anywhere/features/translation/domain/translation_service.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen>
    with GlassSnackBarHelper {
  final _translationService = TranslationService<String>(
    translationController: AppDependencies.translationController,
    languageController: AppDependencies.languageController,
  );
  final _flutterTTS = FlutterTtsHelper();

  @override
  void initState() {
    super.initState();

    initPlayer();

    _translationService.postInit(
      checkMountedFunc: _checkMounted,
      setStateFunc: _setStateCallback,
    );

    _translationService.buildInternetInstance();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _translationService.initializeConnectionSystem();
    });
  }

  Future<void> initPlayer() async {
    await _flutterTTS.init();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      spacing: 10,
      children: <Widget>[
        Row(
          spacing: 10,
          mainAxisAlignment: .center,
          children: <Widget>[
            const Text(
              "Astronomia Pelo Mundo",
              style: TextStyle(
                color: AppThemes.whitePremium,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            IconButton(
              onPressed: _helpDialog,
              icon: const Icon(
                Icons.help_rounded,
                color: AppThemes.whitePremium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        if (_translationService.checkState()) ...[
          CheckConnection(
            isLoading: _translationService.isLoading,
            checkInternet: _translationService.checkInternet,
            checkAPI: _translationService.checkAPI,
            height: size.height * 0.6,
          ),
        ] else if (TranslationCacheHelper.language.isNotEmpty) ...[
          if (_translationService.error == null) ...[
            const Text(
              "Selecione um Idioma!",
              style: TextStyle(
                color: AppThemes.whitePremium,
                fontWeight: FontWeight.bold,
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.5,
              child: LanguageSelector(controlTranslationFlow: _changeLanguage),
            ),
            const SizedBox(height: 20),

            TranslatedObjects(
              translationService: _translationService,
              flutterTtsService: _flutterTTS,
            ),
          ] else ...[
            GlassContainer(
              height: size.height * 0.6,
              child: Text(
                _translationService.error!,
                style: TextStyle(color: AppThemes.whitePremium),
              ),
            ),
          ],
        ] else ...[
          GlassContainer(
            height: size.height * 0.6,
            child: Text(
              "Erro ao carregar idiomas",
              style: TextStyle(color: AppThemes.whitePremium),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _changeLanguage({String? param}) async {
    await _translationService.controlTranslationFlow(param: param);

    if (mounted) {
      showGlassSnackBar(
        context: context,
        msm: "Idioma alterado!",
        backgroundColor: AppThemes.lightBlue,
        duration: const Duration(milliseconds: 1500),
      );
    }

    if (_translationService.error == null) {
      final langFlag = _translationService
          .translationController
          .translationModel
          .first!
          .langFlag;

      await _flutterTTS.setLanguage(langFlag: langFlag);
    }
  }

  void _helpDialog() {
    CustomFeedback.rawDialog(
      context: context,
      title: const Text(
        "Ajuda",
        style: TextStyle(color: AppThemes.blue1, fontWeight: FontWeight.bold),
      ),
      closeIcon: true,
      iconColor: AppThemes.blue1,
      content: Column(
        mainAxisSize: .min,
        children: <Widget>[
          const Text(
            FlutterTtsHelper.error,
            style: TextStyle(color: AppThemes.blue1),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                AppRoutes.getRoute(
                  page: HowInstallVoiceScreen(),
                  type: TransitionType.fade,
                ),
              );
            },
            child: const Text(
              "Veja como instalar",
              style: TextStyle(
                color: AppThemes.blue1,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: AppThemes.blue1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _checkMounted() => mounted == true;

  void _setStateCallback() => setState(() {});
}
