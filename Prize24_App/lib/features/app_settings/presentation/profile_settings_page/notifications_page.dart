import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<Map<String, dynamic>> settings = [
    {'title': 'Show Notifications', 'value': true},
    {'title': 'Allow Sound', 'value': false},
    {'title': 'Alert Expiry', 'value': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          ...settings.asMap().entries.map((entry) {
            final idx = entry.key;
            final setting = entry.value;
            return Column(
              children: [
                SwitchListTile(
                  title: Text(
                    setting['title'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  value: setting['value'] as bool,
                  onChanged: (value) {
                    setState(() {
                      setting['value'] = value;
                    });
                  },
                  activeColor: Colors.white,
                  activeTrackColor: Colors.orange,
                ),
                if (idx == 0 || idx == 2)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    child: Divider(color: Colors.grey[800]),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
