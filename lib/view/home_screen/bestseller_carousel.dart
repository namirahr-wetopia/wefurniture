import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/colors.dart';
import '../../controller/detailed_product_controller.dart';
import 'bestseller_card.dart';

class BestSellerCarousel extends StatelessWidget {
  const BestSellerCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    final productController = Get.find<DetailedProductController>();

    return SizedBox(
      height: h * 0.18,
      child: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: SizedBox(width: 40, height: 40, child: CircularProgressIndicator()));
        }

        final items = productController.products;
        if (items.isEmpty) {
          return const Center(child: Text('No products found'));
        }

        final displayItems = items.take(6).toList();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: w * 0.0389),
          child: Row(
            children: [
              for (final p in displayItems) ...[
                BestSellerCard(product: p),
                SizedBox(width: w * 0.0292),
              ],
            ],
          ),
        );
      }),
    );
  }
}