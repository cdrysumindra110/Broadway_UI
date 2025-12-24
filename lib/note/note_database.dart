import 'package:broadway_example_ui/database/database.dart';
import 'package:broadway_example_ui/note/note_model.dart';

class NoteDatabase {
  final db = DBHelper.instance;

  Future<int> insert(NoteModel note) async {
    final database = await db.database;
    return database.insert(NoteModel.tableName, note.toJson());
  }

Future<List<NoteModel>> getData() async {
  final database = await db.database;
  // Use NoteModel.tableName instead of "notes"
  List<Map<String, dynamic>> data = await database.query(NoteModel.tableName);
  return data.map((e) => NoteModel.fromJson(e)).toList();
}

  Future<int> update(NoteModel note) async {
    final database = await db.database;
    return await database.update(
      NoteModel.tableName,
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final database = await db.database;
    return await database.delete(
      NoteModel.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}