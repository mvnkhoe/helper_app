import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Colors.blue.shade800;
    final textColor = isDark ? Colors.white : Colors.grey.shade800;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          'Student Tips',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Tertiary Success Tips in Lesotho',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Advice for thriving academically, financially, and socially at institutions like NUL, Limkokwing, and LCE.',
              style: GoogleFonts.poppins(fontSize: 14, color: textColor),
            ),
            const SizedBox(height: 24),

            ..._buildCategory(
              title: '🏫 Academic Tips',
              tips: [
                'Understand the credit hour system at institutions like NUL.',
                'Official registration is mandatory each semester.',
                'Missing fee deadlines can prevent exam access.',
                'Master using library resources (e.g. Thomas Mofolo Library at NUL).',
              ],
            ),

            ..._buildCategory(
              title: '💸 Financial & Scholarship Tips',
              tips: [
                'Apply for NMDS early with all required documents.',
                'Acceptance doesn’t guarantee NMDS funding — apply separately.',
                'Budget for data, food, rent, and printing beyond NMDS stipend.',
              ],
            ),

            ..._buildCategory(
              title: '🧾 Application & Admin Tips',
              tips: [
                'Apply online via official portals (e.g., nul.ls, lce.ac.ls).',
                'Admission does not include accommodation — apply separately.',
                'Check your email regularly for updates and offers.',
              ],
            ),

            ..._buildCategory(
              title: '💬 Social & Cultural Tips',
              tips: [
                'Expect culture shock if you’re from rural areas — ask for help.',
                'Group work is common — manage your role and contributions.',
                'Stay true to yourself amid peer pressure and new freedoms.',
              ],
            ),

            ..._buildCategory(
              title: '🌐 Digital & Connectivity Tips',
              tips: [
                'Use campus Wi-Fi (e.g. Eduroam) to save on data.',
                'Know your student portal and how to check registration/exams.',
                'Save assignments often — power cuts are common.',
              ],
            ),

            ..._buildCategory(
              title: '💼 Career & Growth Tips',
              tips: [
                'Attend career fairs and join clubs to build your profile.',
                'Take internships, part-time or volunteer roles.',
                'Start building a CV early — a degree alone isn’t enough.',
              ],
            ),

            ..._buildCategory(
              title: '🧠 Mental Health & Well-being',
              tips: [
                'Use free campus counseling when you feel overwhelmed.',
                'Keep in touch with family to fight homesickness.',
                'Balance academics, social life, and rest — avoid burnout.',
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCategory({required String title, required List<String> tips}) {
    return [
      Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade800,
        ),
      ),
      const SizedBox(height: 10),
      ...tips.map((tip) => Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ExpansionTile(
          leading: Icon(Icons.lightbulb_outline, color: Colors.blue.shade600),
          title: Text(
            tip.length > 60 ? tip.substring(0, 60) + '...' : tip,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(tip, style: GoogleFonts.poppins(fontSize: 14)),
            ),
          ],
        ),
      )),
      const SizedBox(height: 24),
    ];
  }
}
