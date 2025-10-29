import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'view/theme/colors.dart';

class AppBottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppBottomNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: navigationShell.currentIndex,
      onTap: (index) {
        if (index == 3) {
          context.push('/cart'); 
        }
        else if( index==4){
          context.go('/profile');
        }
        else{
          navigationShell.goBranch(index);
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

