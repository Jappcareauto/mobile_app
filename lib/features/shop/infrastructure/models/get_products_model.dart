import '../../domain/entities/get_products.dart';

class GetProductsModel {

  final List<DataModel> data;

  GetProductsModel._({
    required this.data,
  });

  factory GetProductsModel.fromJson(Map<String, dynamic> json) {
    return GetProductsModel._(
      data: List<DataModel>.from(json['data'].map((x) => DataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['data'] = data.map((x) => x.toJson()).toList();
    return json;
  }

  factory GetProductsModel.fromEntity(GetProducts entity) {
    return GetProductsModel._(
      data: List<DataModel>.from(entity.data.map((x) => DataModel.fromEntity(x))),
    );
  }

  GetProducts toEntity() {
    return GetProducts.create(
      data: data.map((x) => x.toEntity()).toList(),
    );
  }
}
class DataModel {

  final String name;
  final String description;
  final PriceModel price;
  final int stockQuantity;
  final bool active;
  final MediaModel media;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  DataModel._({
    required this.name,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.active,
    required this.media,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel._(
      name: json['name'],
      description: json['description'],
      price: PriceModel.fromJson(json['price']),
      stockQuantity: json['stockQuantity'],
      active: json['active'],
      media: MediaModel.fromJson(json['media']),
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['price'] = price.toJson();
    data['stockQuantity'] = stockQuantity;
    data['active'] = active;
    data['media'] = media.toJson();
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory DataModel.fromEntity(Data entity) {
    return DataModel._(
      name: entity.name,
      description: entity.description,
      price: PriceModel.fromEntity(entity.price),
      stockQuantity: entity.stockQuantity,
      active: entity.active,
      media: MediaModel.fromEntity(entity.media),
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Data toEntity() {
    return Data.create(
      name: name,
      description: description,
      price: price.toEntity(),
      stockQuantity: stockQuantity,
      active: active,
      media: media.toEntity(),
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
class PriceModel {

  final int amount;
  final String currency;

  PriceModel._({
    required this.amount,
    required this.currency,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel._(
      amount: json['amount'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['currency'] = currency;
    return data;
  }

  factory PriceModel.fromEntity(Price entity) {
    return PriceModel._(
      amount: entity.amount,
      currency: entity.currency,
    );
  }

  Price toEntity() {
    return Price.create(
      amount: amount,
      currency: currency,
    );
  }
}
class MediaModel {

  final String type;
  final String source;
  final List<ItemsModel> items;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  MediaModel._({
    required this.type,
    required this.source,
    required this.items,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel._(
      type: json['type'],
      source: json['source'],
      items: List<ItemsModel>.from(json['items'].map((x) => ItemsModel.fromJson(x))),
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['source'] = source;
    data['items'] = items.map((x) => x.toJson()).toList();
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory MediaModel.fromEntity(Media entity) {
    return MediaModel._(
      type: entity.type,
      source: entity.source,
      items: List<ItemsModel>.from(entity.items.map((x) => ItemsModel.fromEntity(x))),
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Media toEntity() {
    return Media.create(
      type: type,
      source: source,
      items: items.map((x) => x.toEntity()).toList(),
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
class ItemsModel {

  final String sourceUrl;
  final String capturedUrl;
  final String type;
  final String mediaId;
  final String fileId;
  final String fileUrl;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  ItemsModel._({
    required this.sourceUrl,
    required this.capturedUrl,
    required this.type,
    required this.mediaId,
    required this.fileId,
    required this.fileUrl,
    required this.id,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    return ItemsModel._(
      sourceUrl: json['sourceUrl'],
      capturedUrl: json['capturedUrl'],
      type: json['type'],
      mediaId: json['mediaId'],
      fileId: json['fileId'],
      fileUrl: json['fileUrl'],
      id: json['id'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sourceUrl'] = sourceUrl;
    data['capturedUrl'] = capturedUrl;
    data['type'] = type;
    data['mediaId'] = mediaId;
    data['fileId'] = fileId;
    data['fileUrl'] = fileUrl;
    data['id'] = id;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  factory ItemsModel.fromEntity(Items entity) {
    return ItemsModel._(
      sourceUrl: entity.sourceUrl,
      capturedUrl: entity.capturedUrl,
      type: entity.type,
      mediaId: entity.mediaId,
      fileId: entity.fileId,
      fileUrl: entity.fileUrl,
      id: entity.id,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Items toEntity() {
    return Items.create(
      sourceUrl: sourceUrl,
      capturedUrl: capturedUrl,
      type: type,
      mediaId: mediaId,
      fileId: fileId,
      fileUrl: fileUrl,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
