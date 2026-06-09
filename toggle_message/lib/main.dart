import 'package:flutter/material.dart';

void main() {
  runApp(MessageToggleApp());
}

class MessageToggleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Message Toggle',
      home: MessageToggleHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MessageToggleHome extends StatefulWidget {
  @override
  _MessageToggleHomeState createState() => _MessageToggleHomeState();
}

class _MessageToggleHomeState extends State<MessageToggleHome> {
  bool _showhello = true;

  void _toggleMessage() {
    setState(() {
      _showhello = !_showhello;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message Toggle app'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite),
            Text(
              _showhello ? 'RV Collge of engg' : 'Go Change the world',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _toggleMessage,
              child: Text('Toggle Message'),
            ),
          ],
        ),
      ),
    );
  }
}
