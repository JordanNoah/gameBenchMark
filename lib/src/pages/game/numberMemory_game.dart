import 'package:flutter/material.dart';

class NumberMemory extends StatefulWidget {
  NumberMemory({Key key}) : super(key: key);

  @override
  _NumberMemoryState createState() => _NumberMemoryState();
}

class _NumberMemoryState extends State<NumberMemory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text("_NumberMemoryState")),
    );
  }
}
