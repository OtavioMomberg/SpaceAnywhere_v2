import 'package:material_ui/material_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:space_anywhere/features/wallpaper/domain/save_image_helper.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/features/wallpaper/domain/cache_manager_helper.dart';

class ImageWidget extends StatelessWidget {
  final String imagePath;
  final ImageOption option;

  const ImageWidget({required this.imagePath, required this.option, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppThemes.borderRadius,
      child: option == ImageOption.asset
          ? Image.asset(
              imagePath,
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain,
              colorBlendMode: BlendMode.darken,
            )
          : CachedNetworkImage(
              imageUrl: imagePath,
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.darken,
              cacheManager: CacheManagerHelper.instance,
              placeholder: (context, url) {
                return Container(
                  color: AppThemes.whitePremium.withValues(alpha: 0.05),
                  child: Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: AppThemes.whitePremium.withValues(
                        alpha: 0.5,
                      ),
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  color: AppThemes.whitePremium.withValues(alpha: 0.05),
                  child: const Icon(Icons.broken_image, color: Colors.white38),
                );
              },
            ),
    );
  }
}
