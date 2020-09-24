import 'package:flutter/material.dart';

class MemoryTest extends StatefulWidget {
  MemoryTest({Key key}) : super(key: key);

  @override
  _MemoryTestState createState() => _MemoryTestState();
}

class _MemoryTestState extends State<MemoryTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text("_MemoryTestState")),
    );
  }
}
