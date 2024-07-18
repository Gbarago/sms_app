import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_advanced/sms_advanced.dart';
import 'package:sms_app/main.dart';
import 'package:sms_app/new_sms_screen.dart';

class SmsListScreen extends StatefulWidget {
  @override
  _SmsListScreenState createState() => _SmsListScreenState();
}

class _SmsListScreenState extends State<SmsListScreen> {
  List<SmsMessage> messages = [];
  SmsReceiver receiver = SmsReceiver();

  @override
  void initState() {
    super.initState();
    _querySms();
    _listenForSms();
    _requestPermissions();
  }

  void _querySms() async {
    SmsQuery query = SmsQuery();
    List<SmsMessage> smsList = await query.getAllSms;
    setState(() {
      messages = smsList;
    });
  }

  void _listenForSms() {
    receiver.onSmsReceived?.listen((SmsMessage message) {
      setState(() {
        messages.insert(0, message); // Add new message to the top of the list
      });
    });
  }

  void _requestPermissions() async {
    if (await Permission.sms.request().isGranted) {
      _querySms();
      _listenForSms();
    } else {
      // Handle permission denial
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('SMS permission denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SMS Messages'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(messages[index].address ?? 'Unknown'),
            subtitle: Text(messages[index].body ?? 'No Content'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SmsDetailScreen(message: messages[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewSmsScreen(),
            ),
          );
        },
      ),
    );
  }
}
