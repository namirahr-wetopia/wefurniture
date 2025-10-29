import 'package:flutter/material.dart';
import 'tile.dart';
import 'section.dart';
import 'header.dart';
import '../theme/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body:SafeArea(
        child:CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: ProfileHeader()),
            Section(
              title: 'Account',
              tiles: const [
                ProfileOption(icon: Icons.settings, color: Color(0xFF6B7280), title: 'Settings'),
                ProfileOption(icon: Icons.notifications_none, color: Color(0xFF22C3E6), title: 'Notifications'),
                ProfileOption(icon: Icons.receipt_long, color: Color(0xFFF59E0B), title: 'Order History'),
              ],
            ),
            Section(
              title: 'General',
              tiles: const [
                ProfileOption(icon: Icons.lock_outline, color: Color(0xFF60A5FA), title: 'Privacy & Policy'),
                ProfileOption(icon: Icons.article_outlined, color: Color(0xFFF59E0B), title: 'Terms & Conditions'),
                ProfileOption(
                  icon: Icons.logout,
                  color: Color(0xFFEF4444),
                  title: 'Log Out',
            ),
          ],
        ),
        ]
      )
    ),
    );
  }
  
}