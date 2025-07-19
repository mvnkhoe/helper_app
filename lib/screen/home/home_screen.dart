import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helper_app/screen/profile_page.dart';
import 'package:helper_app/screen/widgets/search_bar.dart';
import '../widgets/home_drawer.dart';
import '../widgets/build_tile.dart';
import '../widgets/carousel_screen.dart';
import '../widgets/home_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  final List<String> imageList = [
    'assets/images/carousel_1.jpeg',
    'assets/images/carousel_2.jpeg',
    'assets/images/carousel_3.jpeg',
  ];

  final List<String> carouselMessages = [
    "Your Future Begins Here. Start your application process now!",
    "Stay motivated! Every step you take brings you closer to your goal.",
    "Education is the key to your success. Follow the right path."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: Text(
          "EduBot",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2196F3), Color(0xFF0D47A1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: HomeWidgets(
            selectedIndex: _selectedIndex,
            imageList: imageList,
            carouselMessages: carouselMessages,
            searchController: _searchController),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF1565C0),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        unselectedLabelStyle: GoogleFonts.poppins(),
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1976D2),
        onPressed: () {
          Navigator.pushNamed(context, '/chat-assistant');
        },
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
        tooltip: 'Career Chat Assistant',
      ),
    );
  }
}
