import 'package:get/get.dart';
import '../../model/detailed_product_by_category_model.dart';
import 'db_helper.dart';
import '../../model/cart_model.dart';
import '../../controller/cart_controller.dart';

typedef ProductToCartModel = CartModel Function(DetailedProductByCategoryModel product, int quantity);
typedef CartModelToProduct = DetailedProductByCategoryModel Function(CartModel cartModel);

class CartPersistence {
  final CartController controller;
  final DBHelper _db = DBHelper.getInstance();

  final ProductToCartModel productToCartModel;
  final CartModelToProduct cartModelToProduct;

  RxBool _isHydrated = false.obs;
  bool get isHydrated => _isHydrated.value;
  late Worker _worker;

  CartPersistence({
    required this.controller,
    required this.productToCartModel,
    required this.cartModelToProduct,
  });

  Future<void> init() async {
    await _hydrateControllerFromDb();
    _worker = ever(controller.items, (_) => _persistAll());
    _isHydrated.value = true;
  }

  Future<void> _hydrateControllerFromDb() async {
    final stored = await _db.getAllCartItems();
    controller.clear();
    for (final cartModel in stored) {
      final product = cartModelToProduct(cartModel);
      controller.items.add(CartItem(product: product, quantity: cartModel.quantity));
    }
  }
  Future<void> _persistAll() async {
    final current = controller.items.toList();
    await _db.clearCart();
    for (final ci in current) {
      final model = productToCartModel(ci.product, ci.quantity.value);
      await _db.insertCartItem(model.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now()));
    }
  }
  void dispose() {
    _worker.dispose();
  }
}
