import 'package:http/http.dart';
import 'dart:convert';
import '../models/photos.dart';

class HttpService {
  final String postUrl = "https://jsonplaceholder.typicode.com/photos?_start=0&_limit=500";

  Future<List<Photos>> getPhotos() async {
    Response res = await get(postUrl);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Photos> posts =
          body.map((dynamic item) => Photos.fromJson(item)).toList();

      return posts;
    } else {
      throw "Can't get posts";
    }
  }
}
