import 'package:flutter/material.dart';
import 'widgets/theme_button.dart';
import 'package:go_router/go_router.dart';
import '../model/inventory_model.dart';
import '../cart_provider.dart';
import 'theme/colors.dart';


class ProductDetails extends StatefulWidget {
  const ProductDetails({
    super.key,
    required this.product,
  });

  final InventoryModel product;

  @override
  State<ProductDetails> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetails> {
  int quantity = 1;
  int selectedColor = 0;
  int selectedImage = 0;

  List<String> get _thumbs => [
        widget.product.image_url,
        widget.product.image_url,
        widget.product.image_url,
      ];
  
  double _parsePrice(String s) {
    final cleaned = s.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }


  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width; 
    final h = MediaQuery.sizeOf(context).height;
    final product = widget.product;
    final cart = CartProvider.of(context);
    final unitPrice = _parsePrice(product.price);
    final totalPrice = unitPrice * quantity; // 

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1, // square hero area
                    child: Image.asset(
                      _thumbs[selectedImage],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left:  w * 0.0292,
                    top:  w * 0.0292,
                    child: _CircleIcon(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: () => Navigator.of(context).maybePop(),
                    ),
                  ),
                  Positioned(
                    right:  w * 0.0292,
                    top:  w * 0.0292,
                    child: _CircleIcon(
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
                            borderRadius: BorderRadius.circular(w*0.0487)
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
                    EdgeInsets.symmetric(horizontal: w*0.0292, vertical: h*0.0112),
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
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                  color: AppColors.darkestGray,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Inter'
                                ),
                              ),
                              SizedBox(height: h*0.0112),
                              Text(
                                product.subtitle,
                                style: TextStyle(
                                  color: AppColors.mediumGray,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height:h*0.0224)
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: w*0.0195, vertical: h * 0.0067),
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade100,
                            borderRadius: BorderRadius.circular(w*0.0487),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star, size: 20, color: Color(0xFFFFC107)),
                              SizedBox(width: w *  0.0097),
                              Text(
                                product.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFFFC107),
                                    fontSize:16,
                                    fontFamily: 'Inter'
                                )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.0045),
                    Text(
                      "Simple & elegant shape makes it very suitable for those want a minimalist room.. ",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        height: 1.35,
                        fontFamily: 'Inter'
                      ),
                    ),
                    SizedBox(height: h * 0.0045),
                    Text(
                      "Read More",
                      style: TextStyle(
                        color: AppColors.darkGray,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter'
                      ),
                    ),
                    SizedBox(height: h*0.0337),
                    SizedBox(
                      height: h *0.0808,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _thumbs.length,
                        separatorBuilder: (_, __) => SizedBox(width: w*0.0243),
                        itemBuilder: (context, i) => GestureDetector(
                          onTap: () => setState(() => selectedImage = i),
                          child: Container(
                            width: w*0.1753,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(w*0.0292),
                              border: Border.all(
                                color: i == selectedImage
                                    ? AppColors.darkGray
                                    : Colors.grey.shade300,
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              _thumbs[i],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:h*0.0337),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Color',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                            fontSize: 16
                          ),
                        ),
                        SizedBox(width: w*0.0292),
                        _ColorDot(
                          color: Colors.grey.shade700,
                          selected: selectedColor == 0,
                          onTap: () => setState(() => selectedColor = 0),
                        ),
                        SizedBox(width: w * 0.0195),
                        _ColorDot(
                          color: Colors.grey.shade400,
                          selected: selectedColor == 1,
                          onTap: () => setState(() => selectedColor = 1),
                        ),
                        SizedBox(width:w * 0.0195),
                        _ColorDot(
                          color: const Color(0xFFE4574D),
                          selected: selectedColor == 2,
                          onTap: () => setState(() => selectedColor = 2),
                        ),
                        const Spacer(),

                        // Quantity stepper
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          height: h*0.0381,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(w*0.0438),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _StepBtn(
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
                              _StepBtn(
                                icon: Icons.add,
                                onTap: () => setState(() => quantity++),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.0045)
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: h * 0.0337)), // space for bottom button
            SliverToBoxAdapter(
          child: Padding(
            padding:EdgeInsets.fromLTRB(w * 0.0389, h * 0.0112, w * 0.0389, h * 0.0269),
            child: WidthButton(
              text: 'Add to Cart',
              onPressed: () {
              final cart = CartProvider.of(context);
            
              // add the chosen quantity
              for (int i = 0; i < quantity; i++) {
                cart.add(widget.product);
              }
            
              // go to the cart screen that renders CartTiles
              context.push('/cart'); // from go_router
              },          
              doubleLabel: true,
              secondText: '\$${totalPrice.toStringAsFixed(0)}',
              ),
          ),
          ),
        ],
        ),
      ),
      );
  }
}




class _CircleIcon extends StatelessWidget {
  const _CircleIcon({required this.icon, this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width:  w * 0.0973,
          height:  w * 0.0973,
          child: Icon(icon, size: 18, color: Colors.black87),
        ),
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  const _ColorDot({
    required this.color,
    required this.selected,
    this.onTap,
  });

  final Color color;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return InkResponse(
      onTap: onTap,
      radius:  w * 0.0438,
      child: Container(
        width: w * 0.0584,
        height: w * 0.0584,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? Colors.black87 : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
}

class _StepBtn extends StatelessWidget {
  const _StepBtn({required this.icon, this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return InkResponse(
      onTap: onTap,
      radius:  w * 0.0438,
      child: Container(
        width: w * 0.0633,
        height: w * 0.0633,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }
}