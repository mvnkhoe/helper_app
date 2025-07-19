import 'package:flutter/material.dart';
import 'package:helper_app/screen/profile_page.dart';
import 'package:helper_app/screen/widgets/carousel_screen.dart';

import 'search_bar.dart';

class HomeWidgets extends StatelessWidget {
  const HomeWidgets({
    super.key,
    required int selectedIndex,
    required this.imageList,
    required this.carouselMessages,
    required TextEditingController searchController,
  })  : _selectedIndex = selectedIndex,
        _searchController = searchController;

  final int _selectedIndex;
  final List<String> imageList;
  final List<String> carouselMessages;
  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _selectedIndex == 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Carousel(
                      imageList: imageList,
                      carouselMessages: carouselMessages,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Explore Options",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Grid(), // Stylized below
                ],
              )
            : Center(
                child: _selectedIndex == 1
                    ? searchBar(
                        searchController: _searchController, blue: Colors.blue)
                    : ProfilePage(),
              ),
      ),
    );
  }
}

class Grid extends StatelessWidget {
  const Grid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
        return GridView.count(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _tile(context, 'Application Guide', Icons.article,
                '/application-guide'),
            _tile(context, 'Enter Grades', Icons.grade, '/enter-grades'),
            _tile(context, 'Suggestions', Icons.school, '/suggestions'),
            _tile(context, 'Resources', Icons.folder, '/resources'),
            _tile(context, 'Tips & Advice', Icons.lightbulb, '/tips'),
          ],
        );
      },
    );
  }

  Widget _tile(
      BuildContext context, String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF90CAF9), Color(0xFF42A5F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
