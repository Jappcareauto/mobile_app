class GeocodePosition {
  final List<AddressComponent> addressComponents;
  final String formattedAddress;
  final GeocodeGeometry geometry;
  final String placeId;
  final PlusCode? plusCode;
  final List<String> types;

  GeocodePosition._({
    required this.addressComponents,
    required this.formattedAddress,
    required this.geometry,
    required this.placeId,
    this.plusCode,
    required this.types,
  });

  factory GeocodePosition.create({
    required List<AddressComponent> addressComponents,
    required String formattedAddress,
    required GeocodeGeometry geometry,
    required String placeId,
    PlusCode? plusCode,
    required List<String> types,
  }) {
    // Add any validation or business logic here
    return GeocodePosition._(
      addressComponents: addressComponents,
      formattedAddress: formattedAddress,
      geometry: geometry,
      placeId: placeId,
      plusCode: plusCode,
      types: types,
    );
  }

  factory GeocodePosition.fromJson(Map<String, dynamic> json) {
    var addressComponentsList = json['address_components'] as List;
    List<AddressComponent> addressComponents = addressComponentsList
        .map((i) => AddressComponent.fromJson(i as Map<String, dynamic>))
        .toList();

    return  GeocodePosition._(
      addressComponents: addressComponents,
      formattedAddress: json['formatted_address'] as String,
      geometry: GeocodeGeometry.fromJson(json['geometry'] as Map<String, dynamic>),
      placeId: json['place_id'] as String,
      plusCode: json['plus_code'] != null ? PlusCode.fromJson(json['plus_code'] as Map<String, dynamic>) : null,
      types: List<String>.from(json['types'] as List),
    );
  }
}

// Helper classes for nested objects

class AddressComponent {
  final String longName;
  final String shortName;
  final List<String> types;

  AddressComponent._({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  factory AddressComponent.create({
    required String longName,
    required String shortName,
    required List<String> types,
  }) {
    // Add any validation or business logic here
    return AddressComponent._(
      longName: longName,
      shortName: shortName,
      types: types,
    );
  }

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    return AddressComponent.create(
      longName: json['long_name'] as String,
      shortName: json['short_name'] as String,
      types: List<String>.from(json['types'] as List),
    );
  }
}

class GeocodeGeometry {
  final Map<String, dynamic> location;
  final String locationType;
  final Map<String, dynamic> viewport;

  GeocodeGeometry._({
    required this.location,
    required this.locationType,
    required this.viewport,
  });

  factory GeocodeGeometry.create({
    required Map<String, dynamic> location,
    required String locationType,
    required Map<String, dynamic> viewport,
  }) {
    // Add any validation or business logic here
    return GeocodeGeometry._(
      location: location,
      locationType: locationType,
      viewport: viewport,
    );
  }

  factory GeocodeGeometry.fromJson(Map<String, dynamic> json) {
    return GeocodeGeometry.create(
      location: json['location'] as Map<String, dynamic>,
      locationType: json['location_type'] as String,
      viewport: json['viewport'] as Map<String, dynamic>,
    );
  }
}

class PlusCode {
  final String compoundCode;
  final String globalCode;

  PlusCode._({
    required this.compoundCode,
    required this.globalCode,
  });

  factory PlusCode.create({
    required String compoundCode,
    required String globalCode,
  }) {
    // Add any validation or business logic here
    return PlusCode._(
      compoundCode: compoundCode,
      globalCode: globalCode,
    );
  }

  factory PlusCode.fromJson(Map<String, dynamic> json) {
    return PlusCode.create(
      compoundCode: json['compound_code'] as String,
      globalCode: json['global_code'] as String,
    );
  }
}
