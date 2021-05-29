import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(new MaterialApp(
      home: new HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final String url = "https://swapi.dev/api/people";
  final String url = "https://reqres.in/api/users?page=2";

  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
        //Encode the url
        Uri.encodeFull(url),
        //accepting only json response
        headers: {"Accept": "application/json"});

    print(response.body);
    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['data'];
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Center(
          child: new Text(
            'Retrieving JSON via HTTP get',
          ),
        ),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      padding: const EdgeInsets.all(20.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data[index]['avatar']),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data[index]['id'].toString(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              data[index]['email'],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              data[index]['first_name'],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              data[index]['last_name'],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
