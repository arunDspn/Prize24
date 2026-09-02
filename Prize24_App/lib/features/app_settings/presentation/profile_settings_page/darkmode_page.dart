import 'package:flutter/material.dart';

class DarkModePage extends StatefulWidget {
  const DarkModePage({super.key});

  @override
  _DarkModePageState createState() => _DarkModePageState();
}

class _DarkModePageState extends State<DarkModePage> {
  int _selectedOption = 2;

  final List<Map<String, dynamic>> _options = [
    {'value': 0, 'title': 'On'},
    {'value': 1, 'title': 'Off'},
    {'value': 2, 'title': 'Use system settings', 'isDescription': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Dark mode',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        children: _options.map(_buildOption).toList(),
      ),
    );
  }

  Widget _buildOption(Map<String, dynamic> option) {
    return ListTile(
      title: Text(
        option['title'] as String,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: option['isDescription'] == true
          ? Text(
              "We'll adjust your appearance based on your device’s system settings.",
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 14,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w500,
              ),
            )
          : null,
      trailing: Radio<int>(
        value: option['value'] as int,
        groupValue: _selectedOption,
        activeColor: Colors.orange,
        onChanged: (int? newValue) {
          setState(() {
            _selectedOption = newValue!;
          });
        },
      ),
    );
  }
}
