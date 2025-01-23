class GetReview {

  final String productId;
  final int rating;
  final String comment;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  GetReview._({
    required this.productId,
    required this.rating,
    required this.comment,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetReview.create({
    required productId,
    required rating,
    required comment,
    required id,
    required createdBy,
    required updatedBy,
    required createdAt,
    required updatedAt,
  }) {
    // Add any validation or business logic here
    return GetReview._(
      productId: productId,
      rating: rating,
      comment: comment,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

}
