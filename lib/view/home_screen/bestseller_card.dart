import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../model/detailed_product_by_category_model.dart';
import '../theme/colors.dart';

class BestSellerCard extends StatelessWidget {
  final DetailedProductByCategoryModel product;
  const BestSellerCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    final cartController = Get.find<CartController>();

    final imageUrl = (product.images != null && product.images!.isNotEmpty)
        ? product.images!.first.imageUrl
        : null;

    return Container(
      width: w * 0.78,
      padding: EdgeInsets.all(h * 0.0067),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.025),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(w * 0.019),
            child: Container(
              width: w * 0.28,
              height: h * 0.12,
              color: Colors.white,
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.broken_image))
                  : const Icon(Icons.image, size: 48),
            ),
          ),
          SizedBox(width: w * 0.0487),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20, fontFamily: 'Inter')),
                SizedBox(height: h * 0.0022),
                Text(product.subtitle ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColors.mediumGray, fontSize: 16, fontFamily: 'Inter')),
                SizedBox(height: h * 0.0066),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.price.toString(),
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20, fontFamily: 'Inter')),
                    InkWell(
                      onTap: () => cartController.add(product),
                      borderRadius: BorderRadius.circular(w * 0.0487),
                      child: Container(
                        height: w * 0.0876,
                        width: w * 0.0876,
                        decoration: BoxDecoration(
                          color: AppColors.darkGray.withAlpha(230),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}