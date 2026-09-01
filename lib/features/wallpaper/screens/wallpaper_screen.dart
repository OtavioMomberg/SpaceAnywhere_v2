import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/di/app_dependencies.dart';
import 'package:space_anywhere/features/wallpaper/domain/cache_manager_helper.dart';
import 'package:space_anywhere/features/wallpaper/domain/save_image_helper.dart';
import 'package:space_anywhere/features/wallpaper/screens/expanded_image_screen.dart';
import 'package:space_anywhere/core/routes/app_routes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';
import 'package:space_anywhere/features/wallpaper/domain/wallpaper_service.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/check_connection.dart';
import 'package:space_anywhere/shared/widgets/image_widget.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  final _wallpaperService = WallpaperService(
    wallpaperController: AppDependencies.wallpaperController,
  );

  @override
  void initState() {
    super.initState();

    _wallpaperService.postInit(
      checkMountedFunc: _checkMounted,
      setStateFunc: _setStateCallback,
    );

    _wallpaperService.buildInternetInstance();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _wallpaperService.initializeConnectionSystem();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      spacing: 20,
      children: <Widget>[
        const Text(
          "Catálogo de Wallpapers",
          style: TextStyle(
            color: AppThemes.whitePremium,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        if (_wallpaperService.checkState()) ...[
          CheckConnection(
            isLoading: _wallpaperService.isLoading,
            checkInternet: _wallpaperService.checkInternet,
            checkAPI: _wallpaperService.checkAPI,
            height: size.height * 0.6,
          ),
        ] else if (CacheManagerHelper.wallpapers != null) ...[
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: CacheManagerHelper.wallpapers!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _seeImageExpanded(
                      imagePath: CacheManagerHelper.wallpapers![index]!.fullImageUrl,
                      context: context,
                    );
                  },
                  child: Container(
                    padding: index % 2 == 0
                      ? const EdgeInsets.only(right: 5, bottom: 10)
                      : const EdgeInsets.only(left: 5, bottom: 10),
                    child: Hero(
                      tag: CacheManagerHelper.wallpapers![index]!.fullImageUrl,
                      child: ImageWidget(
                        imagePath: CacheManagerHelper.wallpapers![index]!.fullImageUrl,
                        option: ImageOption.network,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ] else ...[
          GlassContainer(
            height: size.height * 0.6,
            child: Text(
              _wallpaperService.error!,
              style: const TextStyle(color: AppThemes.whitePremium),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }

  bool _checkMounted() => mounted == true;

  void _setStateCallback() => setState(() {});

  void _seeImageExpanded({
    required String imagePath,
    required BuildContext context,
  }) {
    Navigator.push(
      context,
      AppRoutes.getRoute(
        page: ExpandedImageScreen(
          imagePath: imagePath,
          option: ImageOption.network,
        ),
        type: TransitionType.fade,
      ),
    );
  }
}
