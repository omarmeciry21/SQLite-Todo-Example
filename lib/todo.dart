import 'package:sqlite_example/todo_provider.dart';

class Todo {
  int? id;
  late String name;
  late int date;
  late bool isChecked;

  Todo({
    this.id,
    required this.name,
    required this.date,
    required this.isChecked,
  });

  Todo.fromMap(Map<String, dynamic> map) {
    if (map[columnId] != null) this.id = map[columnId];
    this.name = map[columnName];
    this.date = map[columnDate];
    this.isChecked = map[columnIsChecked] == 0 ? false : true;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (this.id != null) map[columnId] = this.id;
    map[columnName] = this.name;
    map[columnDate] = this.date;
    map[columnIsChecked] = this.isChecked ? 1 : 0;
    return map;
  }
}
