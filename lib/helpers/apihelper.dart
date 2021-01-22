import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/photos.dart';
import '../models/post.dart';

class HttpService {
  final String postsApi = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Photos>> getPhotos(int page) async {
    final res = await http
        .get("https://jsonplaceholder.typicode.com/albums/${page}/photos");
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Photos> posts =
          body.map((dynamic item) => Photos.fromJson(item)).toList();

      return posts;
    } else {
      throw "Can't get posts";
    }
  }


  Future<Post> createPost(String id, String title, String post) async {
    final res = await http.post(postsApi, body: {
      "title": title,
      "body": post,
      "userId": id,
    });
    if (res.statusCode == 201) {
      final String responseString = res.body;
      return postFromJson(responseString);
    }
  }
}
