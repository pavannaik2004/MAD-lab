import 'package:flutter/material.dart';

void main() {
  runApp(CounterWithHistoryApp());
}

class CounterWithHistoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter with History',
      home: CounterHistoryPage(),
    );
  }
}

class CounterHistoryPage extends StatefulWidget {
  @override
  _CounterHistoryPageState createState() => _CounterHistoryPageState();
}

class _CounterHistoryPageState extends State<CounterHistoryPage> {
  int _counter = 0;
  List<int> _history = [0]; // Start with initial value in the history

  void _increment() {
    setState(() {
      _counter++;
      _history.add(_counter);
    });
  }

  void _decrement() {
    setState(() {
      _counter--;
      _history.add(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Counter with History',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Current Value: $_counter',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _increment,
                  child: Text('Increment'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _decrement,
                  child: Text('Decrement'),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Value History:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text('#${index + 1}'),
                    title: Text('Value: ${_history[index]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
