import 'package:material_ui/material_ui.dart';
import 'dart:math';
import 'package:space_anywhere/features/comparison/data/comparison_dataset.dart';
import 'package:space_anywhere/shared/models/object_information.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/features/comparison/ui/widgets/comparison_card.dart';
import 'package:space_anywhere/shared/widgets/icon_button_outlined.dart';
import 'package:space_anywhere/shared/widgets/main_header.dart';

class const ComparisonScreen({super.key}) extends StatefulWidget {
  @override
  State<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  final _scrollController = ScrollController();
  final planetsInfo = <ObjectInformation>[];
  final random = Random();

  @override
  void initState() {
    super.initState();
    _randomizeList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      mainAxisAlignment: .start,
      children: <Widget>[
        const MainHeader(
          title: Text(
            "Metrícas",
            style: TextStyle(
              color: AppThemes.whitePremium,
              fontWeight: .bold,
              fontSize: 22,
            ),
          ),
        ),
        const SizedBox(height: 25),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: .horizontal,
            itemCount: ObjectsDataset.objects.length,
            itemExtent: size.width - 20,
            itemBuilder: (context, index) {
              return ComparisonCard(
                objectData: planetsInfo[index].toList(),
                planetData: planetsInfo[index],
              );
            },
          ),
        ),
        _MoveScrollButtons(moveScroll: _moveScroll, width: size.width),
      ],
    );
  }

  void _randomizeList() {
    while (planetsInfo.length < ObjectsDataset.objects.length) {
      int index = random.nextInt(ObjectsDataset.objects.length);

      if (!planetsInfo.contains(ObjectsDataset.objects[index])) {
        planetsInfo.add(ObjectsDataset.objects[index]);
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

typedef MoveFun = void Function({required double value});

class const _MoveScrollButtons({
  required final MoveFun moveScroll,
  required final double width,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: <Widget>[
        IconButtonOutlined(
          function: (_) => moveScroll(value: -(width - 20)), 
          height: 60,
          width: 80,
          icon: Icons.arrow_back
        ),
        IconButtonOutlined(
          function: (_) => moveScroll(value: width - 20), 
          height: 60,
          width: 80,
          icon: Icons.arrow_forward
        ),
      ],
    );
  }
}