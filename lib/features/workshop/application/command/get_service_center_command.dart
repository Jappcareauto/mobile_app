class GetServiceCenterCommand {
  final String? name;
  final String? category;
  final String? ownerId;
  final String? serviceCenterId;
  final bool? aroundMe;
  final bool? availableNow;
  GetServiceCenterCommand(
      {this.name,
      this.category,
      this.ownerId,
      this.serviceCenterId,
      this.aroundMe,
      this.availableNow});
}
