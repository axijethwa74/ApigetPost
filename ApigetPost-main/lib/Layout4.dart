import 'dart:convert';

import 'package:apis/Postman_model/model4.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class layout4 extends StatefulWidget {
  const layout4({super.key});

  @override
  State<layout4> createState() => _layout4State();
}

class _layout4State extends State<layout4> {
  final List<model4> postlist4 = [];

  Future<List<model4>> apigetpost4() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        postlist4.add(model4.fromJson(i as dynamic));
      }
      return postlist4;
    } else {
      return postlist4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Layout 4 Api"),
      ),
      body: FutureBuilder(
          future: apigetpost4(),
          builder: (context, AsyncSnapshot<List<model4>> snapshot) {
            if (!snapshot.hasData) {
              print(snapshot.hasData);
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            } else {
              return ListView.builder(
                  itemCount: postlist4.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            ReuseableWidget(
                              title: 'Id',
                              value: snapshot.data![index].id.toString(),
                            ),
                            ReuseableWidget(
                              title: 'Name',
                              value: snapshot.data![index].name.toString(),
                            ),
                            ReuseableWidget(
                              title: 'Username',
                              value: snapshot.data![index].username.toString(),
                            ),
                            ReuseableWidget(
                              title: 'Email',
                              value: snapshot.data![index].email.toString(),
                            ),
                            ReuseableWidget(
                              title: 'Address',
                              value: snapshot.data![index].address!.city
                                      .toString() +
                                  " " +
                                  snapshot.data![index].address!.city
                                      .toString() +
                                  " " +
                                  snapshot.data![index].address!.street
                                      .toString() +
                                  " " +
                                  snapshot
                                      .data![index].address!.suite
                                      .toString() +
                                  " " +
                                  snapshot.data![index].address!.zipcode
                                      .toString() +
                                  " " +
                                  snapshot.data![index].address!.geo!.lat
                                      .toString(),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          }),
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


// Future<void> getApi(){

// final response = await http.get(Uri.parse("url"));

// if(response.statuscode==200){
// var data= jeson.Decode(response.body.toString());
// }
// else{


// }

// }



// Expanded(
// child:FutureBuilder(
// future:getApi(),
// builder:(context,snapshot){

// if(snapshot.connectionState == ConnectionState.waiting){
// return Text("Loading....");
// }else{
// return Text(data[index]["name"].toString());

// }

// }
// )
// );
