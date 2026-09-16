import 'package:space_anywhere/shared/models/object_information.dart';
import 'package:space_anywhere/features/calculator/data/objects_gravity_dataset.dart';

class CalculatorService {
  static const defaultOptionText = "Escolha um objeto";
  final _planetsGravity = PlanetsGravity.planetsGravityData;
  String _objectName = defaultOptionText;
  double? _result = 0.0;
  int _index = 0;

  List<ObjectInformation> get planetsGravity =>
      List.unmodifiable(_planetsGravity);
  String get objectName => _objectName;
  double? get result => _result;

  void changeObjectName({required int index}) {
    _objectName = _planetsGravity[index].name;
    _index = index;
  }

  void setDefaultText() => _objectName = defaultOptionText;

  void initializeResult() => _result = 0.0;

  bool checkFields({required String weight}) {
    return objectName != defaultOptionText && weight.isNotEmpty;
  }

  void calculate({required String weight}) {
    _result = null;

    if (weight.isEmpty) { return; }
    if (weight[0] == "0" || weight[0] == "." || weight[0] == ",") { return; }

    switch (weight.contains(".") || weight.contains(",")) {
      case true:
        weight = weight.replaceAll(".", "").replaceAll(",", "");
        break;
      case false:
        final weightInt = int.tryParse(weight) ?? 0; 
        weight = (weightInt * 100).toString();
        if (weight == "0") { return; }
        break;
    }

    final weightParsed = double.tryParse(weight);
    if (weightParsed == null) { return; }

    _result = (weightParsed < 0) 
      ? (weightParsed * _planetsGravity[_index].gravityOverEarth!) / 100 * -1
      : (weightParsed * _planetsGravity[_index].gravityOverEarth!) / 100;
  }
}
