import 'package:flutter/material.dart';
import 'package:exam_project/views/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox('favorites');
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
        HomePage.route: (context) => const HomePage()
      },
      initialRoute: HomePage.route,
    );
  }
}