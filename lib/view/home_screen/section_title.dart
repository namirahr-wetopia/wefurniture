import 'package:flutter/material.dart';
import '../theme/colors.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: w * 0.04,vertical: h * 0.015),
      child: Text(
        text,
        style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.darkestGray,
              fontSize: 22,
              fontFamily:'Inter'
            ),
      ),
    );
  }
}