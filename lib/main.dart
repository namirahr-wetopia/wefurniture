import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/remote/injection/injection.dart';
import '../data/remote/services/auth_service.dart';
import 'controller/cart_controller.dart';
import 'router.dart';
import '../view/home_screen/home.dart';
import '../view/auth/login_screen.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      await dotenv.load(fileName: ".env");
      print('SUPABASE_BASE_URL=${dotenv.env['SUPABASE_BASE_URL']}');
      print('SUPABASE_ANON_KEY=${dotenv.env['SUPABASE_ANON_KEY']}');
    } catch (e, st) {
      print('dotenv.load failed: $e\n$st');
    }

    await Supabase.initialize(
      url: dotenv.env['SUPABASE_BASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
    await configureDependencies();
    Get.put(CartController());
    runApp(const MyApp());
  }, (error, stack) {
    print('Uncaught error: $error\n$stack');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = GetIt.I<SupabaseClient>();
    final authService = GetIt.I<AuthService>();

    return GetMaterialApp(
      home: supabase.auth.currentSession != null ? HomeScreen() : LoginScreen(authService: authService),
      routes: appRoutes.asMap().map((_, page) => MapEntry(page.name, (_) => page.page())),
    );
  }
}
