
import 'dart:convert';

TimeStampModel timeStampModelFromJson(String str) => TimeStampModel.fromJson(json.decode(str));

String timeStampModelToJson(TimeStampModel data) => json.encode(data.toJson());

class TimeStampModel {
  TimeStampModel({
    required this.datetime,
  });


  DateTime datetime;


  factory TimeStampModel.fromJson(Map<String, dynamic> json) => TimeStampModel(
    datetime: DateTime.parse(json["datetime"]),
  );

  Map<String, dynamic> toJson() => {
    "datetime": datetime.toIso8601String(),
  };
}
