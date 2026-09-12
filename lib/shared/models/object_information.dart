class ObjectInformation {
  final String name;
  final String diameter;
  final String mass;
  final String earthDistance;
  final String objectType;
  final String imagePath;
  final double? gravityOverEarth;

  const new({
    required this.name,
    required this.diameter,
    required this.mass,
    required this.earthDistance,
    required this.objectType,
    required this.imagePath,
  }) : gravityOverEarth = null;

  const new calculate({
    required this.name,
    required this.gravityOverEarth,
  }) : diameter = "",
       mass = "",
       earthDistance = "",
       objectType = "",
       imagePath = "";

  List<String> toList() {
    return [diameter, mass, earthDistance, objectType];
  }

  static const topics = [
    "Diâmetro:",
    "Massa:",
    "Distância para a Terra:",
    "Tipo de objeto:"
  ];
}
