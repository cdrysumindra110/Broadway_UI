import 'dart:convert';

import 'package:broadway_example_ui/users/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<List<UserModel>> getUser() async {
    try {
      final response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      );
      if (response.statusCode == 200) {
        final List jsonData = jsonDecode(response.body);
        final data = jsonData.map((e) => UserModel.fromJson(e)).toList();
        return data;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
