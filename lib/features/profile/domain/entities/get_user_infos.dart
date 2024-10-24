class GetUserInfos {

  final String name;
  final String email;
  final String? image;
  final bool verified;
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;

  GetUserInfos._({
    required this.name,
    required this.email,
    this.image,
    required this.verified,
    required this.id,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory GetUserInfos.create({
    required name,
    required email,
    image,
    required verified,
    required id,
    createdBy,
    updatedBy,
    createdAt,
    updatedAt,
  }) {
    // Add any validation or business logic here
    return GetUserInfos._(
      name: name,
      email: email,
      image: image,
      verified: verified,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

}
