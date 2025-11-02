import 'package:get/get.dart';
import 'view/welcome.dart';
import 'view/home_screen/home.dart';
import 'view/profile_screen/profile.dart';
import 'view/cart_screen/cart.dart';
import 'view/product_details.dart';
import 'model/detailed_product_model.dart';

final appRoutes = [
  GetPage(
    name: '/onboarding',
    page: () => const OnboardingPage(),
  ),
  GetPage(
    name: '/home',
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: '/profile',
    page: () => const ProfileScreen(),
  ),
  GetPage(
    name: '/cart',
    page: () => const CartScreen(),
  ),
  GetPage(
    name: '/product',
    page: () => ProductDetails(product: Get.arguments as DetailedProductModel),
  ),
];
