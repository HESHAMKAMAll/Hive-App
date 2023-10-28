import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive/data/database.dart';
import '../theme/theme_provider.dart';
import '../widgets/dialog_box.dart';
import '../widgets/todo_tile.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final myBox = Hive.box("myBox");
  ToDoDatabase db = ToDoDatabase();
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo hive app"),
        leading: Icon(Icons.hive_outlined),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, value, child) => IconButton(
              onPressed: () {
                value.changeTheme();
              },
              icon: Icon(Icons.mode_night),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, i) => ToDoTile(
          task: db.toDoList[i][0],
          check: db.toDoList[i][1],
          onChanged: (value) {
            setState(() {
              db.toDoList[i][1] = value;
            });
            db.uploadData();
          },
          delete: (context) {
            db.toDoList.removeAt(i);
            setState(() {});
            db.uploadData();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => DialogBox(
                    controller: controller,
                    onSave: () {
                      if (controller.text.isNotEmpty) {
                        db.toDoList.add([controller.text, false]);
                        setState(() {});
                        controller.clear();
                        Navigator.pop(context);
                        db.uploadData();
                      }
                    },
                  ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
