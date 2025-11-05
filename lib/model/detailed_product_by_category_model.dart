import '../data/remote/api_config.dart';
import 'colour_inventory_model';
import 'product_image_model.dart';

class DetailedProductByCategoryModel {
  final int id;
  final String title;
  final String? subtitle;
  final String? description;
  final double price;
  final String? category;
  final double rating;
  final bool isNew;
  final List<ProductImageModel>? images;
  final List<ColourInventoryModel>? colourInventories;

  DetailedProductByCategoryModel({
    required this.id,
    required this.title,
    this.subtitle,
    this.description,
    required this.price,
    this.category,
    required this.rating,
    required this.isNew,
    this.images,
    this.colourInventories,
  });

  factory DetailedProductByCategoryModel.fromJson(Map<String, dynamic> json) {
    
    List<ProductImageModel>? images;
    if (json['images'] != null && json['images'] is List) {
      images = (json['images'] as List).map((imageJson) {
        final storageUrl = '${ApiConfig.getBaseUrl()}/storage/v1/object/public/';
        final suffixUrl = imageJson['image_url']?.toString() ?? '';
        final fullUrl = suffixUrl.isNotEmpty ? '$storageUrl$suffixUrl' : '';
        return ProductImageModel(
          id: 0,
          productIdFk: (json['id'] as num?)?.toInt() ?? 0,
          imageUrl: fullUrl,
          isPrimary: imageJson['is_primary'] as bool? ?? false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
      }).toList();
    }

    List<ColourInventoryModel>? colourInventories;
    if (json['colour_inventories'] != null && json['colour_inventories'] is List) {
      colourInventories = (json['colour_inventories'] as List)
          .map((item) => ColourInventoryModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }

    return DetailedProductByCategoryModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString(),
      description: json['description']?.toString(),
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      category: json['category']?.toString(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      isNew: json['is_new'] as bool? ?? false,
      images: images,
      colourInventories: colourInventories,
    );
  }
}
