import 'package:jappcare/features/workshop/domain/entities/service_center_service.entity.dart';

import '../../../../core/ui/domain/entities/pagination.entity.dart';

class GetAllServiceCenterServicesEntity {
  final List<ServiceCenterServiceEntity> data;
  final Pagination pagination;

  GetAllServiceCenterServicesEntity._({
    required this.data,
    required this.pagination,
  });

  factory GetAllServiceCenterServicesEntity.create({
    required data,
    required pagination,
  }) {
    // Add any validation or business logic here
    return GetAllServiceCenterServicesEntity._(
      data: data,
      pagination: pagination,
    );
  }
}
