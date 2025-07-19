import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class searchBar extends StatelessWidget {
  const searchBar({
    super.key,
    required TextEditingController searchController,
    required this.blue,
  }) : _searchController = searchController;

  final TextEditingController _searchController;
  final Color blue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: _searchController,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: blue),
          hintText: 'Search resources...',
          hintStyle: GoogleFonts.poppins(),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        ),
      ),
    );
  }
}
