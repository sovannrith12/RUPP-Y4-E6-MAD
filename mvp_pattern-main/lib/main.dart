import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/add_project_screen.dart';

void main() {
  runApp(MvpTodoApp());
}

class MvpTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MVP Todo Example",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => HomeScreen(),
        '/add_project': (context) => AddProjectScreen(),
      },
      initialRoute: '/',
    );
  }
}
