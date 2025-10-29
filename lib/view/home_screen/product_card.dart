import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/colors.dart';
import '../../model/inventory_model.dart';
import '../../controller/inventory_controller.dart';
import '../../cart_provider.dart';

class ProductCard extends StatelessWidget {
  final InventoryModel inventory;
  const ProductCard({super.key, required this.inventory});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width; 
    final h = MediaQuery.sizeOf(context).height;

    final displayName = 'Product #${inventory.productIdFk}';
    final displaySubtitle = 'Qty: ${inventory.quantity}';
    final displayPrice = '৳ —';
    final imageUrl = null; // placeholder - try to get from nested product data if available
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(w * 0.0389),
        onTap: () => context.push('/product', extra: product),
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
                        child: Image.asset(
                          product.image_url,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    if (product.isNew)
                      Positioned(
                        left: w * 0.0195,
                        bottom:  h * 0.0135,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal:  w * 0.0243, vertical:  h * 0.0022),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 0, 0),
                            borderRadius: BorderRadius.circular(w * 0.0487),
                          ),
                          child: const Text(
                            'NEW',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                            ),
                          ),
                        ),
                      ),
                    if (product.rating > 0)
                      Positioned(
                        right: w * 0.0195,
                        bottom: h * 0.0135,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF4D6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star, size: 16, color: Color(0xFFFFC107)),
                              SizedBox(width: w * 0.0097),
                              Text(
                                product.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color:Color(0xFFFFC107)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.0292, vertical: h * 0.0112),
                  child: Column(
                    children: [
                  Row(
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(fontFamily:'Inter', color: AppColors.darkestGray,fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.0022),
                  Row(
                    children: [
                      Text(
                        product.subtitle,
                        style: TextStyle(fontFamily:'Inter',color: AppColors.mediumGray, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(height: h * 0.0030),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        product.price,
                        style: const TextStyle(fontFamily:'Inter',fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => CartProvider.of(context).add(product),
                        borderRadius: BorderRadius.circular(w * 0.0438),
                        child: Container(
                          height: h * 0.0505,
                          width: h * 0.0505,
                          decoration: BoxDecoration(
                            color: AppColors.darkGray.withAlpha(220),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.add, color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ],
                ),
              ),
            ]
          ),
        ),
      ),
      )
    );
  }
}
