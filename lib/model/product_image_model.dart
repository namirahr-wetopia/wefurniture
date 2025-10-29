import '../utils/date_parser.dart';
class ProductImageModel {
  final int id;
  final String imageUrl;
  final bool isPrimary;
  final int productIdFk;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductImageModel({
    required this.id,
    required this.imageUrl,
    required this.isPrimary,
    required this.productIdFk,
    required this.createdAt,
    required this.updatedAt
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic v) => v is String ? int.parse(v) : v as int;
    return ProductImageModel(
      id: parseInt(json['id']),
      imageUrl: json['image_url'] as String,
      isPrimary: json['is_primary'] as bool,
      productIdFk: parseInt(json['product_id_fk']),
      createdAt: DateParser.parseToLocal(json['created_at']),
      updatedAt: DateParser.parseToLocal(json['updated_at'])
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image_url': imageUrl,
        'is_primary': isPrimary,
        'product_id_fk': productIdFk,
        'created_at': DateParser.toUtcIso(createdAt),
        'updated_at': DateParser.toUtcIso(updatedAt)
      };
}
