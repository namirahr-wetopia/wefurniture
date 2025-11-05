import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'model/detailed_product_by_category_model.dart';
import 'view/auth/login_screen.dart';
import 'view/auth/signup_screen.dart';
import 'view/welcome.dart';
import 'view/home_screen/home.dart';
import 'view/profile_screen/profile.dart';
import 'view/cart_screen/cart.dart';
import 'view/product_details.dart';
import 'model/detailed_product_model.dart';
import 'data/remote/services/auth_service.dart';


final appRoutes = [
  GetPage(
    name: '/signup',
    page: () =>SignupScreen(authService: GetIt.I<AuthService>()),
  ),
  GetPage(
    name: '/login',
    page: () =>LoginScreen(authService: GetIt.I<AuthService>()),
  ),
  GetPage(
    name: '/onboarding',
    page: () => const OnboardingPage(),
  ),
  GetPage(
    name: '/home',
    page: () => HomeScreen(),
  ),
  GetPage(
    name: '/profile',
    page: () => ProfileScreen(authService: GetIt.I<AuthService>()),
  ),
  GetPage(
    name: '/cart',
    page: () => const CartScreen(),
  ),
  GetPage(
    name: '/product',
    page: () => ProductDetails(product: Get.arguments as DetailedProductByCategoryModel),
  ),
];
