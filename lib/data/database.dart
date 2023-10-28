import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];
  final myBox = Hive.box("myBox");

  void createInitialData() async {
    toDoList = [
      ["Make Tutorial", false],
      ["Do Exercise", false],
    ];
  }

  void loadData() async {
    toDoList = myBox.get("TODOLIST");
  }

  void uploadData() async {
    myBox.put("TODOLIST", toDoList);
  }
}
