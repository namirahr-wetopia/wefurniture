import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/theme/colors.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  const AppBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Get.toNamed('/home');
            break;
          case 1:
            // no favourite route yet
            break;
          case 2:
            // no scan route yet
            break;
          case 3:
            Get.toNamed('/cart');
            break;
          case 4:
            Get.toNamed('/profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favourite'),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}