import 'package:flutter/material.dart';
import 'package:sms_advanced/sms_advanced.dart';

class NewSmsScreen extends StatefulWidget {
  @override
  _NewSmsScreenState createState() => _NewSmsScreenState();
}

class _NewSmsScreenState extends State<NewSmsScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  void _sendSms() {
    String phone = _phoneController.text;
    String message = _messageController.text;

    SmsSender sender = SmsSender();
    SmsMessage sms = SmsMessage(phone, message);

    sender.sendSms(sms);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Message sent to $phone')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send New SMS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Message',
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendSms,
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
