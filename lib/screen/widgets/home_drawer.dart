import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF0D47A1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              accountName: Text(
                user?.displayName ?? 'Guest User',
                style: GoogleFonts.poppins(),
              ),
              accountEmail: Text(
                user?.email ?? 'guest@example.com',
                style: GoogleFonts.poppins(),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.black54),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.login,
              text: 'Login',
              onTap: () => Navigator.pushNamed(context, '/signin'),
            ),
            _buildDrawerItem(
              icon: Icons.app_registration,
              text: 'Sign Up',
              onTap: () => Navigator.pushNamed(context, '/signup'),
            ),
            _buildDrawerItem(
              icon: Icons.settings,
              text: 'Settings',
              onTap: () {},
            ),
            _buildDrawerItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/signin');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(text, style: GoogleFonts.poppins()),
      onTap: onTap,
    );
  }
}
