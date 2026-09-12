import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/wallpaper/domain/save_image_helper.dart';
import 'package:space_anywhere/shared/models/object_information.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/image_widget.dart';

class ComparisonCard extends StatelessWidget {
  final List<String> objectData;
  final String objectName;
  final String imagePath;

  const new({
    required this.objectData,
    required this.objectName,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      height: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .start,
          spacing: 10,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.3,
                  width: double.infinity,
                  child: Center(
                    child: ImageWidget(
                      imagePath: imagePath,
                      option: ImageOption.asset,
                    ),
                  ),
                ),
                const Text(
                  "*Imagem gerada por Inteligência Artificial",
                  style: TextStyle(color: AppThemes.whitePremium),
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Divider(color: AppThemes.whitePremium),
            Center(
              child: Text(
                objectName,
                style: TextStyle(color: AppThemes.whitePremium),
              ),
            ),
            const Divider(color: AppThemes.whitePremium),
            const SizedBox(height: 10),

            ...List.generate(ObjectInformation.topics.length, (index) {
              return Text(
                "${ObjectInformation.topics[index]} ${objectData[index]}",
                style: const TextStyle(color: AppThemes.whitePremium),
              );
            }),
          ],
        ),
      ),
    );
  }
}
