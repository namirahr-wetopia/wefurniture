import '../utils/date_parser.dart';
class CartModel {
  final int? id;
  final int productId;
  final String productTitle;
  final double productPrice;
  final int quantity;
  final String color;
  final String size;
  final DateTime createdAt;
  final DateTime updatedAt;

  CartModel({
    this.id,
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.quantity,
    required this.color,
    required this.size,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] != null ? (map['id'] as num).toInt() : null,
      productId: (map['product_id'] as num).toInt(),
      productTitle: map['product_title'] as String,
      productPrice: (map['product_price'] as num).toDouble(),
      quantity: (map['quantity'] as num).toInt(),
      color: map['color'] as String? ?? '',
      size: map['size'] as String? ?? '',
      createdAt: map['created_at'] is String
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
      updatedAt: map['updated_at'] is String
          ? DateTime.parse(map['updated_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'product_id': productId,
      'product_title': productTitle,
      'product_price': productPrice,
      'quantity': quantity,
      'color': color,
      'size': size,
      'created_at': DateParser.toUtcIso(createdAt),
      'updated_at': DateParser.toUtcIso(updatedAt),
    };

    if (id != null) map['id'] = id;
    return map;
  }

  CartModel copyWith({
    int? id,
    int? productId,
    String? productTitle,
    double? productPrice,
    int? quantity,
    String? color,
    String? size,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CartModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productTitle: productTitle ?? this.productTitle,
      productPrice: productPrice ?? this.productPrice,
      quantity: quantity ?? this.quantity,
      color: color ?? this.color,
      size: size ?? this.size,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
