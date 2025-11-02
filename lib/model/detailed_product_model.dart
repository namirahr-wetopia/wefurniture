import '../data/remote/api_config.dart';
import 'product_image_model.dart';
import 'package:flutter/material.dart';

class DetailedProductModel {
  final int id;
  final String title;
  final String? subtitle;
  final String? description;
  final double price;
  final String? category;
  final double rating;
  final bool isNew;
  final List<ProductImageModel>? images; 
  final List<String>? colorNames;

  DetailedProductModel({
    required this.id,
    required this.title,
    this.subtitle,
    this.description,
    required this.price,
    this.category,
    required this.rating,
    required this.isNew,
    this.images,
    this.colorNames,
  });

  factory DetailedProductModel.fromJson(Map<String, dynamic> json) {
    print('Parsing JSON: $json'); // Log the entire JSON object

    // parse images
    List<ProductImageModel>? images;
    if (json['images'] != null && json['images'] is List) {
      images = (json['images'] as List).map((imageJson) {
        int id = 0;
        final storageUrl = '${ApiConfig.getBaseUrl()}/storage/v1/object/public/';
        final suffixUrl = imageJson['image_url']?.toString() ?? '';
        final fullUrl = suffixUrl.isNotEmpty ? '$storageUrl$suffixUrl' : '';
        print('Parsing image JSON: $imageJson, fullUrl: $fullUrl'); // Log each image JSON and full URL
        return ProductImageModel(
          id: id+1,
          productIdFk: json['id'] != null ? (json['id'] as num).toInt() : 0,
          imageUrl: fullUrl,
          isPrimary: imageJson['is_primary'] as bool? ?? false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now()
        );
      }).toList();
    }

    // parse colour names
    List<String>? colorNames;
    if (json['colour_names'] != null && json['colour_names'] is List) {
      colorNames = List<String>.from(json['colour_names']);
    }

    // Log each field being parsed
    final id = json['id'] != null ? (json['id'] as num).toInt() : 0;
    final title = json['title']?.toString() ?? '';
    final subtitle = json['subtitle']?.toString();
    final description = json['description']?.toString();
    final price = (json['price'] as num?)?.toDouble() ?? 0.0;
    final category = json['category']?.toString();
    final rating = (json['rating'] as num?)?.toDouble() ?? 0.0;
    final isNew = json['is_new'] as bool? ?? false;

    print('Parsed values: id=$id, title=$title, price=$price, rating=$rating'); // Log parsed values

    return DetailedProductModel(
      id: id,
      title: title,
      subtitle: subtitle,
      description: description,
      price: price,
      category: category,
      rating: rating,
      isNew: isNew,
      images: images,
      colorNames: colorNames,
    );
  }
}