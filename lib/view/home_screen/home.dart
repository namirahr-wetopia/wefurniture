import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../nav.dart';
import '../theme/colors.dart';
import 'header.dart';
import 'search_bar.dart';
import 'section_title.dart';
import 'categories.dart';
import 'product_carousel.dart';
import 'bestseller_carousel.dart';
import '../../controller/detailed_product_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller once
    final productController = Get.put(DetailedProductController());
    // Fetch products on first build
    productController.fetchProducts();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: Header()),
            const SliverToBoxAdapter(child: HomeSearchBar()),
            const SliverToBoxAdapter(child: SectionTitle('Categories')),
            const SliverToBoxAdapter(child: Categories()),
            SliverToBoxAdapter(
                child: SizedBox(height: MediaQuery.sizeOf(context).height * 0.0224)),
            const SliverToBoxAdapter(child: ProductCarousel()), // No more future
            const SliverToBoxAdapter(child: SectionTitle('Best Seller')),
            const SliverToBoxAdapter(child: BestSellerCarousel())
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }
}
