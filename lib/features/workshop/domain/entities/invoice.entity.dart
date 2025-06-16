import 'package:jappcare/features/workshop/domain/entities/service_center_service.entity.dart';

import '../../../../core/ui/domain/entities/pagination.entity.dart';

class InvoiceEntity {
  final List<ServiceCenterServiceEntity> data;
  final Pagination pagination;

  InvoiceEntity._({
    required this.data,
    required this.pagination,
  });

  factory InvoiceEntity.create({
    required data,
    required pagination,
  }) {
    // Add any validation or business logic here
    return InvoiceEntity._(
      data: data,
      pagination: pagination,
    );
  }
}
