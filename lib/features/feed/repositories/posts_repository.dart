import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class PostsRepository {
  String endpoint = 'http://127.0.0.1:8000/api/v1/posts/';
  Future<List<PostModel>> getPosts() async {
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List posts = jsonDecode(response.body)['data'];
      return List.generate(
          posts.length, (index) => PostModel.fromJson(posts[index]));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
