
import 'package:flutter/material.dart';


class PostDetails extends StatelessWidget {
  late int userId;
  late int id;
  late String title;
  late String body;

  PostDetails(this.id, this.userId, this.title, this.body);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Post Details"),
        ),
        body: Material(
          child: Center(
            child: ListTile(
              title: Text(title),
              subtitle: Text(body),
              leading: Text(id.toString()),
              trailing: Text(userId.toString()),
            ),
          ),
        ),
      ),
    );
  }
}

