import 'package:flutter/material.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({super.key});

  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  String selectedLanguage = 'Device Language';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Languages',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildLanguageOption('Device Language'),
          _buildLanguageOption('English'),
          _buildLanguageOption('Hindi'),
          _buildLanguageOption('Malayalam'),
          _buildLanguageOption('Tamil'),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String language) {
    return ListTile(
      title: Text(
        language,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Radio<String>(
        value: language,
        groupValue: selectedLanguage,
        activeColor: Colors.orange,
        onChanged: (String? value) {
          setState(() {
            selectedLanguage = value!;
          });
        },
      ),
    );
  }
}
