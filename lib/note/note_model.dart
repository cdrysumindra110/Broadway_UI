class NoteModel {
  final int? id;
  final String title;
  final String description;
  final String name;
  final String email;

  NoteModel({
    this.id,
    required this.title,
    required this.description,
    required this.name,
    required this.email,
  });
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      name: json['name'],
      email: json['email'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'name': name,
      'email': email,
    };
  }

  static const tableName = 'notes';
  static const createTable =
      '''
CREATE TABLE $tableName (
  id INTEGER PRIMARY KEY,
  title TEXT,
  description TEXT,
  name TEXT,
  email TEXT
)
''';
}
