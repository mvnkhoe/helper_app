import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import 'widgets/search_bar.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({Key? key}) : super(key: key);

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  final blue = Colors.blue.shade700;
  final lightBlue = Colors.blue.shade50;
  final TextEditingController _searchController = TextEditingController();

  // Sample data organized by sections
  final Map<String, List<Map<String, dynamic>>> allResources = {
    "Application Forms": [
      {
        'title': 'NUL Application Form',
        'desc':
            'Download the official National University of Lesotho admission form (PDF).',
        'url': 'https://www.nul.ls/downloads/admission-form.pdf',
        'isDownload': true,
      },
      {
        'title': 'Limkokwing Application Form',
        'desc': 'Download application form for Limkokwing Lesotho campus.',
        'url': 'https://lesotho.limkokwing.net/admissions/application-form.pdf',
        'isDownload': true,
      },
    ],
    "Prospectuses": [
      {
        'title': 'NUL Prospectus 2024',
        'desc': 'Complete guide to courses and requirements for NUL 2024.',
        'url': 'https://www.nul.ls/downloads/prospectus.pdf',
        'isDownload': true,
      },
      {
        'title': 'Lerotholi Polytechnic Prospectus',
        'desc': 'Detailed program info and admission criteria.',
        'url': 'https://lerotholi.edu.ls/downloads/prospectus.pdf',
        'isDownload': true,
      },
    ],
    "Guides & Scholarships": [
      {
        'title': 'How to Write a Motivation Letter',
        'desc': 'Step-by-step guide with examples.',
        'url': 'https://www.studylesotho.org/motivation-letter',
        'isDownload': false,
      },
      {
        'title': 'Scholarship Opportunities in Lesotho',
        'desc': 'Find scholarships for high school graduates.',
        'url': 'https://www.studylesotho.org/scholarships',
        'isDownload': false,
      },
    ],
  };

  Map<String, List<Map<String, dynamic>>> filteredResources = {};

  @override
  void initState() {
    super.initState();
    filteredResources = allResources;
    _searchController.addListener(_filterResources);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterResources() {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        filteredResources = allResources;
      });
      return;
    }

    final Map<String, List<Map<String, dynamic>>> tempFiltered = {};
    allResources.forEach((section, items) {
      final filteredItems = items.where((item) {
        final title = item['title'].toString().toLowerCase();
        final desc = item['desc'].toString().toLowerCase();
        return title.contains(query) || desc.contains(query);
      }).toList();
      if (filteredItems.isNotEmpty) {
        tempFiltered[section] = filteredItems;
      }
    });

    setState(() {
      filteredResources = tempFiltered;
    });
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open the link')),
      );
    }
  }

  Widget _buildResourceCard(Map<String, dynamic> item) {
    final isDownload = item['isDownload'] as bool;
    final blueAccent = blue;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        leading: Icon(
          isDownload ? Icons.file_download : Icons.link,
          color: blueAccent,
          size: 30,
        ),
        title: Text(
          item['title'],
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 16, color: blueAccent),
        ),
        subtitle: Text(
          item['desc'],
          style: GoogleFonts.poppins(),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.copy, color: blueAccent),
              tooltip: 'Copy Link',
              onPressed: () {
                Clipboard.setData(ClipboardData(text: item['url']));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Link copied to clipboard')),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.open_in_new, color: blueAccent),
              tooltip: isDownload ? 'Download' : 'Open Link',
              onPressed: () => _launchURL(item['url']),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        backgroundColor: blue,
        title: Text('Resources',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 22)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            searchBar(searchController: _searchController, blue: blue),

            // Resource list
            Expanded(
              child: filteredResources.isEmpty
                  ? Center(
                      child: Text(
                        'No resources found.',
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.grey.shade700),
                      ),
                    )
                  : ListView(
                      children: filteredResources.entries.map((section) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                section.key,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: blue,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...section.value.map(_buildResourceCard).toList(),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
