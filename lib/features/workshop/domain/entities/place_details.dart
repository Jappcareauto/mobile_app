class PlaceDetails {
  final String name;
  final double lat, lng;
  PlaceDetails._({required this.name, required this.lat, required this.lng});

  factory PlaceDetails.create({
    required String name,
    required double lat,
    required double lng,
  }) {
    // Add any validation or business logic here
    return PlaceDetails._(
      name: name,
      lat: lat,
      lng: lng,
    );
  }
}
