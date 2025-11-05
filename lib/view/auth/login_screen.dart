import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../data/remote/services/auth_service.dart';
import '../widgets/theme_button.dart';

class LoginScreen extends StatelessWidget {
  final AuthService authService;
  LoginScreen({super.key, required this.authService});

  final _email = TextEditingController();
  final _password = TextEditingController();

  Future<void> _login() async {
    try {
      await authService.signIn(_email.text.trim(), _password.text.trim());
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WeFurniture Log In',style:TextStyle(fontFamily: 'Inter', fontSize:24, fontWeight: FontWeight.w700)), backgroundColor: Colors.white, centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'Email',labelStyle: TextStyle(fontFamily: 'Inter', fontSize:20) ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _password,
              decoration: const InputDecoration(labelText: 'Password',labelStyle: TextStyle(fontFamily: 'Inter', fontSize:20)),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            WidthButton(
              onPressed: _login,
              text:'Login',
              width:100),
            TextButton(
              onPressed: () => Get.toNamed('/signup'), 
              child: const Text('No account? Sign up', style:TextStyle(fontFamily: 'Inter', fontSize:18, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
