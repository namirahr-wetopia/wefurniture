import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/detailed_product_by_category_controller.dart';
import '../../nav.dart';
import '../theme/colors.dart';
import 'header.dart';
import 'search_bar.dart';
import 'section_title.dart';
import 'categories.dart';
import 'product_carousel.dart';
import 'bestseller_carousel.dart';
import '../../controller/detailed_product_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final DetailedProductByCategoryController productController;
  @override
  void initState() {
    super.initState();

    if (!Get.isRegistered<DetailedProductByCategoryController>()) {
      productController = Get.put(DetailedProductByCategoryController());
    } else {
      productController = Get.find<DetailedProductByCategoryController>();
    }
    
    productController.fetchProductofAllCategories();
  }

  @override
  Widget build(BuildContext context) {

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
            const SliverToBoxAdapter(child: ProductCarousel()), 
            const SliverToBoxAdapter(child: SectionTitle('Best Seller')),
            const SliverToBoxAdapter(child: BestSellerCarousel())
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }
}
