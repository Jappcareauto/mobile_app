class PlacePrediction {
  final String description;
  final String placeId;
  PlacePrediction._({required this.description, required this.placeId});

  factory PlacePrediction.create({
    required description,
    required placeId,
  }) {
    // Add any validation or business logic here
    return PlacePrediction._(
      description: description,
      placeId: placeId,
    );
  }
}
