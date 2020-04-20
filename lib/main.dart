import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Waktu Solat Evo'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Text(
            'Hello Bros',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.grey,
                fontFamily: 'JetBrainsMono'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text('click'),
          onPressed: () {},
          backgroundColor: Colors.red[600],
        ),
      ),
    ));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
