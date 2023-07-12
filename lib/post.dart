

class Post {
  late int userId;
  late int id;
  late String title;
  late String body;

  // initialization of the parameters
  Post(
      {required this.userId,
        required this.id,
        required this.title,
        required this.body});
// when the data is populated through API and we want to
//convert that into dart

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        userId: json['userId'],
        id: json['id'],
        title: json["title"],
        body: json['body']);
  }
}

