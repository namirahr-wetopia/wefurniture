import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'product.dart';

class BestSellerCard extends StatelessWidget {
  final Product product;
  const BestSellerCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width; 
    final h = MediaQuery.sizeOf(context).height;
    return Container(
      width: w * 0.7786,
      padding: EdgeInsets.all(h * 0.0067),
      decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(w * 0.025),
            border: Border.all(color: Colors.white),
          ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(w * 0.019),
            child: Image.asset(
              product.image_path,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width:w * 0.0487),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20, fontFamily: 'Inter')),
                SizedBox(height:h * 0.0022),
                Text(product.subtitle, style: TextStyle(color: AppColors.mediumGray, fontSize: 16, fontFamily: 'Inter')),
                SizedBox(height:h * 0.0066),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.price, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20, fontFamily:'Inter')),
                    InkWell(
                      onTap: (){},
                      borderRadius: BorderRadius.circular(w * 0.0487),
                      child: Container(
                        height: w * 0.0876,
                        width: w * 0.0876,
                        decoration: BoxDecoration(
                          color: AppColors.darkGray.withAlpha(230),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 18),
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
