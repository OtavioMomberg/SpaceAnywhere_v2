import 'package:material_ui/material_ui.dart';
import 'dart:math';
import 'package:space_anywhere/features/comparison/data/comparison_dataset.dart';
import 'package:space_anywhere/shared/models/object_information.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/features/comparison/presentation/widgets/comparison_card.dart';

class ComparisonScreen extends StatefulWidget {
  const ComparisonScreen({super.key});

  @override
  State<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  final _scrollController = ScrollController();
  final finalList = <ObjectInformation>[];
  final rand = Random();

  @override
  void initState() {
    super.initState();
    _randomizeList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: ComparisonDataset.objects.length,
            itemExtent: size.width - 20,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: AppThemes.borderRadius,
                  border: Border.all(
                    color: AppThemes.whitePremium.withValues(alpha: 0.5),
                  ),
                  color: AppThemes.whitePremium.withValues(alpha: 0.15),
                ),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => _moveScroll(value: -(size.width - 20)),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppThemes.whitePremium,
                      ),
                    ),
                    Expanded(
                      child: ComparisonCard(
                        objectData: finalList[index].toList(),
                        objectName: finalList[index].name,
                        imagePath: finalList[index].imagePath,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _moveScroll(value: size.width - 20),
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: AppThemes.whitePremium,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _randomizeList() {
    while (finalList.length < ComparisonDataset.objects.length) {
      int index = rand.nextInt(ComparisonDataset.objects.length);

      if (!finalList.contains(ComparisonDataset.objects[index])) {
        finalList.add(ComparisonDataset.objects[index]);
      }
    }
  }

  void _moveScroll({required double value}) {
    _scrollController.animateTo(
      _scrollController.offset + value,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
