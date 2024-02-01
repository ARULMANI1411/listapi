import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model class/class.dart';
class apilist extends StatefulWidget {
  const apilist({super.key});

  @override
  State<apilist> createState() => _apilistState();
}

class _apilistState extends State<apilist> {
    // Future<string>entrydetails()
  Future <List<Entries>> entrydetails() async{
    var res =await http.get(Uri.parse("https://api.publicapis.org/entries"));
    var data = jsonDecode(res.body)["entries"];
   // var data = jsonDecode(res.body)["count"];

    return(data as List).map((obj) =>Entries.fromJson(obj)).toList();
    //return data.tostring;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text("list api"),
     ),
     body: SingleChildScrollView(
       child: Center(
         child: FutureBuilder<List<Entries>>(
           future: entrydetails(),
           builder: ( context,snapshot){
             if(snapshot.hasData){
               List<Entries>listentry=snapshot.data!;
               return Column(
                 children: [
                   Container(
                     height: 700,
                     child: ListView.builder(
                       itemCount: listentry.length,
                         itemBuilder: (BuildContext context, int index)
                     {
                       return ListTile(
                         leading:Text(listentry[index].aPI.toString()) ,
                         title:Text(listentry[index].description.toString()),
                          subtitle:Text(listentry[index].link.toString()),
                          trailing:Text(listentry[index].cors.toString()),
                       );
                     }
                     ),
                   )
                 ],
               );
             }else if(snapshot.hasError){
               return Text('${snapshot.error}');
             }
             return const CircularProgressIndicator();
           },
         ),
       ),
     ),


    );
  }
}
