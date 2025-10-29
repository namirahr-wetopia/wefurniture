import '../services/remote_data_source.dart';
import '../../../model/inventory_model.dart';

class CategoryRepository {
  Future<List<InventoryModel>> getAllInventorys() => RemoteDataSource.fetchInventory();
}
