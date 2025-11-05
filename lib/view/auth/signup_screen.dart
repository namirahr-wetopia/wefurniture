import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../data/remote/services/auth_service.dart';
import '../widgets/theme_button.dart';

class SignupScreen extends StatelessWidget {
  final AuthService authService;
  final _email = TextEditingController();
  final _name = TextEditingController();
  final _password = TextEditingController();

  SignupScreen({super.key, required this.authService});

  void _signup(BuildContext context) async {
    try {
      await authService.signUp(_email.text, _password.text, _name.text);
      Get.toNamed('/onboarding');
    } catch (e) {
      Get.snackbar(
        'Signup Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WeFurniture Sign Up',style:TextStyle(fontFamily: 'Inter', fontSize:24,fontWeight: FontWeight.w700)), backgroundColor: Colors.white, centerTitle: true,),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _name, decoration: InputDecoration(labelText: 'Full Name',labelStyle: TextStyle(fontFamily: 'Inter', fontSize:20))),
            TextField(controller: _email, decoration: InputDecoration(labelText: 'Email',labelStyle: TextStyle(fontFamily: 'Inter', fontSize:20))),
            TextField(controller: _password, decoration: InputDecoration(labelText: 'Password',labelStyle: TextStyle(fontFamily: 'Inter', fontSize:20)), obscureText: true),
            WidthButton(
              onPressed:() => _signup(context),
              text:'Sign Up',
              width:150),
            TextButton(
              child: Text('Log In', style:TextStyle(fontFamily: 'Inter', fontSize:18, fontWeight: FontWeight.w600)),
              onPressed: () => Get.offAllNamed('/login'),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}