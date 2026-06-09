import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: TicTacToe(), debugShowCheckedModeBanner: false));
}

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tic Tac Toe")),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(
              9,
              (index) => Container(
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(border: Border.all()),
                child: Center(child: Text("", style: TextStyle(fontSize: 40))),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
