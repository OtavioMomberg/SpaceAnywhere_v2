import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/di/app_dependencies.dart';
import 'package:space_anywhere/features/curiosity/screens/extra_text_screen.dart';
import 'package:space_anywhere/features/curiosity/screens/fonts_screen.dart';
import 'package:space_anywhere/core/routes/app_routes.dart';
import 'package:space_anywhere/features/curiosity/domain/curiosity_service.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/button.dart';
import 'package:space_anywhere/shared/widgets/check_connection.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';

class CuriosityScreen extends StatefulWidget {
  const CuriosityScreen({super.key});

  @override
  State<CuriosityScreen> createState() => _CuriosityScreenState();
}

class _CuriosityScreenState extends State<CuriosityScreen> {
  final _homeService = CuriosityService(
    db: AppDependencies.db,
    curiosityController: AppDependencies.curiosityController,
  );

  @override
  void initState() {
    super.initState();

    _homeService.postInit(
      checkMountedFunc: _checkMounted,
      setStateFunc: _setStateCallback,
    );

    _homeService.buildInternetInstance();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeService.initializeConnectionSystem();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      spacing: 20,
      mainAxisAlignment: .start,
      children: <Widget>[
        const Text(
          "Curiosidade do Dia",
          style: TextStyle(
            color: AppThemes.whitePremium,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        if (_homeService.checkState()) ...[
          CheckConnection(
            isLoading: _homeService.isLoading,
            checkInternet: _homeService.checkInternet,
            checkAPI: _homeService.checkAPI,
            height: size.height * 0.6,
          ),
        ] else if (_homeService.error == null) ...[
          Flexible(
            child: FractionallySizedBox(
              heightFactor: 0.9,
              child: GlassContainer(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 15,
                    children: <Widget>[
                      Text(
                        _homeService.title,
                        style: const TextStyle(
                          color: AppThemes.whitePremium,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        _homeService.text,
                        style: const TextStyle(
                          color: AppThemes.whitePremium,
                          height: 1.7,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ] else ...[
          GlassContainer(
            height: size.height * 0.6,
            child: Text(
              _homeService.error!,
              style: const TextStyle(color: AppThemes.whitePremium),
              textAlign: TextAlign.center,
            ),
          ),
        ],
        if (_homeService.showActionButtons) ...[
          Row(
            mainAxisAlignment: .center,
            spacing: 10,
            children: <Widget>[
              Expanded(
                child: Button(
                  label: "Saiba Mais",
                  function: () {
                    _goNextPage(
                      page: ExtraTextScreen(
                        title: _homeService.title,
                        text: _homeService.extraText,
                      ),
                      type: TransitionType.slideLtoR,
                    );
                  },
                ),
              ),
              Expanded(
                child: Button(
                  label: "Fontes",
                  function: () {
                    _goNextPage(
                      page: FontsScreen(fonts: _homeService.fonts),
                      type: TransitionType.slideRtoL,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  bool _checkMounted() => mounted == true;

  void _setStateCallback() => setState(() {});

  void _goNextPage({required Widget page, required TransitionType type}) {
    Navigator.push(context, AppRoutes.getRoute(page: page, type: type));
  }
}
