// import 'dart:convert';
//
// import 'package:flutter/material.dart';
//
// import 'model class/restarent model.dart';
// import 'package:http/http.dart' as http;
//
// class rest extends StatefulWidget {
//   const rest({super.key});
//
//   @override
//   State<rest> createState() => _restState();
// }
//
// class _restState extends State<rest> {
//
//   Future <List<RestaurantDtls>> restarentdetails() async{
//     var res = await http.get(Uri.parse('http://gtsuvai.gtcollege.in/Master/GetRestaurantDetails'));
//     var data = jsonDecode(res.body)['restaurantDtls'];
//     return (data as List).map((e) =>RestaurantDtls.fromJson(e)).toList();
//
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ,
//     );
//   }
// }
