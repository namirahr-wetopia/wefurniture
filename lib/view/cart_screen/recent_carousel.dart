import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/detailed_product_by_category_controller.dart';
import 'recent_card.dart';

class RecentCarousel extends StatelessWidget {
  const RecentCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    final productController = Get.find<DetailedProductByCategoryController>();

    return SizedBox(
      height: 350,
      child: Obx(() {
        if (productController.isLoadingAll.value) {
          return Center(
              child:
                  SizedBox(height: 40, width: 40, child: CircularProgressIndicator()));
        }

        final items = productController.allProducts;

        if (items.isEmpty) {
          return const Center(child: Text('No products found'));
      } 
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            for (final prod in items) ...[
              SizedBox(
                width: 280,
                child: RecentCard(product: prod),
              ),
              const SizedBox(width: 18),
            ],
          ],
        ),
      );
      }
      ),
    );
  }
}

