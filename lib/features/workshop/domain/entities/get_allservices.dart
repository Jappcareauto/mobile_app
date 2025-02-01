class GetAllservices {

  final List<Data> data;
  final Pagination pagination;

  GetAllservices._({
    required this.data,
    required this.pagination,
  });

  factory GetAllservices.create({
    required data,
    required pagination,
  }) {
    // Add any validation or business logic here
    return GetAllservices._(
      data: data,
      pagination: pagination,
    );
  }

}
class Data {

  final String title;
  final String? description;
  final String serviceCenterId;
  final String definition;
  final String id;
  final String? createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;

  Data._({
    required this.title,
     this.description,
    required this.serviceCenterId,
    required this.definition,
    required this.id,
     this.createdBy,
     this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.create({
    required title,
    required description,
    required serviceCenterId,
    required definition,
    required id,
    required createdBy,
    required updatedBy,
    required createdAt,
    required updatedAt,
  }) {
    // Add any validation or business logic here
    return Data._(
      title: title,
      description: description,
      serviceCenterId: serviceCenterId,
      definition: definition,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

}
class Pagination {

  final int page;
  final int size;
  final int totalItems;
  final int totalPages;

  Pagination._({
    required this.page,
    required this.size,
    required this.totalItems,
    required this.totalPages,
  });

  factory Pagination.create({
    required page,
    required size,
    required totalItems,
    required totalPages,
  }) {
    // Add any validation or business logic here
    return Pagination._(
      page: page,
      size: size,
      totalItems: totalItems,
      totalPages: totalPages,
    );
  }

}
