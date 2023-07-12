import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_postdetails_request/post.dart';
import 'package:http_postdetails_request/post_details.dart';

void main() {
  runApp(DisplayPost());
}

//this function will fetch post data from API
Future<List<Post>> fetchPost() async {
  //this fuction will convert json objects in list of post
  Uri url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
  var response = await http.get(url);

  if (response.statusCode == 200) {
    if (response.body.isNotEmpty) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => Post.fromJson(data)).toList();
    } else {
      throw Exception("Unexpected Error");
    }
  } else {
    throw Exception("Unexpected Error");
  }
}

//creatig a statefull widget
class DisplayPost extends StatefulWidget {
  const DisplayPost({super.key});

  @override
  State<DisplayPost> createState() => _DisplayPostState();
}

class _DisplayPostState extends State<DisplayPost> {
  late Future<List<Post>> postData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postData = fetchPost();
    debugPrint(postData.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Http Request for Post data"),
        ),
        body: Material(
          child: Center(
            child: FutureBuilder<List<Post>>(
              future: postData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Post>? posts = snapshot.data;
                  return ListView.builder(
                    itemCount: posts!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Card(
                          child: Container(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(posts![index].title),
                                  subtitle: Text(posts![index].body),
                                  leading: Text(posts![index].id.toString()),
                                  trailing:
                                      Text(posts![index].userId.toString()),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (a) {
                                          return PostDetails(
                                              posts![index].id,
                                              posts![index].userId,
                                              posts![index].title,
                                              posts![index].body);
                                        },
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else
                  return Text("Error: ${snapshot.error}");
              },
            ),
          ),
        ),
      ),
    );
  }
}

