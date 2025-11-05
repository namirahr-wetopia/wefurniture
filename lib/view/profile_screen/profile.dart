import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../nav.dart';
import 'tile.dart';
import 'section.dart';
import 'header.dart';
import '../theme/colors.dart';
import '../../data/remote/services/auth_service.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:get/get.dart';

@injectable
class ProfileScreen extends StatelessWidget {
  final AuthService authService;
  const ProfileScreen({Key? key, required this.authService}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final email = authService.email ?? 'No email';
    final name = authService.name ?? 'No name';
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body:SafeArea(
        child:CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: ProfileHeader(name: name, email: email)),
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
              tiles: [
                ProfileOption(icon: Icons.lock_outline, color: Color(0xFF60A5FA), title: 'Privacy & Policy'),
                ProfileOption(icon: Icons.article_outlined, color: Color(0xFFF59E0B), title: 'Terms & Conditions'),
                ProfileOption(
                  icon: Icons.logout,
                  color: Color(0xFFEF4444),
                  title: 'Log Out',
                  onTap: () async {
                    final authService = GetIt.I<AuthService>();
                    await authService.signOut();
                    Get.offAllNamed('/login');
                  },
            ),
          ],
        ),
        ]
      )
    ),
    bottomNavigationBar: const AppBottomNavBar(currentIndex:4 ),
    );
  }
  
}