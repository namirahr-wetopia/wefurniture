import 'package:flutter/material.dart';
import 'model/product_model.dart';


class CartItem {
  final ProductModel product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
}

class Cart extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void add(ProductModel product) {
    final index = _items.indexWhere((i) => i.product.name == product.name);
    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  void increment(ProductModel product) {
    final i = _items.indexWhere((e) => e.product.name == product.name);
    if (i != -1) {
      _items[i].quantity++;
      notifyListeners();
    }
  }

  void decrement(ProductModel product) {
    final i = _items.indexWhere((e) => e.product.name == product.name);
    if (i != -1 && _items[i].quantity > 1) {
      _items[i].quantity--;
      notifyListeners();
    }
  }

  void remove(ProductModel product) {
    _items.removeWhere((e) => e.product.name == product.name);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

class CartProvider extends InheritedNotifier<Cart> {
  CartProvider({super.key, required Widget child})
      : super(notifier: Cart(), child: child);

  static Cart of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CartProvider>()!.notifier!;
}
