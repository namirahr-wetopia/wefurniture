import 'dart:convert';
import '../utils/date_parser.dart';

class OrderItem {
  final String id;
  final String orderId;
  final String inventoryId;
  final int quantity;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.inventoryId,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] as String,
      orderId: json['order_id'] as String,
      inventoryId: json['inventory_id'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'inventory_id': inventoryId,
      'quantity': quantity,
      'price': price,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String()
    };
  }

  static List<OrderItem> listFromJson(String jsonStr) {
    final List<dynamic> data = json.decode(jsonStr);
    return data.map((e) => OrderItem.fromJson(e)).toList();
  }
}
