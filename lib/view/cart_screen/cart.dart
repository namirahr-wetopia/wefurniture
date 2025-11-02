import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'checkout_bar.dart';
import 'recent_carousel.dart';
import 'section_title.dart';
import '../theme/colors.dart';
import '../../controller/cart_controller.dart';
import 'cart_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    // Local reactive state for selected checkboxes
    final selected = <bool>[].obs;

    void _deleteSelected() {
      for (int i = selected.length - 1; i >= 0; i--) {
        if (selected[i]) {
          cartController.remove(cartController.items[i].product);
        }
      }
      selected.clear();
      selected.addAll(
        List<bool>.filled(cartController.items.length, false),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.chevron_left),
          color: AppColors.darkestGray,
          iconSize: 40,
        ),
        title: const Text(
          'Cart',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
            color: AppColors.darkestGray,
          ),
        ),
        actions: [
          Obx(() => IconButton(
                icon: const Icon(Icons.delete_outline,
                    color: AppColors.darkestGray),
                onPressed: cartController.items.isEmpty ? null : _deleteSelected,
                iconSize: 30,
              )),
        ],
        centerTitle: true,
      ),
      body: Obx(() {
        // Keep selected state list aligned with items
        if (selected.length != cartController.items.length) {
          final old = List<bool>.from(selected);
          selected.assignAll(
              List<bool>.filled(cartController.items.length, false));
          for (int i = 0; i < old.length && i < selected.length; i++) {
            selected[i] = old[i];
          }
        }

        if (cartController.items.isEmpty) {
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
              padding: EdgeInsets.fromLTRB(
                w * 0.0272,
                w * 0.0272,
                w * 0.0272,
                w * 0.01096 + h * 0.1233,
              ),
              sliver: SliverList.builder(
                itemCount: cartController.items.length,
                itemBuilder: (context, index) {
                  final item = cartController.items[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: h * 0.011),
                    child: Obx(() => CartTile(
                          product: item.product,
                          quantity: item.quantity.value,
                          selected: selected[index],
                          onIncrement: () =>
                              cartController.increment(item.product),
                          onDecrement: () =>
                              cartController.decrement(item.product),
                          onToggle: () => selected[index] = !selected[index],
                        )),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(child: SectionTitle('Recently View')),
            const SliverToBoxAdapter(child: RecentCarousel()),
            SliverToBoxAdapter(child: SizedBox(height: h * 0.0328)),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        final totalItems = cartController.items.fold<int>(
            0, (s, e) => s + e.quantity.value);
        final totalPrice = cartController.items.fold<double>(0.0, (s, e) {
          final p = e.product.price;
          return s + p * e.quantity.value;
        });
        return CheckoutSummary(
          totalItems: totalItems,
          totalPrice: totalPrice,
        );
      }),
    );
  }
}
