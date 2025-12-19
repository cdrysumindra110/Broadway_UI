class UserModel {
  final int userId;
  final int id;
  final String title;
  final String? body;
  UserModel({
    required this.userId,
    required this.id,
    required this.title,
    this.body,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
