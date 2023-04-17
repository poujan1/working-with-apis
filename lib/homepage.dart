import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/dummy_sites.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<PostModels> apiData = [];
  Future<List<PostModels>> apiFunction() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        apiData.add(PostModels.fromJson(i));
      }
      return apiData;
    }
    return apiData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Testing"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: apiFunction(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text("loading....");
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Title:"),
                                Text(apiData[index].title.toString()),
                                const Text("UserId:"),
                                Text(apiData[index].userId.toString())
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: apiData.length,
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
