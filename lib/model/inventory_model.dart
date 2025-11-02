import '../utils/date_parser.dart';

class InventoryModel {
  final int id;
  final int productIdFk;
  final int? colorIdFk;
  final int quantity;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  InventoryModel({
    required this.id,
    required this.productIdFk,
    this.colorIdFk,
    required this.quantity,
    required this.status,
    required this.createdAt,
    required this.updatedAt
  });

  factory InventoryModel.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic v) => v is String ? int.parse(v) : v as int;

    int? parseNullableInt(dynamic v) {
      if (v == null) return null;
      return v is String ? int.parse(v) : v as int;
    }
    return InventoryModel(
      id: parseInt(json['id']),
      productIdFk: parseInt(json['product_id_fk']),
      colorIdFk: parseNullableInt(json['color_id_fk']),
      quantity: parseInt(json['quantity']),
      status: json['status'] as String,
      createdAt: DateParser.parseToLocal(json['created_at']),
      updatedAt: DateParser.parseToLocal(json['updated_at'])
    );
  }
}
