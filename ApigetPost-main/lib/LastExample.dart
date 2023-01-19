import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Postman_model/ProductModel.dart';
import 'Postman_model/more.dart';
import 'Postman_model/newmodel.dart';

class LastExampleScreen extends StatefulWidget {
  const LastExampleScreen({Key? key}) : super(key: key);

  @override
  _LastExampleScreenState createState() => _LastExampleScreenState();
}

class _LastExampleScreenState extends State<LastExampleScreen> {
  // Future<ProductsModel> getProductsApi() async {
  //   final response =
  //       await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
  //   print(response.body);
  //   var data = jsonDecode(response.body.toString());
  //   if (response.statusCode == 200) {
  //     return ProductsModel.fromJson(data);
  //   } else {
  //     // print(data);
  //     return ProductsModel.fromJson(data);
  //   }
  // }

  List<newmodel> list2 = [];

  Future<List<newmodel>> getApi() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        list2.add(newmodel.fromJson(i as dynamic));
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
        centerTitle: true,
        title: Text('Api Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getApi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ReuseableWidget(
                                    title: "albumId",
                                    value: snapshot.data![index].albumId
                                        .toString()),
                                ReuseableWidget(
                                    title: "Id",
                                    value: snapshot.data![index].id.toString()),
                                ReuseableWidget(
                                    title: "title",
                                    value:
                                        snapshot.data![index].title.toString()),
                                ReuseableWidget(
                                    title: "url",
                                    value:
                                        snapshot.data![index].url.toString()),
                                ReuseableWidget(
                                    title: "thumbnailUrl",
                                    value: snapshot.data![index].thumbnailUrl
                                        .toString()),
                              ],
                            ),
                          );
                        });
                  } else {
                    return Text('Loading');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReuseableWidget extends StatelessWidget {
  ReuseableWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

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
