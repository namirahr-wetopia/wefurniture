// product_carousel.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/colors.dart';
import '../../controller/detailed_product_controller.dart';
import 'product_card.dart';

class ProductCarousel extends StatelessWidget {
  const ProductCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    final productController = Get.find<DetailedProductController>();

    return SizedBox(
      height: h * 0.393,
      child: Obx(() {
        if (productController.isLoading.value) {
          return Center(
              child:
                  SizedBox(height: 40, width: 40, child: CircularProgressIndicator()));
        }

        final items = productController.products;

        if (items.isEmpty) {
          return const Center(child: Text('No products found'));
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: w * 0.0389),
          child: Row(
            children: [
              for (final prod in items) ...[
                SizedBox(
                  width: w * 0.56,
                  child: ProductCard(product: prod),
                ),
                SizedBox(width: w * 0.0438),
              ],
            ],
          ),
        );
      }),
    );
  }
}
