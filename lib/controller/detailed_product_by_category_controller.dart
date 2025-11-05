import 'package:get/get.dart';
import '../model/detailed_product_by_category_model.dart';
import '../../data/remote/repositories/detailed_product_by_category_repository.dart';

class DetailedProductByCategoryController extends GetxController {
  var products = <DetailedProductByCategoryModel>[].obs;
  var isLoading = false.obs;

  Future<void> fetchProductsByCategory(String categoryName) async {
    try {
      isLoading.value = true;
      final result = await DetailedProductByCategoryRepository.fetchDetailedProductsByCategory(
        categoryName: categoryName,
      );
      print('Fetched ${result.length} products for category: $categoryName');
      products.assignAll(result);
    } catch (e) {
      print('Error fetching products for category $categoryName: $e');
    } finally {
      isLoading.value = false;
    }
  }

  var allProducts = <DetailedProductByCategoryModel>[].obs;
  var isLoadingAll = false.obs;
  var hasLoadedAll = false.obs;

  Future<void> fetchProductofAllCategories() async {
    if (hasLoadedAll.value) return; 
    try {
      isLoadingAll.value = true;
      final resultAll = await DetailedProductByCategoryRepository.fetchDetailedProductsByCategory(
        categoryName: '',
      );
      print(resultAll);
      print('Fetched ${resultAll.length} products for all categories');
      allProducts.assignAll(resultAll);
      hasLoadedAll.value = true;
    } catch (e) {
      print('Error fetching products for all categories: $e');
    } finally {
      isLoadingAll.value = false;
    }
  }
}
