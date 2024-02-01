import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddNewCategory extends StatefulWidget {
  const AddNewCategory({super.key});

  @override
  State<AddNewCategory> createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {
  TextEditingController txtCategory = TextEditingController();
  TextEditingController txtDesc = TextEditingController();
  Future<bool>? _success;
  Future<bool> AddCategory(String category, String desc) async
  {
    var resp = await http.post(Uri.parse("http://catodotest.elevadosoftwares.com/category/insertcategory"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>
      {
        "categoryId":0,
        "category":category,
        "description":desc,
        "createdBy":1
      }),

    );
    print(jsonDecode(resp.body)["success"] is bool);
    return jsonDecode(resp.body)["success"];
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: (_success == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }
  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: txtCategory,
          decoration: const InputDecoration(hintText: 'Enter Categiry'),
        ),
        TextField(
          controller: txtDesc,
          decoration: const InputDecoration(hintText: 'Enter des'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _success  = AddCategory(txtCategory.text, txtDesc.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );

  }
  FutureBuilder buildFutureBuilder() {
    return FutureBuilder(
      future: _success,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          return Text(snapshot.data!.toString());
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
