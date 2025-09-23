class PlacePredictionEntity {
  final String description;
  final String placeId;

  PlacePredictionEntity._({
    required this.description,
    required this.placeId,
  });

  factory PlacePredictionEntity.create({
    required String description,
    required String placeId,
  }) {
    return PlacePredictionEntity._(
      description: description,
      placeId: placeId,
    );
  }

  factory PlacePredictionEntity.fromJson(Map<String, dynamic> json) {
    return PlacePredictionEntity.create(
      description: json['description'],
      placeId: json['place_id'],
    );
  }
}
