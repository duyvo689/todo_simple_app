import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_simple_app/data/database.dart';
import 'package:todo_simple_app/util/dialog_box.dart';
import 'package:todo_simple_app/util/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box('myBox');
  final _controller = TextEditingController();
  ToDoDatabase db = new ToDoDatabase();

  @override
  void initState() {
    // TODO: implement initState
    if (_mybox.get('TODOLIST') == null) {
      db.createInitalData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateData();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onCancel: () {
              Navigator.of(context).pop();
            },
            onSave: () {
              saveNewTask();
            },
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To do'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: ((context, index) {
          return TodoList(
            onChanged: (value) {
              checkBoxChanged(value, index);
            },
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            deleteFuntion: (context) => deleteTask(index),
          );
        }),
      ),
    );
  }
}
