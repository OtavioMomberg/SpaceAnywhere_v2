final class const ObjectInformation({
  required final String name,
  required final String diameter,
  required final String mass,
  required final String earthDistance,
  required final String objectType,
  required final String imagePath,
  final double? gravityOverEarth
}) {
  factory planetGravity({
    required String name, 
    required double gravityOverEarth
  }) {
    return ObjectInformation(
      name: name, 
      diameter: "", 
      mass: "", 
      earthDistance: "", 
      objectType: "", 
      imagePath: "",
      gravityOverEarth: gravityOverEarth
    );
  }

  List<String> toList() {
    return [diameter, mass, earthDistance, objectType];
  }

  static const topics = [
    "Diâmetro:",
    "Massa:",
    "Distância para a Terra:",
    "Tipo de objeto:",
  ];
}
