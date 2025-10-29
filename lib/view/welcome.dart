import 'package:flutter/material.dart';
import 'theme/colors.dart';
import 'package:go_router/go_router.dart';
import 'widgets/theme_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(w * 0.039),
                bottomRight: Radius.circular(w * 0.039),
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
              padding: EdgeInsets.fromLTRB(w * 0.048, h * 0.0247, w * 0.048, h * 0.013),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enjoy Your Online\nShopping.',
                    style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkestGray,
                          fontSize:  h * 0.029,
                          fontFamily: 'Inter'
                        ),
                  ),
                  SizedBox(height:  h * 0.011),
                  Text(
                    'Browse through all categories and shop the best furniture for your dream house.',
                    style: TextStyle(
                          color: AppColors.mediumGray,
                          fontSize: 16,
                          fontFamily: 'Inter'
                        ),
                  ),
                  SizedBox(height:  h * 0.0300),
                  SizedBox(
                    width: double.infinity,
                    height: h * 0.058,
                    child: WidthButton(
                      text: 'Get Started',
                      onPressed: () => context.go('/home'),
                    ),
                  ),
                  SizedBox(height: h * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
