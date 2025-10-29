import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'header.dart';
import 'search_bar.dart';
import 'section_title.dart';
import 'categories.dart';
import 'product_carousel.dart';
import 'bestseller_carousel.dart';
import '../../controller/inventory_controller.dart';
import '../../model/inventory_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = ProductController();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: Header()),
            const SliverToBoxAdapter(child: HomeSearchBar()),
            const SliverToBoxAdapter(child: SectionTitle('Categories')),
            const SliverToBoxAdapter(child: Categories()),
            SliverToBoxAdapter(child: SizedBox(height: MediaQuery.sizeOf(context).height * 0.0224)),
            SliverToBoxAdapter(
              child: ProductCarousel(
                inventoryFuture: productController.getAllProducts(),
              ),
            ),
            const SliverToBoxAdapter(child: SectionTitle('Best Seller')),
            const SliverToBoxAdapter(child: BestSellerCarousel())
          ],
        ),
      ),
    );
  }
}
