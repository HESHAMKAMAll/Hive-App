import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive/views/home.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox("myBox");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App Hive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.orange[200],
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.orange[400],
        ),
        appBarTheme: AppBarTheme(
          elevation: 1,
          backgroundColor: Colors.orange[400],
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(
            // color: Colors.white,
            size: 35,
          ),
        ),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}
