import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';

class Stars extends StatefulWidget {
  final bool isLeft;
  final bool differentSizes;
  final bool differentPaddings;
  final bool differentSpacing;

  const Stars({
    this.isLeft = false,
    this.differentSizes = false,
    this.differentPaddings = false,
    this.differentSpacing = false,
    super.key,
  });

  @override
  State<Stars> createState() => _StarsState();
}

class _StarsState extends State<Stars> {
  double rotationL = 0;
  double rotationR = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: widget.differentSpacing ? 15 : 10,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: widget.differentPaddings
                  ? const EdgeInsets.only(left: 25)
                  : const EdgeInsets.only(left: 10),
              child: Material(
                elevation: 5,
                color: AppThemes.whitePremium,
                shadowColor: AppThemes.whitePremium,
                shape: StarBorder(pointRounding: .5, rotation: rotationL),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  splashColor: Colors.transparent,
                  onTap: () {
                    rotationL = changeRotation(rotation: rotationL);
                    setState(() {});
                  },
                  child: SizedBox.square(
                    dimension: widget.differentSizes ? 35 : 40,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: .end,
          children: <Widget>[
            Padding(
              padding: widget.differentPaddings
                  ? const EdgeInsets.only(right: 40)
                  : const EdgeInsets.only(right: 10),
              child: Material(
                elevation: 5,
                color: AppThemes.whitePremium,
                shadowColor: AppThemes.whitePremium,
                shape: StarBorder(pointRounding: .5, rotation: rotationR),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  splashColor: Colors.transparent,
                  onTap: () {
                    rotationR = changeRotation(rotation: rotationR);
                    setState(() {});
                  },
                  child: SizedBox.square(
                    dimension: widget.differentSizes ? 30 : 40,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  double changeRotation({required double rotation}) {
    return rotation == 360 ? 0 : 360;
  }
}
