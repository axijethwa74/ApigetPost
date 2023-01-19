import 'dart:convert';

import 'package:apis/Postman_model/more.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoreExp extends StatefulWidget {
  const MoreExp({super.key});

  @override
  State<MoreExp> createState() => _MoreExpState();
}

class _MoreExpState extends State<MoreExp> {
  List<more> list2 = [];

  Future<List<more>> getApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        list2.add(more.fromJson(i as dynamic));
      }
      return list2;
    } else {
      return list2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More Exp"),
      ),
      body: FutureBuilder(
        future: getApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.hasData);
            return ListView.builder(
              itemCount: list2.length,
              itemBuilder: (context, index) {
                if (!snapshot.hasData) {
                  print(snapshot.hasData);
                  return Container(
                      child: Center(child: CircularProgressIndicator()));
                } else {
                  return Card(
                    child: Column(
                      children: [
                        Text(snapshot.data![index].id.toString()),
                        Text(snapshot.data![index].title.toString())
                      ],
                    ),
                  );
                }
              },
            );
          } else {
            return Text("Loading");
          }
        },
      ),
    );
  }
}
