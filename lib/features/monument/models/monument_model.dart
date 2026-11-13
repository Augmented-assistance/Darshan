class MonumentModel {
  final String id;
  final String name;
  final String nepaliName;
  final String zone;
  final String description;
  final String history;
  final String architecturalStyle;
  final String builtCentury;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final double distanceKm;

  const MonumentModel({
    required this.id,
    required this.name,
    required this.nepaliName,
    required this.zone,
    required this.description,
    required this.history,
    required this.architecturalStyle,
    required this.builtCentury,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.distanceKm,
  });
}
