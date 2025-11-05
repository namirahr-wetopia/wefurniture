import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../model/detailed_product_by_category_model.dart';
import '../api_config.dart';

class DetailedProductByCategoryRepository {
  static Future<List<DetailedProductByCategoryModel>> fetchDetailedProductsByCategory({
    required String categoryName, 
  }) async {
    try {
      final url = Uri.parse('${ApiConfig.getBaseUrl()}/rest/v1/rpc/get_detailed_products_by_category');
      print('Attempting request to: $url with category: $categoryName');

      final Map<String, dynamic> body = {
        'p_category_name': categoryName,
      };

      final response = await http.post(
        url,
        headers: ApiConfig.getHeaders(),
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 180));

      print('Response status: ${response.statusCode}');
      print('RPC body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('Parsed JSON data length: ${data.length}');

        return data.map((item) {
          print('Processing item: $item');
          try {
            return DetailedProductByCategoryModel.fromJson(Map<String, dynamic>.from(item));
          } catch (e, st) {
            print('Failed to parse item: $e\n$st');
            rethrow;
          }
        }).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode} ${response.body}');
      }
    } on SocketException catch (e) {
      throw Exception('Network error: $e');
    } on TimeoutException catch (e) {
      throw Exception('Request timed out: $e');
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
