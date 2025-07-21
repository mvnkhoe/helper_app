import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicationGuideScreen extends StatelessWidget {
  const ApplicationGuideScreen({super.key});

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Colors.blue.shade800;
    final backgroundColor = isDark ? Colors.grey.shade900 : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Application Guide',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Header
            Text(
              'How to Apply for University or College',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Follow these steps to successfully apply for tertiary education in Lesotho.',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: isDark ? Colors.grey[300] : Colors.grey[800],
              ),
            ),
            const SizedBox(height: 24),

            // Steps
            ..._applicationSteps(primaryColor),

            const SizedBox(height: 30),

            // FAQs
            Text(
              'Frequently Asked Questions',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            _buildFAQ('What if I didn’t pass Mathematics?',
                'You can apply for programs that do not require Math or consider upgrading your results.'),
            _buildFAQ('When are the application periods?',
                'Most institutions open applications between July and November for the January intake.'),
            _buildFAQ('Can I apply to more than one institution?',
                'Yes. It’s wise to apply to multiple universities or colleges to increase your chances.'),
            _buildFAQ('Do I need internet to apply?',
                'Most institutions offer both online and physical application options.'),

            const SizedBox(height: 30),

            // Useful Links
            Text(
              'Useful Links',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            _buildLinkTile(
              title: 'National University of Lesotho',
              url: 'https://www.nul.ls',
              color: primaryColor,
            ),
            _buildLinkTile(
              title: 'Limkokwing University Lesotho',
              url: 'https://www.limkokwing.net/lesotho',
              color: primaryColor,
            ),
            _buildLinkTile(
              title: 'Lesotho College of Education',
              url: 'https://www.lce.ac.ls/',
              color: primaryColor,
            ),
            _buildLinkTile(
              title: 'Apply Lesotho Portal (if available)',
              url: 'https://apply.lesotho.gov.ls',
              color: primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _applicationSteps(Color primaryColor) {
    final steps = [
      {
        'title': '1. Choose your program',
        'subtitle': 'Research what course aligns with your interests and career goals.',
      },
      {
        'title': '2. Check entry requirements',
        'subtitle': 'Make sure you meet the minimum grades and required subjects.',
      },
      {
        'title': '3. Prepare documents',
        'subtitle': 'Gather your national ID, transcripts, passport photo, and any certificates.',
      },
      {
        'title': '4. Apply online or in person',
        'subtitle': 'Visit the institution’s website or go directly to the admissions office.',
      },
      {
        'title': '5. Pay the application fee',
        'subtitle': 'Ensure you pay before the deadline and keep the receipt.',
      },
      {
        'title': '6. Wait for response',
        'subtitle': 'You may receive a letter, SMS, or email. Some programs require interviews or tests.',
      },
      {
        'title': '7. Register & prepare',
        'subtitle': 'If accepted, register, apply for accommodation, and prepare to begin your studies.',
      },
    ];

    return steps
        .map(
          (step) => Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(Icons.check_circle_outline,
                  color: primaryColor, size: 28),
              title: Text(
                step['title']!,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                step['subtitle']!,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ),
          ),
        )
        .toList();
  }

  Widget _buildFAQ(String question, String answer) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: ExpansionTile(
        title: Text(
          question,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              answer,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLinkTile({
    required String title,
    required String url,
    required Color color,
  }) {
    return ListTile(
      leading: Icon(Icons.link, color: color),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 14, color: color),
      ),
      onTap: () => _launchURL(url),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
    );
  }
}
