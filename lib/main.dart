import 'package:flutter/material.dart';
import 'package:sms_advanced/sms_advanced.dart';
import 'package:sms_app/sms_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMS App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SmsListScreen(),
    );
  }
}

class SmsDetailScreen extends StatelessWidget {
  final SmsMessage message;

  SmsDetailScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'From: ${message.address ?? 'Unknown'}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Message:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(message.body ?? 'No Content'),
          ],
        ),
      ),
    );
  }
}
