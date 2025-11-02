import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'router.dart';
import 'controller/cart_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  runZonedGuarded(() async {
    // Move all initialization inside runZonedGuarded
    WidgetsFlutterBinding.ensureInitialized();
    
    try {
      await dotenv.load(fileName: ".env");
    } catch (e, st) {
      print('dotenv.load failed: $e\n$st');
    }

    // Initialize GetX controller
    Get.put(CartController());
    
    // Run the app
    runApp(const MyApp());
    
  }, (error, stack) {
    print('Uncaught error: $error\n$stack');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Shop',
      debugShowCheckedModeBanner: false,
      getPages: appRoutes,
      initialRoute: '/onboarding',
    );
  }
}
