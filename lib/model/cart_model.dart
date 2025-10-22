import '../utils/date_parser.dart';

class CartModel {
  final int id;
  final int productId;
  final String productTitle;
  final double productPrice;
  final int quantity;
  final String color;
  final String size;

  CartModel({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.quantity,
    required this.color,
    required this.size,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'],
      productId: map['product_id'],
      productTitle: map['product_title'],
      productPrice: (map['product_price'] as num).toDouble(),
      quantity: map['quantity'],
      color: map['color'],
      size: map['size'],
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'product_id': productId,
      'product_name': productTitle,
      'product_price': productPrice,
      'quantity': quantity,
      'color': color,
      'size': size,
    };
    return map;
  }
}
