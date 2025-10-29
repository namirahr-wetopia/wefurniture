import '../data/remote/services/remote_data_source.dart';
import '../model/inventory_model.dart';

class ProductController {
  final _remoteDataSource = RemoteDataSource();

  Future<List<InventoryModel>> getAllProducts() async {
    return await RemoteDataSource.fetchInventory();
  }

}
