import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/theme_button.dart';

class CheckoutSummary extends StatelessWidget {
  const CheckoutSummary({
    super.key,
    required this.totalItems,
    required this.totalPrice,
  });

  final int totalItems;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2))],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Total (${totalItems} Items)', style: const TextStyle(fontFamily: 'Inter',fontSize: 16,color: AppColors.mediumGray)),
              Text('\$${totalPrice.toStringAsFixed(0)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700,  fontFamily:'Inter',color:AppColors.darkestGray)),
            ]),
            const SizedBox(height: 16),
            WidthButton(text: 'Proceed to Checkout', onPressed: () {})
          ],
        ),
      ),
    );
  }
}
