import 'package:jappcare/core/ui/domain/entities/pagination.entity.dart';

class PaginationModel {
  final int page;
  final int size;
  final int totalItems;
  final int totalPages;

  PaginationModel._({
    required this.page,
    required this.size,
    required this.totalItems,
    required this.totalPages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel._(
      page: json['page'],
      size: json['size'],
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['size'] = size;
    data['totalItems'] = totalItems;
    data['totalPages'] = totalPages;
    return data;
  }

  factory PaginationModel.fromEntity(Pagination entity) {
    return PaginationModel._(
      page: entity.page,
      size: entity.size,
      totalItems: entity.totalItems,
      totalPages: entity.totalPages,
    );
  }

  Pagination toEntity() {
    return Pagination.create(
      page: page,
      size: size,
      totalItems: totalItems,
      totalPages: totalPages,
    );
  }
}
