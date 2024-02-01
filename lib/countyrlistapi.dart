import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'model class/country.dart';
class apicountry extends StatefulWidget {
  const apicountry({super.key});

  @override
  State<apicountry> createState() => _apicountryState();
}

class _apicountryState extends State<apicountry> {

  Future<List<Country>>countryDetails() async{
    var res = await http.get(Uri.parse("https://api.nationalize.io?name=nathaniel"));
    var data =(jsonDecode(res.body)["country"]);
    print(res.body);
    //print(res.statusCode);
    return (data as List).map((e)=>Country.fromJson(e)).toList();

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countryDetails();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('country list'),),),

      body: FutureBuilder<List<Country>>(
        future:countryDetails() ,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            // List<Country> countryList=snapshot.data!;
            // print(countryList);
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                    leading: Text(snapshot.data![index].countryId.toString()),
                  title: Text(snapshot.data![index].probability.toString()),
                ),
              );
            },
            );
          }
         else if(snapshot.hasError){

           return Text("${snapshot.error}");
          }
         return CircularProgressIndicator();
        },

      ),
    );
  }
}
