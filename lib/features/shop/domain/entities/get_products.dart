class GetProducts {

  final List<Data> data;

  GetProducts._({
    required this.data,
  });

  factory GetProducts.create({
    required data,
  }) {
    // Add any validation or business logic here
    return GetProducts._(
      data: data,
    );
  }

}
class Data {

  final String name;
  final String description;
  final Price price;
  final int stockQuantity;
  final bool active;
  final Media media;
  final String id;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  Data._({
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

  factory Data.create({
    required name,
    required description,
    required price,
    required stockQuantity,
    required active,
    required media,
    required id,
    required createdBy,
    required updatedBy,
    required createdAt,
    required updatedAt,
  }) {
    // Add any validation or business logic here
    return Data._(
      name: name,
      description: description,
      price: price,
      stockQuantity: stockQuantity,
      active: active,
      media: media,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

}
class Price {

  final double amount;
  final String currency;

  Price._({
    required this.amount,
    required this.currency,
  });

  factory Price.create({
    required amount,
    required currency,
  }) {
    // Add any validation or business logic here
    return Price._(
      amount: amount,
      currency: currency,
    );
  }

}
class Media {

  final String type;
  final String source;
  final List<Items> items;
  final String? id;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;

  Media._({
    required this.type,
    required this.source,
    required this.items,
     this.id,
     this.createdBy,
     this.updatedBy,
     this.createdAt,
     this.updatedAt,
  });

  factory Media.create({
    required type,
    required source,
    required items,
    required id,
    required createdBy,
    required updatedBy,
    required createdAt,
    required updatedAt,
  }) {
    // Add any validation or business logic here
    return Media._(
      type: type,
      source: source,
      items: items,
      id: id,
      createdBy: createdBy,
      updatedBy: updatedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

}
class Items {

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

  Items._({
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

  factory Items.create({
    required sourceUrl,
    required capturedUrl,
    required type,
    required mediaId,
    required fileId,
    required fileUrl,
    required id,
    required createdBy,
    required updatedBy,
    required createdAt,
    required updatedAt,
  }) {
    // Add any validation or business logic here
    return Items._(
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
