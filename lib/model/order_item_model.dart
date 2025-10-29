import 'dart:convert';
import '../utils/date_parser.dart';

class OrderItemModel {
  final String id;
  final String orderId;
  final String inventoryIdFk;
  final int quantity;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderItemModel({
    required this.id,
    required this.orderId,
    required this.inventoryIdFk,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] as String,
      orderId: json['order_id'] as String,
      inventoryIdFk: json['inventory_id_fk'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      createdAt: DateParser.parseToLocal(json['created_at']),
      updatedAt: DateParser.parseToLocal(json['updated_at'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'inventory_id_fk': inventoryIdFk,
      'quantity': quantity,
      'price': price,
      'created_at': DateParser.toUtcIso(createdAt),
      'updated_at': DateParser.toUtcIso(updatedAt)
    };
  }
}
