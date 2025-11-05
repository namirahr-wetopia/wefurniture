import 'package:get/get.dart';
import '../../model/detailed_product_by_category_model.dart';
import '../model/detailed_product_model.dart';

class CartItem {
  final DetailedProductByCategoryModel product;
  RxInt quantity;

  CartItem({required this.product, int quantity = 1})
      : quantity = quantity.obs;
}

class CartController extends GetxController {
  var items = <CartItem>[].obs;

  void add(DetailedProductByCategoryModel product) {
    final index = items.indexWhere((i) => i.product.title == product.title);
    if (index != -1) {
      items[index].quantity.value++;
    } else {
      items.add(CartItem(product: product, quantity: 1));
    }
  }

  void increment(DetailedProductByCategoryModel product) {
    final i = items.indexWhere((e) => e.product.title == product.title);
    if (i != -1) items[i].quantity.value++;
  }

  void decrement(DetailedProductByCategoryModel product) {
    final i = items.indexWhere((e) => e.product.title == product.title);
    if (i != -1 && items[i].quantity.value > 1) {
      items[i].quantity.value--;
    }
  }

  void remove(DetailedProductByCategoryModel product) {
    items.removeWhere((e) => e.product.title == product.title);
  }

  void clear() {
    items.clear();
  }
}
