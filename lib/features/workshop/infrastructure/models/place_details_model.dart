import 'package:jappcare/features/workshop/domain/entities/place_details.dart';

class PlaceDetailsModel {
  final String name;
  final double lat, lng;

  PlaceDetailsModel._({
    required this.name,
    required this.lat,
    required this.lng,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> j) =>
      PlaceDetailsModel._(
        name: j['formatted_address'],
        lat: j['geometry']['location']['lat'],
        lng: j['geometry']['location']['lng'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }

  factory PlaceDetailsModel.fromEntity(PlaceDetails entity) {
    return PlaceDetailsModel._(
      name: entity.name,
      lat: entity.lat,
      lng: entity.lng,
    );
  }

  PlaceDetails toEntity() {
    return PlaceDetails.create(
      name: name,
      lat: lat,
      lng: lng,
    );
  }
}
