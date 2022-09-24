import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List todoList = [];
  final _myBox = Hive.box('myBox');
  void createInitalData() {
    todoList = [
      ['Duy Vo', false],
      ['Duy Vo', false],
      ['Duy Vo', false],
    ];
  }

  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  void updateData() {
    _myBox.put("TODOLIST", todoList);
  }
}
