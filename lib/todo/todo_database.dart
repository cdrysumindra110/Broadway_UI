import 'package:broadway_example_ui/database/database.dart';
import 'package:broadway_example_ui/todo/todo_model.dart';

class TodoDatabase {
  
  final dbHelper = DBHelper.instance;
  
  Future<int> insertTodo(TodoModel todo) async {
    final db = await dbHelper.database;
    return db.insert("Todo", todo.toJson());
  }

  Future<List<TodoModel>> getTodos() async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> data = await db.query("Todo");
    return data.map((e) => TodoModel.fromJson(e)).toList();
  }

  Future<int> delete(int id) async {
    final db = await dbHelper.database;
    return db.delete("Todo", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(TodoModel todo) async {
    final db = await dbHelper.database;
    return await db.update(
      "Todo", 
      todo.toJson(), 
      where: 'id = ?', 
      whereArgs: [todo.id],
    );
  }
}