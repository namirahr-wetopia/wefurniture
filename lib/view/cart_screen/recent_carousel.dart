import 'package:flutter/material.dart';
import '../home_screen/product.dart';
import '../theme/colors.dart';
import 'recent_card.dart';

class RecentCarousel extends StatelessWidget {
  const RecentCarousel();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350, 
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            for (final p in products) ...[
              SizedBox(
                width: 230,
                child: RecentCard(product: p),
              ),
              const SizedBox(width: 18),
            ],
          ],
        ),
      ),
    );
  }
}

