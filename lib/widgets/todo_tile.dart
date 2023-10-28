import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class ToDoTile extends StatelessWidget {
  final String task;
  final bool check;
  Function(bool?)? onChanged;
  Function(BuildContext)? delete;

  ToDoTile({
    super.key,
    required this.task,
    required this.check,
    required this.onChanged,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 5),
      child: Slidable(
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              borderRadius: BorderRadius.circular(12),
              // flex: 2,
              onPressed: delete,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete_outline,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          height: 80,
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Consumer<ThemeProvider>(
                builder: (context, value, child) => Checkbox(
                  activeColor: Colors.transparent,
                  checkColor: value.dark? Colors.white: Colors.black,
                  value: check,
                  onChanged: onChanged,
                ),
              ),
              Text(task, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,decoration: check? TextDecoration.lineThrough:TextDecoration.none)),
            ],
          ),
        ),
      ),
    );
  }
}
