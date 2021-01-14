import 'package:flutter/foundation.dart';

class Photos {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photos({
    @required this.albumId,
    @required this.id,
    @required this.title,
    @required this.url,
    @required this.thumbnailUrl,
  });

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
        albumId: json['albumId'] as int, 
        id: json['id'] as int, 
        title: json['title'] as String, 
        url: json['url'] as String, 
        thumbnailUrl: json['thumbnailUrl'] as String);
  }
}
