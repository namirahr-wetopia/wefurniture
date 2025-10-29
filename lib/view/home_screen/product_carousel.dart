import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../../model/inventory_model.dart';
import 'product_card.dart';

class ProductCarousel extends StatelessWidget {
  final Future<List<InventoryModel>> inventoryFuture;
  const ProductCarousel({super.key, required this.inventoryFuture});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width; 
    final h = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: h * 0.393, 
      child: FutureBuilder<List<InventoryModel>>(
        future: inventoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: SizedBox(height: 40, width: 40, child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load products: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'));
          }

          final items = snapshot.data!;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: w * 0.0389),
            child: Row(
              children: [
                for (final inv in items) ...[
                  SizedBox(
                    width: w * 0.56,
                    child: ProductCard(inventory: inv),
                  ),
                  SizedBox(width: w * 0.0438),
                ],
              ],
            ),
    );
  }
        ),
    );
  }
}
