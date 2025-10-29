import 'package:flutter/material.dart';
import 'cart_provider.dart';
import 'router.dart';

void main() => runApp(CartProvider(
    child: const MyApp())
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
