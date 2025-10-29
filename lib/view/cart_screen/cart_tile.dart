import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../home_screen/product.dart';

class CartTile extends StatelessWidget {
  final Product product;
  final int quantity;
  final bool selected;
  final VoidCallback? onToggle;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const CartTile({
    super.key,
    required this.product,
    this.quantity = 1,
    this.selected = false,
    this.onToggle,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onToggle, // parent handles toggling
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: selected ? AppColors.darkGray : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: selected ? AppColors.darkGray : AppColors.mediumGray,
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: selected
                  ? const Icon(Icons.check, color: AppColors.white, size: 14)
                  : null,
            ),
          ),
          const SizedBox(width: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              product.image_path,
              width: 90,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                SizedBox(height: 2),
                Text(
                  product.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.mediumGray, fontSize: 14),
                ),
                SizedBox(height: 8), 
                Row(
                  children: [
                    Text(
                      product.price, 
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    const Spacer(), 
                    Container(
                      padding:EdgeInsets.symmetric(horizontal: 6),
                      height: 34,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _CircleBtn(icon: Icons.remove, onTap: onDecrement),
                          SizedBox(width: 8),
                          Text(
                            '$quantity',
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          SizedBox(width: 8),
                          _CircleBtn(icon: Icons.add, onTap: onIncrement),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _CircleBtn({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return InkResponse(
      onTap: onTap,
      radius: 18,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 16),
      ),
    );
  }
}