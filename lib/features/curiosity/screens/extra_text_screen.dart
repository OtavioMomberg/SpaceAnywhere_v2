import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';

class ExtraTextScreen extends StatelessWidget {
  final String title;
  final String text;

  const ExtraTextScreen({required this.title, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppThemes.blue3,
      body: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          decoration: const BoxDecoration(gradient: AppThemes.mainGradient),
          child: Column(
            mainAxisAlignment: .start,
            spacing: 20,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: AppThemes.whitePremium,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              Flexible(
                child: FractionallySizedBox(
                  heightFactor: 0.9,
                  child: GlassContainer(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: .start,
                        spacing: 20,
                        children: <Widget>[
                          Text(
                            text,
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
            ],
          ),
        ),
      ),
    );
  }
}
