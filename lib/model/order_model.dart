import 'dart:convert';
import '../utils/date_parser.dart';

class OrderModel {
  final int id;
  final String userIdFk;
  final String address;
  final String phoneNo;
  final double price;
  final double deliveryCharge;
  final double totalCharge;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderModel({
    required this.id,
    required this.userIdFk,
    required this.address,
    required this.phoneNo,
    required this.price,
    required this.deliveryCharge,
    required this.totalCharge,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int,
      userIdFk: json['user_id_fk'] as String,
      address: json['address'] as String,
      phoneNo: json['phone_no'] as String,
      price: (json['price'] as num).toDouble(),
      deliveryCharge: (json['delivery_charge'] as num).toDouble(),
      totalCharge:(json['total_charge']as num).toDouble(),
      status: json['status'] as String,
      createdAt: DateParser.parseToLocal(json['created_at']),
      updatedAt: DateParser.parseToLocal(json['updated_at'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id_fk': userIdFk,
      'address': address,
      'phone_no': phoneNo,
      'price': price,
      'delivery_charge': deliveryCharge,
      'total_charge': totalCharge,
      'status': status,
      'created_at': DateParser.toUtcIso(createdAt),
      'updated_at': DateParser.toUtcIso(updatedAt)
    };
  }
}
