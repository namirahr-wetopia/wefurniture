// product_carousel.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/detailed_product_by_category_controller.dart';
import '../theme/colors.dart';
import 'product_card.dart';

class ProductCarousel extends StatelessWidget {
  const ProductCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    final productByCategoryController = Get.find<DetailedProductByCategoryController>();

    return SizedBox(
      height: h * 0.393,
      child: Obx(() {
        if (productByCategoryController.isLoading.value) {
          return Center(
              child:
                  SizedBox(height: 40, width: 40, child: CircularProgressIndicator()));
        }

        final items = productByCategoryController.products;

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
