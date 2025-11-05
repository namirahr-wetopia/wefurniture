import 'package:get/get.dart';
import '../model/category_model.dart';
import '../../data/remote/repositories/category_repository.dart';

class CategoryController extends GetxController {
  var categories = <CategoryModel>[].obs;
  var isLoading = false.obs;

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final result = await CategoryRepository.fetchAllCategories();
      print('Fetched ${result.length} categories');
      categories.assignAll(result);
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
