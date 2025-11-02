import 'package:get/get.dart';
import '../model/detailed_product_model.dart';
import '../../data/remote/repositories/detailed_product_repository.dart';

class DetailedProductController extends GetxController {
  var products = <DetailedProductModel>[].obs;
  var isLoading = false.obs;
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final result = await DetailedProductRepository.fetchDetailedProducts();
      print('Fetched ${result.length} products');
      products.assignAll(result); 
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
