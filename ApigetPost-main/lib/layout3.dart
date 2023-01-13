import 'dart:convert';
import 'dart:html';

import 'package:apis/Postman_model/model3.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Layout3 extends StatefulWidget {
  const Layout3({super.key});

  @override
  State<Layout3> createState() => _Layout3State();
}

class _Layout3State extends State<Layout3> {
  final List<model3> postlist3 = [];

  Future<List<model3>> getuserapi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postlist3.add(model3.fromJson(i as dynamic));
      }
      return postlist3;
    } else {
      return postlist3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("layout3 Api"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getuserapi(),
                builder: ((context, AsyncSnapshot<List<model3>> snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                        child: Center(child: CircularProgressIndicator()));
                  } else {
                    return ListView.builder(
                        itemCount: postlist3.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Reuseablelayout3(
                                    title: 'Name :',
                                    value:
                                        snapshot.data![index].name.toString(),
                                  ),
                                  Reuseablelayout3(
                                    title: 'Username :',
                                    value: snapshot.data![index].username
                                        .toString(),
                                  ),
                                  Reuseablelayout3(
                                    title: 'Email :',
                                    value:
                                        snapshot.data![index].email.toString(),
                                  ),
                                  Reuseablelayout3(
                                    title: 'Address :',
                                    value: snapshot.data![index].address!.city
                                            .toString() +
                                        snapshot.data![index].address!.geo!.lat
                                            .toString(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                })),
          ),
        ],
      ),
    );
  }
}

class Reuseablelayout3 extends StatelessWidget {
  Reuseablelayout3({super.key, required this.title, required this.value});

  String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
