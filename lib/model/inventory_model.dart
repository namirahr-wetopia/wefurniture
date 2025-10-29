import '../utils/date_parser.dart';
import 'colour_model.dart';
import 'product_model.dart';

class InventoryModel {
  final int id;
  final int productIdFk;
  final int? colorIdFk;
  final int quantity;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  final ProductModel? product;
  final ColourModel? colour;

  InventoryModel({
    required this.id,
    required this.productIdFk,
    this.colorIdFk,
    required this.quantity,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.product,
    this.colour
  });

  factory InventoryModel.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic v) => v is String ? int.parse(v) : v as int;

    int? parseNullableInt(dynamic v) {
      if (v == null) return null;
      return v is String ? int.parse(v) : v as int;
    }

    ProductModel? product;
    if (json['product'] != null && json['product'] is Map<String, dynamic>) {
      product = ProductModel.fromJson(Map<String, dynamic>.from(json['product']));
    }

    ColourModel? colour;
    if (json['colour'] != null && json['colour'] is Map<String, dynamic>) {
      colour = ColourModel.fromJson(Map<String, dynamic>.from(json['colour']));
    }

    return InventoryModel(
      id: parseInt(json['id']),
      productIdFk: parseInt(json['product_id_fk']),
      colorIdFk: parseNullableInt(json['color_id_fk']),
      quantity: parseInt(json['quantity']),
      status: json['status'] as String,
      createdAt: DateParser.parseToLocal(json['created_at']),
      updatedAt: DateParser.parseToLocal(json['updated_at']),
      product: product,
      colour: colour
    );
  }
}
