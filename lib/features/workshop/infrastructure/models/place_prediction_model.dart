import 'package:jappcare/features/workshop/domain/entities/place_prediction.dart';

class PlacePredictionModel {
  final String description;
  final String placeId;

  PlacePredictionModel._({
    required this.description,
    required this.placeId,
  });

  factory PlacePredictionModel.fromJson(Map<String, dynamic> j) =>
      PlacePredictionModel._(
        description: j['description'],
        placeId: j['place_id'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['placeId'] = placeId;
    return data;
  }

  factory PlacePredictionModel.fromEntity(PlacePrediction entity) {
    return PlacePredictionModel._(
      description: entity.description,
      placeId: entity.placeId,
    );
  }

  PlacePrediction toEntity() {
    return PlacePrediction.create(
      description: description,
      placeId: placeId,
    );
  }
}
