import 'dart:convert';

import 'package:apis/Postman_model/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Model> postList = [];

  Future<List<Model>> getPostApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      postList.clear();
      for (Map i in data) {
        postList.add(Model.fromJson(i as dynamic));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apis"),
      ),
      body: FutureBuilder(
        future: getPostApi(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading ....");
          } else {
            return ListView.builder(
              itemCount: postList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "User Id :",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(postList[index].userId.toString()),
                      Text(
                        "Id :",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text("Id : " + postList[index].id.toString()),
                      Text(
                        "Title:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text("Title : " + postList[index].title.toString()),
                      Text(
                        "Body:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text("Body : " + postList[index].body.toString()),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
