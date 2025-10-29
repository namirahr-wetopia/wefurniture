class CartModel {
  final int id;
  final int productId;
  final String productTitle;
  final double productPrice;
  final int quantity;
  final String color;
  final String size;
  final DateTime createdAt;
  final DateTime updatedAt;

  CartModel({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.quantity,
    required this.color,
    required this.size,
    required this.createdAt,
    required this.updatedAt
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
      createdAt: map['created_at'],
      updatedAt: map['updated_at']
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
      'created_at': createdAt,
      'updated_at': updatedAt
    };
    return map;
  }
}
