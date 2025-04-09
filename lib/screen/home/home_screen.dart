import 'package:flutter/material.dart';

import '../application_guide_screen.dart';
import '../chat_assistant_screen.dart';
import '../enter_grates_screen.dart';
import '../resources_screen.dart';
import '../suggestions_screen.dart';
import '../tips_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Helper App')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Student Name'),
              accountEmail: Text('student@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.black),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            ListTile(
              leading: const Icon(Icons.app_registration),
              title: const Text('Sign Up'),
              onTap: () {
                Navigator.pushNamed(context, '/signup');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Add logout logic here
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _selectedIndex == 0
            ? LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildTile(context, 'Application Guide', Icons.article,
                          '/application-guide'),
                      _buildTile(context, 'Enter Grades', Icons.grade,
                          '/enter-grades'),
                      _buildTile(
                          context, 'Suggestions', Icons.school, '/suggestions'),
                      _buildTile(
                          context, 'Resources', Icons.folder, '/resources'),
                      _buildTile(
                          context, 'Tips & Advice', Icons.lightbulb, '/tips'),
                    ],
                  );
                },
              )
            : Center(
                child: Text(
                  _selectedIndex == 1
                      ? 'Suggestions and Guidance'
                      : 'Other content for section $_selectedIndex',
                  style: TextStyle(fontSize: 20),
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Suggestions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Resources',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/chat-assistant');
        },
        child: const Icon(Icons.chat),
        tooltip: 'Chat Assistant',
        backgroundColor: Colors.indigo,
      ),
    );
  }

  Widget _buildTile(
      BuildContext context, String title, IconData icon, String route) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.indigo),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.width > 600 ? 18 : 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
