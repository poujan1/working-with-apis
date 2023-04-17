import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:testingapis/models/user_models.dart';
import 'package:http/http.dart' as http;
import 'package:testingapis/widgets/rowcomponent.dart';

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  List<UserList> userLists = [];
  Future<List<UserList>> userfunction() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        userLists.add(UserList.fromJson(i));
      }
      return userLists;
    } else {
      return userLists;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: userfunction(),
              builder: (context, AsyncSnapshot<List<UserList>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: userLists.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     const Text("Name:"),
                                //     Text(snapshot.data![index].name.toString()),
                                //   ],
                                // ),
                                ReusableRow(
                                  title: 'Name',
                                  value: snapshot.data![index].name.toString(),
                                ),
                                ReusableRow(
                                  title: 'Address',
                                  value: snapshot.data![index].address!.city
                                      .toString(),
                                ),
                                ReusableRow(
                                    title: 'Email',
                                    value:
                                        snapshot.data![index].email.toString())
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
