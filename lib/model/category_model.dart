import '../utils/date_parser.dart';

class CategoryModel {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      createdAt: DateParser.parseToLocal(json['created_at']),
      updatedAt: DateParser.parseToLocal(json['updated_at'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': DateParser.toUtcIso(createdAt),
      'updated_at': DateParser.toUtcIso(updatedAt)
    };
  }
}
