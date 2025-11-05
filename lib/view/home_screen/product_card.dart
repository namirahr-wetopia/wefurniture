import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/detailed_product_by_category_model.dart';
import '../theme/colors.dart';
import '../../controller/cart_controller.dart';

class ProductCard extends StatelessWidget {
  final DetailedProductByCategoryModel product;
  ProductCard({super.key, required this.product}){
    print('ProductCard created with product: ${product.title}, price: ${product.price}, id: ${product.id}');
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    final cartController = Get.find<CartController>();

    final imageUrl = (product.images != null && product.images!.isNotEmpty)
        ? product.images!.first.imageUrl
        : null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(w * 0.0389),
        onTap: () {
          Get.toNamed('/product', arguments: product);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(w * 0.0243),
            border: Border.all(color: Colors.white),
          ),
          child: Padding(
            padding: EdgeInsets.all(w * 0.0195),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image area
                Stack(
                  children: [
                    Container(
                      height: h * 0.2245,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(w * 0.0195),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Center(
                        child: imageUrl != null && imageUrl.isNotEmpty
                            ? Image.network(
                                imageUrl,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.broken_image),
                              )
                            : const Icon(Icons.image, size: 48),
                      ),
                    ),

                    // NEW badge
                    if (product.isNew)
                      Positioned(
                        left: w * 0.0195,
                        bottom: h * 0.0135,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: w * 0.0243, vertical: h * 0.0022),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 0, 0),
                            borderRadius: BorderRadius.circular(w * 0.0487),
                          ),
                          child: const Text(
                            'NEW',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),

                    // rating chip
                    if (product.rating > 0)
                      Positioned(
                        right: w * 0.0195,
                        bottom: h * 0.0135,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF4D6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star,
                                  size: 16, color: Color(0xFFFFC107)),
                              SizedBox(width: w * 0.0097),
                              Text(
                                product.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color(0xFFFFC107)),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.0292, vertical: h * 0.0112),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            color: AppColors.darkestGray,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                      SizedBox(height: h * 0.0022),
                      Text(
                        product.subtitle ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            color: AppColors.mediumGray,
                            fontSize: 16),
                      ),
                      SizedBox(height: h * 0.006),
                      Row(
                        children: [
                          Text(
                            product.price.toString(),
                            style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () => cartController.add(product),
                            borderRadius:
                                BorderRadius.circular(w * 0.0438),
                            child: Container(
                              height: h * 0.0505,
                              width: h * 0.0505,
                              decoration: BoxDecoration(
                                color: AppColors.darkGray.withAlpha(220),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.add, color: AppColors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
