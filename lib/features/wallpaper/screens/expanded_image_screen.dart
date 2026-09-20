import 'package:custom_feedback/custom_feedback.dart';
import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/wallpaper/domain/save_image_helper.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/utils/glass_snackbar_helper.dart';
import 'package:space_anywhere/shared/widgets/button.dart';
import 'package:space_anywhere/shared/widgets/header.dart';
import 'package:space_anywhere/shared/widgets/image_widget.dart';

class ExpandedImageScreen extends StatefulWidget {
  final String imagePath;
  final ImageOption option;

  const new({required this.imagePath, required this.option, super.key});

  @override
  State<ExpandedImageScreen> createState() => _ExpandedImageScreenState();
}

class _ExpandedImageScreenState extends State<ExpandedImageScreen>
    with GlassSnackBarHelper {
  bool response = false;

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
            spacing: 25,
            children: <Widget>[
              Header(
                title: const Text(
                  "Wallpaper para download!",
                  style: TextStyle(
                    color: AppThemes.whitePremium,
                    fontSize: 16,
                    fontWeight: .bold,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const .only(bottom: 10),
                  child: Hero(
                    tag: widget.imagePath,
                    child: ImageWidget(
                      imagePath: widget.imagePath,
                      option: widget.option,
                    ),
                  ),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: Button(label: "Baixar", asyncFunction: _saveImage),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveImage() async {
    await _showResponse();

    if (!mounted) {
      return;
    }

    showGlassSnackBar(
      context: context,
      msm: response ? "Imagem salva na galeria!" : "Erro ao salvar imagem.",
      backgroundColor: response ? AppThemes.lightBlue : AppThemes.red,
    );
  }

  Future<void> _showResponse() async {
    response =
        await CustomFeedback.loadingDialog<bool>(
          context: context,
          title: "Salvando imagem!",
          fontColor: AppThemes.blue1,
          onOpen: () =>
              SaveImageHelper.saveImageFromUrl(imageUrl: widget.imagePath),
        ) ??
        false;
  }
}
