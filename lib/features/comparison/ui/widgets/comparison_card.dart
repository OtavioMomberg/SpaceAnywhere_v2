import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/shared/models/object_information.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/image_widget.dart';

class const ComparisonCard({
  required final List<String> objectData,
  required final ObjectInformation planetData,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: const .only(left: 5, right: 5, bottom: 15),
      padding: const .only(top: 15, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: AppThemes.borderRadius,
        border: .all(color: AppThemes.whitePremium.withValues(alpha: 0.5)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .center,
          spacing: 10,
          children: <Widget>[
            Column(
              children: <Widget>[
                Material(
                  borderRadius: AppThemes.borderRadius,
                  elevation: 4,
                  shadowColor: AppThemes.blue3,
                  color: AppThemes.whitePremium.withValues(alpha: 0.05),
                  child: DecoratedBox(
                    position: .foreground,
                    decoration: BoxDecoration(
                      borderRadius: AppThemes.borderRadius,
                      color: AppThemes.whitePremium.withValues(alpha: 0.05),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: .75,
                      child: ImageWidget(imagePath: planetData.imagePath, option: .asset),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "*Inteligência Artificial",
                  style: TextStyle(color: AppThemes.whitePremium),
                ),
                const SizedBox(height: 20),
                Text(
                  planetData.name.toUpperCase(),
                  style: TextStyle(color: AppThemes.whitePremium, fontSize: 16),
                ),
                FractionallySizedBox(
                  widthFactor: .95,
                  child: Divider(
                    color: AppThemes.whitePremium.withValues(alpha: .5),
                  ),
                ),
              ],
            ),
            ....generate(objectData.length, (index) {
              return Align(
                alignment: .centerLeft,
                child: Text(
                  " ${ObjectInformation.topics[index]} ${objectData[index]}",
                  style: const TextStyle(color: AppThemes.whitePremium),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}