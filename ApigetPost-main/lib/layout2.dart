import 'dart:convert';

import 'package:flutter/material.dart';

import 'Postman_model/model2.dart';
import 'package:http/http.dart' as http;

class Layout2 extends StatefulWidget {
  const Layout2({super.key});

  @override
  State<Layout2> createState() => _Layout2State();
}

class _Layout2State extends State<Layout2> {
  List<Model2> postList2 = [];

  Future<List<Model2>> getApi2() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Model2 model2 = Model2(
            title: i['title'],
            url: i['url'],
            thumbnailUrl: i['thumbnailUrl'],
            id: i['id']);
        postList2.add(model2);
      }
      return postList2;
    } else {
      return postList2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Apis Photos"),
        ),
        body: FutureBuilder(
          future: getApi2(),
          builder: (context, AsyncSnapshot<List<Model2>> snapshot) {
            return ListView.builder(
              itemCount: postList2.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        snapshot.data![index].url.toString(),
                        scale: 1),
                  ),
                  subtitle: Text(snapshot.data![index].title.toString()),
                  title:
                      Text("Notes ID : " + snapshot.data![index].id.toString()),
                );
              },
            );
          },
        ));
  }
}
