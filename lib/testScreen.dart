import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iuml_membership/providers/donation_provider.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    return Scaffold(

      body: Center(
        child: InkWell(
          onTap: () async {


            // donationProvider.attempt("orderID", "appver", "assmbly", "districts", "panchayath", "adminID", "from", "UserName", "Phone", "addedBy");




            String merch=DateTime.now().millisecondsSinceEpoch.toString();
            var params = {
              "isPortal": true,
              "epicNumber": "ULI1751577",

            };
            print("reeeeeee2222");
            final dio = Dio(
                BaseOptions(
                  baseUrl: "https://gateway.eci.gov.in/api/v1/elastic/search-by-epic-from-national-display",


                ));

            var response= await dio.post("https://gateway.eci.gov.in/api/v1/elastic/search-by-epic-from-national-display" ,
                options: Options(

                    headers: {HttpHeaders.contentTypeHeader: "application/json",

                    }),
                data:jsonEncode(params));
            print("reeeeeee444 "+response.toString());

            if(response.statusCode==200){

              Map<String, dynamic> data = jsonDecode(response.data);

              log(data.toString()+".....server succes");
              // PhonepeIntentUrl = data ["data"]["instrumentResponse"]["intentUrl"];
              // notifyListeners();





              // _launchUrlUPI(context, Uri.parse(url));





              print(response.data.toString());
              // callNext(OtherPaymentOptionScreen(apiurl: response.data.toString(), paymentId:paymentId, from: '',), context);





            }else{

              print(response.toString()+"aswqewe");

            }


          },
          child: Container(
            width: 100,
              height: 50,
              color: Colors.orange,
              child: Center(child: Text("pay now"))),
        ),
      ),
    );
  }
}
