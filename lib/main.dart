import 'package:flutter/material.dart';
import 'package:exam_project/views/home_page.dart';
import 'package:exam_project/views/detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix Clone',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      routes: {
        HomePage.route: (context) => const HomePage(),
        DetailPage.route: (context) => const DetailPage()
      },
      initialRoute: HomePage.route,
    );
  }
}