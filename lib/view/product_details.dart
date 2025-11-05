import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/detailed_product_by_category_model.dart';
import 'widgets/theme_button.dart';
import 'widgets/step_button.dart';
import 'widgets/circle_icon_button.dart';
import '../controller/cart_controller.dart';
import 'theme/colors.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    super.key,
    required this.product,
  });

  final DetailedProductByCategoryModel product;

  @override
  State<ProductDetails> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetails> {
  int quantity = 1;
  int selectedColor = 0;
  int selectedImage = 0;

  List<String> get _thumbs {
    final imgs = widget.product.images;
    if (imgs == null || imgs.isEmpty) {
      return ['']; 
    }
    return imgs.map((e) => e.imageUrl ?? '').toList();
  }

  double get unitPrice => widget.product.price;
  double get totalPrice => unitPrice * quantity;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    final product = widget.product;
    final cartController = Get.find<CartController>();

    final thumbs = _thumbs;
    final mainImageUrl = (thumbs.isNotEmpty && thumbs[selectedImage].isNotEmpty)
        ? thumbs[selectedImage]
        : null;

    final colorNames = product.colourInventories ?? [];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: mainImageUrl != null
                        ? Image.network(
                            mainImageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Center(child: Icon(Icons.broken_image)),
                          )
                        : const Center(child: Icon(Icons.image, size: 72)),
                  ),
                  Positioned(
                    left: w * 0.0292,
                    top: w * 0.0292,
                    child: CircleIconButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: () => Get.back(),
                    ),
                  ),
                  Positioned(
                    right: w * 0.0292,
                    top: w * 0.0292,
                    child: CircleIconButton(
                      icon: Icons.favorite_border,
                      onTap: () {},
                    ),
                  ),
                  Positioned(
                    bottom: h * 0.0090,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        SizedBox(height: h * 0.0045),
                        Container(
                          width: w * 0.340,
                          height: h * 0.0314,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(w * 0.0487),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '360º',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.0090),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(w * 0.0487)),
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: w * 0.0292, vertical: h * 0.0112),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: TextStyle(
                                  color: AppColors.darkestGray,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              SizedBox(height: h * 0.0112),
                              Text(
                                product.subtitle ?? '',
                                style: TextStyle(
                                  color: AppColors.mediumGray,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: h * 0.0224),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: w * 0.0195, vertical: h * 0.0067),
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade100,
                            borderRadius: BorderRadius.circular(w * 0.0487),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star, size: 20, color: Color(0xFFFFC107)),
                              SizedBox(width: w * 0.0097),
                              Text(
                                product.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFFFC107),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.0045),
                    Text(
                      product.description ??
                          "No description available.",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        height: 1.35,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: h * 0.0045),
                    Text(
                      "Read More",
                      style: TextStyle(
                        color: AppColors.darkGray,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: h * 0.0337),
                    if (thumbs.isNotEmpty)
                      SizedBox(
                        height: h * 0.0808,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: thumbs.length,
                          separatorBuilder: (_, __) => SizedBox(width: w * 0.0243),
                          itemBuilder: (context, i) => GestureDetector(
                            onTap: () => setState(() => selectedImage = i),
                            child: Container(
                              width: w * 0.1753,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(w * 0.0292),
                                border: Border.all(
                                  color: i == selectedImage
                                      ? AppColors.darkGray
                                      : Colors.grey.shade300,
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: thumbs[i].isNotEmpty
                                  ? Image.network(
                                      thumbs[i],
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const Icon(Icons.broken_image),
                                    )
                                  : const Icon(Icons.image),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: h * 0.0337),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Color',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Inter',
                              fontSize: 16),
                        ),
                        SizedBox(width: w * 0.0292),
                        if (colorNames!.isNotEmpty)
                          ...List.generate(colorNames.length, (i) {
                            final name = colorNames[i].colourName;
                            final isSelected = selectedColor == i;
                            return Padding(
                              padding: EdgeInsets.only(right: w * 0.0195),
                              child: ChoiceChip(
                                label: Text(
                                  name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                selectedColor: AppColors.mediumGray,
                                selected: isSelected,
                                onSelected: (_) => setState(() => selectedColor = i),
                              ),
                            );
                          }),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          height: h * 0.0381,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(w * 0.0438),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              StepButton(
                                icon: Icons.remove,
                                onTap: () {
                                  if (quantity > 1) {
                                    setState(() => quantity--);
                                  }
                                },
                              ),
                              SizedBox(width: w * 0.0195),
                              Text(
                                '$quantity',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              SizedBox(width: w * 0.0195),
                              StepButton(
                                icon: Icons.add,
                                onTap: () => setState(() => quantity++),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.0045),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: h * 0.0337)),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    w * 0.0389, h * 0.0112, w * 0.0389, h * 0.0269),
                child: WidthButton(
                  text: 'Add to Cart',
                  onPressed: () {
                    for (int i = 0; i < quantity; i++) {
                      cartController.add(product);
                    }
                    Get.toNamed('/cart');
                  },
                  doubleLabel: true,
                  secondText: '৳${totalPrice.toStringAsFixed(0)}',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





