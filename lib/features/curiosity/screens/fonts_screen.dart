import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/curiosity/domain/open_links_helper.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

class FontsScreen extends StatelessWidget {
  final List<String> fonts;

  const FontsScreen({required this.fonts, super.key});

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
            spacing: 20,
            children: <Widget>[
              const Text(
                "Fontes Consultadas",
                style: TextStyle(color: AppThemes.whitePremium, fontSize: 20),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: fonts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 4,
                      ),
                      child: Material(
                        borderRadius: AppThemes.borderRadius,
                        color: AppThemes.whitePremium.withValues(alpha: 0.1),
                        child: InkWell(
                          borderRadius: AppThemes.borderRadius,
                          onTap: () => OpenLinksHelper.openLink(url: fonts[index]),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              fonts[index],
                              style: const TextStyle(
                                color: AppThemes.whitePremium,
                                decoration: TextDecoration.underline,
                                decorationColor: AppThemes.whitePremium,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
