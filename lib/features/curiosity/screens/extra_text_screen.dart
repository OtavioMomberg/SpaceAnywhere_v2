import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/glass_container.dart';
import 'package:space_anywhere/shared/widgets/header.dart';

class const ExtraTextScreen({
  required final String title, 
  required final String text, 
  super.key
  }) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppThemes.blue3,
      body: SafeArea(
        top: false,
        child: Container(
          padding: const .only(top: 20, left: 10, right: 10, bottom: 10),
          decoration: const BoxDecoration(gradient: AppThemes.mainGradient),
          child: Column(
            mainAxisAlignment: .start,
            spacing: 40,
            children: <Widget>[
              Header(
                title: Text(
                  title,
                  style: const TextStyle(
                    color: AppThemes.whitePremium,
                    fontWeight: .bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  textAlign: .center,
                ),
              ),
              Flexible(
                child: FractionallySizedBox(
                  heightFactor: 0.85,
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
                            textAlign: .justify,
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
