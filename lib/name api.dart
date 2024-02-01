import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model class/nameclass.dart';
class name extends StatefulWidget {
  const name({super.key});

  @override
  State<name> createState() => _nameState();
}

class _nameState extends State<name> {
  Future<nameclass> namedetails()async{
    var rsp = await http.get(Uri.parse("https://api.genderize.io?name=luc"));
    return nameclass.fromJson(jsonDecode(rsp.body));
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Center(child: Text('name'),),),
      body: Center(
        child: FutureBuilder<nameclass>(future:namedetails(),
          builder: (BuildContext context,  snapshot) {
          if(snapshot.hasData){

            return ListView.builder(

                itemBuilder: (BuildContext context,int index)
            {
              return ListTile(

                leading: Text(snapshot.data!.count.toString()),
                title: Text(snapshot.data!.name.toString()),
                trailing: Text(snapshot.data!.probability.toString()),
                subtitle   : Text(snapshot.data!.gender.toString()),

              );



            }



            );
          }else if(snapshot.hasError){
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();



          },),
      ),

    );
  }
}
