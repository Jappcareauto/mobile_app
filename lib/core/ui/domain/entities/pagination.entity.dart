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
