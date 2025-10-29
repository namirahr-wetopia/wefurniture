import 'package:flutter/material.dart';
import 'checkout_bar.dart';
import 'recent_carousel.dart';
import 'section_title.dart';
import '../../model/cart_model.dart';
import '../theme/colors.dart';
import '../../cart_provider.dart';
import 'cart_tile.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<bool> selected = const [];

  void _deleteSelected(CartModel cart) {
    for (int i = selected.length - 1; i >= 0; i--) {
      if (selected[i]) cart.remove(cart.items[i].product);
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final cart = CartProvider.of(context);
    if (selected.length != cart.items.length) {
      final old = selected;
      selected = List<bool>.filled(cart.items.length, false);
      for (int i = 0; i < old.length && i < selected.length; i++) {
        selected[i] = old[i];
      }
    }

    final totalItems = cart.items.fold<int>(0, (s, e) => s + e.quantity);
    final totalPrice = cart.items.fold<double>(0.0, (s, e) {
      final p = double.tryParse(
            e.product.price.replaceAll(RegExp(r'[^\d.]'), ''),
          ) ??
          0.0;
      return s + p * e.quantity;
    });
    
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        leading: IconButton(onPressed: () => Navigator.of(context).maybePop(), icon: Icon(Icons.chevron_left),color:AppColors.darkestGray,iconSize: 40),
        title: const Text('Cart', style:  TextStyle(fontSize: 24, fontWeight: FontWeight.w700,  fontFamily:'Inter',color:AppColors.darkestGray),),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline,color: AppColors.darkestGray,),
            onPressed: cart.items.isEmpty
                ? null
                : () => _deleteSelected(cart), 
            iconSize: 30,
          ),
        ],
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: cart,
        builder: (context, _) {
          if (cart.items.isEmpty) {
            // Empty state with Recently View pinned at bottom
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Your cart is empty',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.011),
                      const SectionTitle('Recently View'),
                      SizedBox(height: h * 0.011),
                      const RecentCarousel(),
                      SizedBox(height: h * 0.0328),
                    ],
                  ),
                ),
              ],
            );
          }
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(w*0.0272,w* 0.0272,w * 0.0272, w* 0.01096 + h * 0.1233),
                sliver: SliverList.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: h* 0.011),
                      child: CartTile(
                        product: item.product,
                        quantity: item.quantity,
                        selected: selected[index],
                        onIncrement: () => cart.increment(item.product),
                        onDecrement: () => cart.decrement(item.product),
                        onToggle: () { setState(() => selected[index] = !selected[index]); 
                        },
                      ),
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SectionTitle('Recently View')),
              const SliverToBoxAdapter(child: RecentCarousel()),
              SliverToBoxAdapter(child: SizedBox(height: h * 0.0328)),
            ],
          );
        },
      ),

      bottomNavigationBar: AnimatedBuilder(
        animation: cart,
        builder: (context, _) {
          final totalItems = cart.items.fold<int>(0, (s, e) => s + e.quantity);
          final totalPrice = cart.items.fold<double>(0.0, (s, e) {
            final p = double.tryParse(
                  e.product.price.replaceAll(RegExp(r'[^\d.]'), ''),
                ) ??
                0.0;
            return s + p * e.quantity;
          });
          return CheckoutSummary(
            totalItems: totalItems,
            totalPrice: totalPrice,
      );
     }
      )
    );
  }
}

