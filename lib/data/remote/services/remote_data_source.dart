import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../model/inventory_model.dart';
import '../../../model/user_model.dart';
import '../../../model/product_model.dart';
import '../../../model/category_model.dart';
import '../../../model/order_model.dart';
import '../../../model/order_item_model.dart';
import '../api_config.dart';

class RemoteDataSource {
  // ---------------------- USERS ----------------------
  static Future<List<UserModel>> fetchUsers() async {
    final url = Uri.parse('${ApiConfig.getBaseUrl()}/users?select=*');
    final response = await http.get(url, headers: ApiConfig.headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users: ${response.body}');
    }
  }

  // ---------------------- PRODUCTS ----------------------
  static Future<List<InventoryModel>> fetchInventory() async {
    final url = Uri.parse('${ApiConfig.getBaseUrl()}/inventory?select=*');
    final response = await http.get(url, headers: ApiConfig.headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => InventoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products: ${response.body}');
    }
  }

  // ---------------------- CATEGORIES ----------------------
  static Future<List<CategoryModel>> fetchCategories() async {
    final url = Uri.parse('${ApiConfig.getBaseUrl()}/categories?select=*');
    final response = await http.get(url, headers: ApiConfig.headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories: ${response.body}');
    }
  }

  // ---------------------- ORDERS ----------------------
  static Future<List<OrderModel>> fetchOrders() async {
    final url = Uri.parse('${ApiConfig.getBaseUrl()}/orders?select=*');
    final response = await http.get(url, headers: ApiConfig.headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => OrderModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders: ${response.body}');
    }
  }

  static Future<OrderModel> createOrder(Map<String, dynamic> orderData) async {
    final url = Uri.parse('${ApiConfig.getBaseUrl()}/orders');
    final response = await http.post(
      url,
      headers: ApiConfig.headers,
      body: json.encode(orderData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)[0];
      return OrderModel.fromJson(data);
    } else {
      throw Exception('Failed to create order: ${response.body}');
    }
  }

  // ---------------------- ORDER ITEMS ----------------------
  static Future<OrderItemModel> createOrderItem(Map<String, dynamic> itemData) async {
    final url = Uri.parse('${ApiConfig.getBaseUrl()}/order_items');
    final response = await http.post(
      url,
      headers: ApiConfig.headers,
      body: json.encode(itemData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)[0];
      return OrderItemModel.fromJson(data);
    } else {
      throw Exception('Failed to create order item: ${response.body}');
    }
  }
}
