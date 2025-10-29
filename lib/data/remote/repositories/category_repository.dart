import '../services/remote_data_source.dart';
import '../../../model/category_model.dart';

class CategoryRepository {
  Future<List<CategoryModel>> getAllCategories() => RemoteDataSource.fetchCategories();
}
