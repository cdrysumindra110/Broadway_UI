import 'dart:convert';

import 'package:broadway_example_ui/avatars/avatar_model.dart';
import 'package:http/http.dart' as http;

class AvatarService {
  Future<List<AvatarModel>> GetAvatarEpisodes() async {
    try {
      final response = await http.get(
        Uri.parse("https://api.sampleapis.com/avatar/episodes"),
      );
      if (response.statusCode == 200) {
        final List jsonData = jsonDecode(response.body);
        final data = jsonData.map((e) => AvatarModel.fromJson(e)).toList();
        return data;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
