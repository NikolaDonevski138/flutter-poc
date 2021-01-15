import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
    Post({
        this.id,
        this.title,
        this.body,
        this.userId,
    });

    String id;
    String title;
    String body;
    String userId;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"].toString(),
        title: json["title"],
        body: json["body"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "userId": userId,
    };
}
