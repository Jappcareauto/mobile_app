import 'package:jappcare/core/ui/domain/entities/pagination.entity.dart';
// import 'package:jappcare/features/workshop/domain/entities/get_vehicule_by_id.dart';

class GetAllTips {
  final List<TipEntity> data;
  final Pagination pagination;

  GetAllTips._({
    required this.data,
    required this.pagination,
  });

  factory GetAllTips.create({
    required data,
    required pagination,
  }) {
    // Add any validation or business logic here
    return GetAllTips._(
      data: data,
      pagination: pagination,
    );
  }
}

class TipEntity {
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;
  final String title;
  final String description;

  TipEntity._(
      {required this.id,
      required this.createdBy,
      required this.updatedBy,
      required this.createdAt,
      required this.updatedAt,
      required this.title,
      required this.description});

  factory TipEntity.create(
      {required String id,
      required String createdBy,
      required String updatedBy,
      required String createdAt,
      required String updatedAt,
      required String title,
      required String description}) {
    // Add any validation or business logic here
    return TipEntity._(
        id: id,
        createdBy: createdBy,
        updatedBy: updatedBy,
        createdAt: createdAt,
        updatedAt: updatedAt,
        title: title,
        description: description
        );
  }
}
