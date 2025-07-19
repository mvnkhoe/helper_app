import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnterGradesScreen extends StatefulWidget {
  @override
  _EnterGradesScreenState createState() => _EnterGradesScreenState();
}

class _EnterGradesScreenState extends State<EnterGradesScreen> {
  final _formKey = GlobalKey<FormState>();

  final subject1Controller = TextEditingController();
  final subject2Controller = TextEditingController();
  final subject3Controller = TextEditingController();
  final subject4Controller = TextEditingController();
  DateTime? completionDate;

  final List<String> allInterests = [
    'Engineering',
    'Science',
    'Medicine',
    'Law',
    'IT',
    'Accounting',
    'Education',
    'Arts',
    'Agriculture',
  ];
  List<String> selectedInterests = [];

  Color blue = Colors.blue.shade800;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: blue,
        title: Text("Academic Info Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTitle("Enter Subjects & Grades"),
              _buildTextField(subject1Controller, "Subject 1 (e.g. Math: A)"),
              _buildTextField(subject2Controller, "Subject 2"),
              _buildTextField(subject3Controller, "Subject 3"),
              _buildTextField(subject4Controller, "Subject 4"),
              SizedBox(height: 20),
              _buildTitle("Select Your Interests"),
              Wrap(
                spacing: 8,
                children: allInterests.map((interest) {
                  final selected = selectedInterests.contains(interest);
                  return ChoiceChip(
                    label: Text(interest),
                    selected: selected,
                    selectedColor: blue.withOpacity(0.8),
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : blue,
                    ),
                    backgroundColor: Colors.grey[200],
                    onSelected: (isSelected) {
                      setState(() {
                        isSelected
                            ? selectedInterests.add(interest)
                            : selectedInterests.remove(interest);
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 24),
              _buildTitle("High School Completion Date"),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Select date',
                  ),
                  child: Text(
                    completionDate == null
                        ? 'Select date'
                        : '${completionDate!.day}/${completionDate!.month}/${completionDate!.year}',
                  ),
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Submit Info"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(text,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: blue)),
      );

  Widget _buildTextField(TextEditingController controller, String label) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
          validator: (value) =>
              value == null || value.isEmpty ? 'This field is required' : null,
        ),
      );

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2022),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        completionDate = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() &&
        completionDate != null &&
        selectedInterests.isNotEmpty) {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("User not signed in"),
        ));
        return;
      }

      final data = {
        'subjects': [
          subject1Controller.text,
          subject2Controller.text,
          subject3Controller.text,
          subject4Controller.text,
        ],
        'interests': selectedInterests,
        'completionDate': completionDate!.toIso8601String(),
        'submittedAt': DateTime.now().toIso8601String(),
      };

      await FirebaseFirestore.instance
          .collection('students')
          .doc(user.uid)
          .set(data, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Information saved successfully"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please complete all required fields"),
      ));
    }
  }

  @override
  void dispose() {
    subject1Controller.dispose();
    subject2Controller.dispose();
    subject3Controller.dispose();
    subject4Controller.dispose();
    super.dispose();
  }
}
