import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'dart:convert';

class SecondApi extends StatefulWidget {
  var url = Uri.parse(
      "https://api.giphy.com/v1/gifs/trending?api_key=OIrOe183I0LQ7Uhwbppbydb55igyi2GT&limit=2&rating=g");

  Future<dynamic> getresults() async {
    final respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      //print(jsonDecode(respuesta.body));
      return (jsonDecode(respuesta.body));
    } else {
      print("Error con la respusta");
    }
  }

  SecondApi({Key? key}) : super(key: key);

  @override
  State<SecondApi> createState() => _SecondApiState();
}

class _SecondApiState extends State<SecondApi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API"),
      ),
      body: Center(
        child: FutureBuilder(
          future: widget.getresults(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data["data"].length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Image.network(
                          snapshot.data["data"][index]["images"]["original"]
                              ["url"],
                        ),
                        Text(snapshot.data["data"][index]["title"]),
                        Text(snapshot.data["data"][index]["username"]),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
