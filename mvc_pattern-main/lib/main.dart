import 'package:flutter/material.dart';
import 'views/home_screen.dart';
import 'views/add_project_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MVC To-Do App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const HomeScreen(),
      routes: {
        '/add_project': (_) => const AddProjectScreen(),
      },
    );
  }
}
