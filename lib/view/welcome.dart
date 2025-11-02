import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme/colors.dart';
import 'widgets/theme_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: Image.asset(
                'assets/images/welcome.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(
                50,  // left
                10,  // top
                50,  // right
                30,  // bottom
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enjoy Your Online\nShopping.',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkestGray,
                      fontSize: 20,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Browse through all categories and shop the best furniture for your dream house.',
                    style: TextStyle(
                      color: AppColors.mediumGray,
                      fontSize: 16,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: WidthButton(
                      text: 'Get Started',
                      onPressed: () {
                        Get.toNamed('/home');
                      },
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}