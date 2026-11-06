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
          padding: AppThemes.padding,
          decoration: const BoxDecoration(gradient: AppThemes.mainGradient),
          child: Column(
            mainAxisAlignment: .start,
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
              const SizedBox(height: 25),
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
