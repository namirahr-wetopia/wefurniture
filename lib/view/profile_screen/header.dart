// profile_header.dart
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return Container(
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: h * 0.048, vertical: h * 0.027),
        child: Column(
          children: [
            Text('My Profile', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24, fontFamily:'Inter')),
            SizedBox(height: 20),
            Stack(
              children: [
                CircleAvatar(
                  radius: w * 0.097,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  height: h * 0.033,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkGray.withAlpha(230),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt_outlined, size: 16,color: Colors.white,),
                      onPressed: () {},
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.013),
            const Text('Michael Leanon', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, fontFamily: 'Inter')),
            Text('michaeilean42@gmail.com', style: TextStyle(color: AppColors.mediumGray, fontSize: 16,  fontFamily: 'Inter')),
            SizedBox(height: h *0.026),
          ],
        ),
      ),
    );
  }
}
