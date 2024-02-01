import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'model class/model hotel.dart';
class hotel extends StatefulWidget {
  const hotel({super.key});

  @override
  State<hotel> createState() => _hotelState();
}

class _hotelState extends State<hotel> {
  Future<hotel>? _future;
  Future <List<OfferDtls>> hoteldetails() async{
    var res = await http.get(Uri.parse("http://gtsuvai.gtcollege.in/Offer/GetOffer"));
    var data = jsonDecode(res.body)["offerDtls"];

    print(res.hashCode);
    print(res.body);

    return (data as List).map((e)=>OfferDtls.fromJson(e)).toList();
  }
  
  
  
  @override
  Widget build(BuildContext context) {

    final height=MediaQuery.of(context).size.height;

    return Scaffold(
      
      body: FutureBuilder( future:hoteldetails(),
        
        builder: (BuildContext context, snapshot) {  
        if (snapshot.hasData) {
          List<OfferDtls> offer = snapshot.data!;
          Container(
            height: 700,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
                itemCount: offer.length,
                itemBuilder:
                    (BuildContext context, int index){
                   return Container(
                     height: height,
                     child: Column(
                       children: [
                         Text("${offer[index].offerId.toString()}"),
                         Text("${offer[index].resName.toString()}"),
                         Text("${offer[index].resImage.toString()}"),
                         Text("${offer[index].offerImage.toString()}"),
                         Text("${offer[index].validFrom.toString()}"),
                         Text("${offer[index].validTo.toString()}"),
                         Text("${offer[index].description.toString()}"),

                         // Text( snapshot.data![index].offerId.toString()),
                         // Text( snapshot.data![index].resName.toString()),
                         // Text( snapshot.data![index].resImage.toString()),
                         // Text( snapshot.data![index].offerImage.toString()),
                         // Text( snapshot.data![index].validFrom.toString()),
                         // Text( snapshot.data![index].validTo.toString()),
                         // Text( snapshot.data![index].description.toString()),

                       ],
                     ),
                   );
                    }
                ),
          );
        }
        else if(snapshot.hasError){
          return Text("${snapshot.error}");
        }
           return

             CircularProgressIndicator();
      }
      )
      
    );
  }
}
