import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive/theme/theme_provider.dart';
import 'package:todo_hive/views/home.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("myBox");
  await Hive.openBox('theme');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      builder: (context, child) => MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var box = Hive.box("theme");

  @override
  void initState() {
    if (box.get("data") == null) {
      Provider.of<ThemeProvider>(context, listen: false).firstCreate();
      // context.watch<ThemeProvider>().firstCreate();
    } else {
      Provider.of<ThemeProvider>(context, listen: false).loadTheme();
      // context.watch<ThemeProvider>().loadTheme();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child) => MaterialApp(
        title: 'ToDo App Hive',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: value.dark ? Brightness.dark : Brightness.light,
          primaryColor: Colors.orange,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.orange[400],
          ),
          scaffoldBackgroundColor: value.dark ? Color.fromRGBO(28, 28, 28, 1) : Colors.orange[200],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.orange[400],
            titleTextStyle: TextStyle(fontWeight: FontWeight.bold, color: value.dark ? Colors.white : Colors.black, fontSize: 30),
            iconTheme: IconThemeData(size: 30),
          ),
          useMaterial3: true,
        ),
        home: Home(),
      ),
    );

    // return MaterialApp(
    //   title: 'ToDo App Hive',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     primaryColor: Colors.orange,
    //     scaffoldBackgroundColor: Colors.orange[200],
    //     floatingActionButtonTheme: FloatingActionButtonThemeData(
    //       backgroundColor: Colors.orange[400],
    //     ),
    //     appBarTheme: AppBarTheme(
    //       elevation: 1,
    //       backgroundColor: Colors.orange[400],
    //       titleTextStyle: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
    //       iconTheme: IconThemeData(
    //         // color: Colors.white,
    //         size: 35,
    //       ),
    //     ),
    //     useMaterial3: true,
    //   ),
    //   home: Home(),
    // );
  }
}
