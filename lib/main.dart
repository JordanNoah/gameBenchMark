import 'package:flutter/material.dart';
import 'package:reactiongame_frontend/route_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game',
      debugShowCheckedModeBanner: false,
      initialRoute: '/listGame',
      onGenerateRoute: RouterGenerator.generateRoute,
    );
  }
}
