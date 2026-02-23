class LocationModel {
  final double latitude;
  final double longitude;
  final String description;
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.id,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      id: json['id'],
      createdBy: json['createdBy'] is String
          ? json['createdBy']
          : json['createdBy']?.toString(),
      updatedBy: json['updatedBy'] is String
          ? json['updatedBy']
          : json['updatedBy']?.toString(),
      createdAt: json['createdAt'] is String
          ? json['createdAt']
          : json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt'] is String
          ? json['updatedAt']
          : json['updatedAt']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'id': id,
      if (createdBy != null) 'createdBy': createdBy,
      if (updatedBy != null) 'updatedBy': updatedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
