import 'package:space_anywhere/shared/models/object_information.dart';
import 'package:space_anywhere/features/calculator/data/objects_gravity_dataset.dart';

class CalculatorService {
  static const defaultOptionText = "Escolha um objeto";
  final _planetsGravity = ObjectsGravityDataset.planetsGravity;
  String _text = defaultOptionText;
  double? _result = 0.0;
  int _index = 0;

  List<ObjectInformation> get planetsGravity =>
      List.unmodifiable(_planetsGravity);
  String get defaultText => _text;
  double? get result => _result;

  void defineNewText({required int index}) {
    _text = _planetsGravity[index].name;
    _index = index;
  }

  void setDefaultText() => _text = defaultOptionText;

  void initializeResult() => _result = 0.0;

  bool checkFields({required String text}) {
    return defaultText != defaultOptionText && text.isNotEmpty;
  }

  void calculate({required String weight}) {
    if (weight.contains(".") || weight.contains(",")) {
      weight = weight.replaceAll(".", "").replaceAll(",", "");
    } else {
      weight = (int.parse(weight) * 100).toString();
    }

    final checkWeight = double.tryParse(weight);

    if (checkWeight == null) {
      _result = null;
      return;
    }
    _result = (checkWeight * _planetsGravity[_index].gravityOverEarth!) / 100;
  }
}
