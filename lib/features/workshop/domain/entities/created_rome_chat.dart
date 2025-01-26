class CreatedRomeChat {

  final String name;
  final List<String> participantIds;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  CreatedRomeChat._({
    required this.name,
    required this.participantIds,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreatedRomeChat.create({
    required name,
    required participantIds,
    required id,
    required createdBy,
    required updatedBy,
    required createdAt,
    required updatedAt,
  }) {
    // Add any validation or business logic here
    return CreatedRomeChat._(
      name: name,
      participantIds: participantIds,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

}
