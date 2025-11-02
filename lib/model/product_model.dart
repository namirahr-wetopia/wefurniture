import '../utils/date_parser.dart';

class ProductModel {
  final int id;
  final String title;
  final String? subtitle;
  final String? description;
  final double price;
  final int categoryIdFk;
  final double rating;
  final bool is_new;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.title,
    this.subtitle,
    this.description,
    required this.price,
    required this.categoryIdFk,
    required this.rating,
    required this.is_new,
    required this.createdAt,
    required this.updatedAt
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      categoryIdFk: json['category_id_fk'],
      rating: (json['rating'] as num).toDouble(),
      is_new: json['is_new'] == 1,
      createdAt: DateParser.parseToLocal(json['created_at']),
      updatedAt: DateParser.parseToLocal(json['updated_at'])
    );
  }
}
