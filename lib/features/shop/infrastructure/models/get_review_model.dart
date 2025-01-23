import '../../domain/entities/get_review.dart';

class GetReviewModel {

  final String productId;
  final int rating;
  final String comment;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  GetReviewModel._({
    required this.productId,
    required this.rating,
    required this.comment,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetReviewModel.fromJson(Map<String, dynamic> json) {
    return GetReviewModel._(
      productId: json['productId'],
      rating: json['rating'],
      comment: json['comment'],
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['rating'] = rating;
    data['comment'] = comment;
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory GetReviewModel.fromEntity(GetReview entity) {
    return GetReviewModel._(
      productId: entity.productId,
      rating: entity.rating,
      comment: entity.comment,
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  GetReview toEntity() {
    return GetReview.create(
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
