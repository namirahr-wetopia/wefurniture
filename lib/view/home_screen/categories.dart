import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/detailed_product_by_category_controller.dart';
import '../../controller/category_controller.dart';
import '../theme/colors.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  int selected = 0; // default to first category Chairs
  late final CategoryController categoryController;
  late final DetailedProductByCategoryController detailedProductByCategoryController;

  @override
  void initState() {
    super.initState();
    categoryController = Get.put(CategoryController());
    detailedProductByCategoryController = Get.put(DetailedProductByCategoryController());
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await categoryController.fetchCategories();

    if (categoryController.categories.isNotEmpty) {
      final firstCategory = categoryController.categories[0];
      detailedProductByCategoryController.fetchProductsByCategory(firstCategory.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    return Obx(() {
      final cats = categoryController.categories;
      if (categoryController.isLoading.value) {
        return SizedBox(
          height: h * 0.0481,
          child: const Center(child: CircularProgressIndicator()),
        );
      }
      if (cats.isEmpty) {
        return SizedBox(
          height: h * 0.0481,
          child: const Center(child: Text('No categories')),
        );
      }

      return SizedBox(
        height: h * 0.0481,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: w * 0.0438),
          scrollDirection: Axis.horizontal,
          itemCount: cats.length,
          separatorBuilder: (_, __) => SizedBox(width: w * 0.0243),
          itemBuilder: (context, i) {
            final sel = i == selected;
            return ChoiceChip(
              label: Text(cats[i].name),
              selected: sel,
              showCheckmark: false,
              onSelected: (_) {
                setState(() => selected = i);
                detailedProductByCategoryController.fetchProductsByCategory(cats[i].name);
              },
              labelStyle: TextStyle(
                fontSize: 16,
                color: sel ? AppColors.white : AppColors.darkGray,
              ),
              selectedColor: AppColors.darkGray,
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.0486),
              ),
            );
          },
        ),
      );
    });
  }
}

