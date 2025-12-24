class TodoModel {
  final int? id;
  final String title;
  final String body;
  TodoModel({this.id, required this.title, required this.body});
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(id: json['id'], title: json['title'], body: json['body']);
  }
  Map<String, dynamic> toJson() => {"id": id, "title": title, "body": body};
    static const tableName = 'Todo';
    static const createTable = '''
      CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        title TEXT, 
        body TEXT
      )
    ''';
}
