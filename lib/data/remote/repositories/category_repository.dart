import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../api_config.dart';
import '../../../model/category_model.dart';

class CategoryRepository {
  static Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      final url = Uri.parse('${ApiConfig.getBaseUrl()}/rest/v1/rpc/get_all_categories');
      print('Requesting all categories: $url');

      final response = await http.post(
        url,
        headers: ApiConfig.getHeaders(),
      ).timeout(const Duration(seconds: 60));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => CategoryModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch categories: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      throw Exception('Network error: $e');
    } on TimeoutException catch (e) {
      throw Exception('Timeout error: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
