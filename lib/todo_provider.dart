import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_example/todo.dart';

final String columnId = 'id';
final String columnName = 'name';
final String columnDate = 'date';
final String columnIsChecked = 'isChecked';
final String todoTable = 'todo_table';

class TodoProvider {
  late Database db;

  static final TodoProvider instance = TodoProvider._internal();

  factory TodoProvider() {
    return instance;
  }

  TodoProvider._internal();

  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'todos.db'),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
create table $todoTable ( 
  $columnId integer primary key autoincrement, 
  $columnName text not null,
  $columnDate integer not null,
  $columnIsChecked integer not null
  )
''');
    });
  }

  Future<Todo> insertTodo(Todo todo) async {
    todo.id = await db.insert(todoTable, todo.toMap());
    return todo;
  }

  Future<int> deleteTodo(int id) async {
    return await db.delete(todoTable, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateTodo(Todo todo) async {
    return await db.update(todoTable, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future<List<Todo>> getAllTodo() async {
    List<Map<String, dynamic>> todoMaps = await db.query(todoTable);
    if (todoMaps.length == 0)
      return [];
    else {
      List<Todo> todos = [];
      todoMaps.forEach((element) {
        todos.add(Todo.fromMap(element));
      });
      return todos;
    }
  }

  Future close() async => db.close();
}
