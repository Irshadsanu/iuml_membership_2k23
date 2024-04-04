
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iuml_membership/timestampmodel.dart';



class TimeService{


  Future<TimeStampModel?> getTime() async {
    var client=http.Client();

    TimeStampModel? timeStamp;


    try {

      var response = await client.get(Uri.parse("http://worldtimeapi.org/api/timezone/Asia/Kolkata"));
      if (response.statusCode == 200) {
        var jsonString = response.body;

        var jsonMap = json.decode(jsonString);
        timeStamp = TimeStampModel.fromJson(jsonMap);
        return timeStamp;
      }
    }
    catch(exp){
      return timeStamp;

    }

    return timeStamp;
  }
}
