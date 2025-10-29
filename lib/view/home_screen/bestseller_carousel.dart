import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'product.dart';
import 'bestseller_card.dart';

class BestSellerCarousel extends StatelessWidget {
  const BestSellerCarousel();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final items = products.take(6).toList();

    return SizedBox(
      height: 120,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: w * 0.0389),
        child: Row(
          children: [
            for (final p in items) ...[
              BestSellerCard(product: p),
              SizedBox(width: w * 0.0292),
            ],
          ],
        ),
      ),
    );

  }
}