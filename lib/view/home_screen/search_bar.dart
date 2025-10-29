import 'package:flutter/material.dart';
import '../theme/colors.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width; 
    final h = MediaQuery.sizeOf(context).height;
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: w * 0.0389 ,vertical: h * 0.0067 ),
      child: Container(
        height: h * 0.0673,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(w * 0.0389), 
          border: Border.all(color: AppColors.lightestGray),
        ),
        child: Row(
          children: [
            SizedBox(width: w * 0.0292),
            const Icon(Icons.search, color: AppColors.darkGray, size: 22),
            SizedBox(width: w * 0.0195),
            Expanded(
              child: TextField(
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Search for furniture',
                  hintStyle: TextStyle(color: AppColors.mediumGray, fontFamily: 'Inter'),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding:EdgeInsets.symmetric(vertical: h * 0.0157),
                ),
              ),
            ),
            Container(
              width: 1,
              height: h * 0.0269,
              color: AppColors.mediumGray,
            ),
            IconButton(
              icon: const Icon(Icons.tune_rounded, color: AppColors.darkGray, size: 22),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
