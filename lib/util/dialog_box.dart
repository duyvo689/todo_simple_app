import 'package:flutter/material.dart';
import 'package:todo_simple_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  DialogBox(
      {Key? key,
      required this.controller,
      required this.onCancel,
      required this.onSave})
      : super(key: key);

  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue[100],
      content: Container(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add anew task",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                    text: 'Cancel',
                    onPressed: () {
                      onCancel();
                    }),
                const SizedBox(width: 10),
                MyButton(
                    text: 'Add',
                    onPressed: () {
                      onSave();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
