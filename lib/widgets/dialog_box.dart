import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  DialogBox({super.key,required this.controller,required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          hintText: "Add a New Task",
        ),
      ),
      actions: [
        CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.orange[100],
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/11),
          // style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[100]),
          child: Text("Cancel", style: TextStyle(color: Colors.red)),
        ),
        CupertinoButton(
          onPressed: onSave,
          color: Colors.orange[100],
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8),
          // style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[100]),
          child: Text("Save", style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
