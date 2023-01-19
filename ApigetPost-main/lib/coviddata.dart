import 'dart:convert';

import 'package:apis/Postman_model/covidmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Covid extends StatefulWidget {
  const Covid({super.key});

  @override
  State<Covid> createState() => _CovidState();
}

class _CovidState extends State<Covid> {
  List<covidmodel> newlist = [];

  Future<List<covidmodel>> getapi() async {
    final response = await http.get(
        Uri.parse(" https://api.covidtracking.com/v1/states/current.json"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        newlist.add(covidmodel.fromJson(i as dynamic));
      }
      return newlist;
    } else {
      return newlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid Data"),
      ),
      body: FutureBuilder(
        future: getapi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text("loading");
          } else {
            return ListView.builder(
              itemCount: newlist.length,
              itemBuilder: (context, index) {
                return Text(snapshot.data![index].date.toString());
              },
            );
          }
        },
      ),
    );
  }
}
