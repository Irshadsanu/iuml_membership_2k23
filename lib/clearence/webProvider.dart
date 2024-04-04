import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iuml_membership/clearence/coordinator_details_model.dart';
import 'package:iuml_membership/constants/my_colors.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:universal_html/html.dart' as web_file;

import '../Constants/my_functions.dart';
import '../Models/coordinator_model.dart';
import '../constants/my_text.dart';
import 'member_model.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;


class WebProvider extends ChangeNotifier{


  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  FirebaseFirestore db = FirebaseFirestore.instance;


  TextEditingController transactionIdController = TextEditingController();
  TextEditingController utrController = TextEditingController();

  TextEditingController stateCT= TextEditingController();
  TextEditingController districtCT= TextEditingController();
  TextEditingController assemblyCT= TextEditingController();

  String issueName='';
  String issueID='';
  String issueState='';
  String issueDistrict='';
  String issueAssembly='';
  String issueUnit='';
  String issueAmount='';
  String issueMemberID='';
  String issueStatus='';
  String issuePayment='';
  String issueTime='';
  String issueAppversion='';
  List<String> issueMemberIdList = [];



  WebProvider(){
    checkPassword();

  }

  void getUtrDetails(String utr,BuildContext context){

    print(utr.toString()+"dffw3www");
    String transactionId = '';
    db.collection('Entries').where('UTR',isEqualTo:utr).get().then((utrValue) {
      if(utrValue.docs.isNotEmpty){
        print("rwwewr");

        transactionId = utrValue.docs.first.get('TransactionID');
        getIdDetails(transactionId,context);
      }else{
        issueClearanceAlert(context,"No ID Found!!!",'There is No Data With this ID');
        notifyListeners();
      }
    });
  }


  bool isMember=false;
  String entryExist='';
  String entryStatus='';
  getIdDetails(String tId,BuildContext context){
    issueMemberIdList.clear();
    transactionIdController.text=tId;
    notifyListeners();
    db.collection('Attempts').where('ID',isEqualTo:tId ).get().then((value) {
      if(value.docs.isNotEmpty){
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();

          issueID=map["ID"].toString();
          if(map.containsKey('Name')) {
            issueName=map["Name"].toString();
          }else{
            issueName='';
          }
          issueState=map["state"].toString();
          issueDistrict=map["district"].toString();
          issueAssembly=map["assembly"].toString();
          issueUnit=map["unit"].toString();
          issueAmount=map["Amount"].toString();
          issueTime=map['Time'].toString();
          issueAppversion = map["AppVersion"].toString();

          if(map["member_id"]!=null){
            issueMemberID=map["member_id"].toString();

          }else if(map["MEMBER_IDS"]!=null){
            List<dynamic> list = map["MEMBER_IDS"];
            for(var e in list){
              issueMemberIdList.add(e);
              notifyListeners();
            }
          }else{

          }
          print(issueMemberIdList.toString()+"pporoor");
          if(map["Status"]!=null){
            issueStatus=map["Status"].toString();

          }else{
            issueStatus="FAILED";

          }

          notifyListeners();
          db.collection('MEMBERS').where('MEMBER_ID',isEqualTo:issueMemberID).get().then((paymentValue) {
            db.collection('Entries').where('TransactionID',isEqualTo:tId ).get().then((entryValue) {
              if(paymentValue.docs.isNotEmpty){
                isMember=false;
                issuePayment='YES';
                notifyListeners();
              }else{
                isMember=true;
                issuePayment='NO';
                notifyListeners();
              }
              if(entryValue.docs.isNotEmpty){
                entryExist='AVAILABLE';
                entryStatus=entryValue.docs.first.get('Status').toString();
                notifyListeners();
              }else{
                entryExist='NOT AVAILABLE';
                notifyListeners();
              }
            });



          });




        }
        notifyListeners();


        notifyListeners();
      }
      else{
        issueClearanceAlert(context,"No ID Found!!!",'There is Data With this ID');
        notifyListeners();
      }
    });
    notifyListeners();
  }

  issueClearance(BuildContext context,String docId,String memberId,String millis,String amount) async {

    print(docId+' CMFFKVKJFV');

    db.collection("Attempts").doc(docId).get().then((DocumentSnapshot element)  {
      if (element.exists) {
        Map<dynamic, dynamic> map = element.data() as Map;
        map["Status"] = "Success";
        map["PaymentApp"] = "UPLOADED";
        map["Responds"] = "UPLOADED";
        map["Time"] = int.parse(millis);
        map["Receipt Status"]="Viewed";
        map["LastForDigits"]=docId.substring(docId.length-4,docId.length);


        db.collection('Payments').doc(docId).set(map.cast());
        db.collection('MonitorNode').doc(docId).set(map.cast());
        db.collection('Attempts').doc(docId).update({"Status":"Success"});
        if(map['MEMBER_IDS']!=null){
          List<dynamic> listList=[];
          listList=map['MEMBER_IDS'];
          for(var data in listList){
            db.collection('MEMBERS').doc(data).set({"STATUS":"PAID","PAYMENT_URL":'Payments/$docId'},SetOptions(merge: true));
          }
        }else if(map['member_id']!=null){
          db.collection('MEMBERS').doc(memberId).set({"STATUS":"PAID","PAYMENT_URL":'Payments/$docId'},SetOptions(merge: true));
        }

          // db.collection('MEMBERS').doc(memberId).set({"STATUS":"PAID","PAYMENT_URL":'Payments/$docId'},);

        // sendMessage();
        issueClearanceAlert(context,"Issue Cleared",'Issue Cleared Successfully');

      }else{
        const snackBar = SnackBar(
          backgroundColor: Colors.redAccent,
          content: Center(child: Text('Not Found',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),)),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
    });
    // db.collection("Attempts").doc(docId).get().then((DocumentSnapshot element)  {
    //   if (element.exists) {
    //     db.collection('MEMBERS').doc(memberId).set({"STATUS":"PAID","PAYMENT_URL":'Payments/$docId'},);
    //     print(docId.toString()+"Aads222");
    //
    //   }
    // });
  }

  issueClearanceAlert(BuildContext context,String heading,String content) {
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      backgroundColor: Colors.white,
      actions: [
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Text(
                  heading,
                  style: black16,
                ),
                const SizedBox(height: 10,),
                Align(
                  alignment: Alignment.center,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      content,
                      // style: black16,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      // flex: 1,
                        child: InkWell(
                          onTap: () {
                            finish(context);
                            clearIssues();
                            transactionIdController.clear();
                            utrController.clear();
                            notifyListeners();
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 40,
                            width: 100,
                            alignment: Alignment.center,
                            decoration:  BoxDecoration(
                              color: myGreen,
                              borderRadius: const BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Text(
                              "OK",
                              style: white16,
                            ),
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  clearIssues(){
     issueName='';
     issueID='';
     issueState='';
     issueDistrict='';
     issueAssembly='';
     issueUnit='';
     issueAmount='';
     issueMemberID='';
     issueMemberIdList.clear();
     issueStatus='';
     issuePayment='';
     issueTime='';
     issueAppversion='';
     notifyListeners();
  }


  String password='';

  void checkPassword() {
    mRoot.child('0').child('PS').onValue.listen((event) {
      if(event.snapshot.exists){
        String pass=event.snapshot.value.toString();
        DateTime now=DateTime.now();
        int passTime=DateTime(now.year,now.month,now.day,0,0,0,0,0).millisecondsSinceEpoch;
        double passDouble=(passTime/double.parse(pass));
        password =passDouble.truncate().toString();
      }
    });
  }
  final DateRangePickerController _dateRangePickerController = DateRangePickerController();

  dateRangePickerFlutter(BuildContext context){
    Widget calendarWidget() {
      return SizedBox(
        width: 300,
        height: 300,
        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.range,
          controller: _dateRangePickerController,
          // initialSelectedRange: PickerDateRange(_startDate, _endDate),
          allowViewNavigation: true,
          headerHeight: 20.0,
          showTodayButton: true,
          headerStyle: const DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
          ),
          initialSelectedDate: DateTime.now(),
          navigationMode: DateRangePickerNavigationMode.snap,
          monthCellStyle: const DateRangePickerMonthCellStyle(
              todayTextStyle: TextStyle(fontWeight: FontWeight.bold)),
          showActionButtons: true,
          onSubmit: (Object? val) {
            _dateRangePickerController.selectedRange=val as PickerDateRange?;

            if(_dateRangePickerController.selectedRange!.endDate==null){
              DateTime endDate=_dateRangePickerController.selectedRange!.startDate!;
              endDate=DateTime(endDate.year,endDate.month,endDate.day,23,59,59,59,59);

              fetchExcelFireStore(context,_dateRangePickerController.selectedRange!.startDate!.millisecondsSinceEpoch,endDate.millisecondsSinceEpoch);


              notifyListeners();

            }else{
              fetchExcelFireStore(context,_dateRangePickerController.selectedRange!.startDate!.millisecondsSinceEpoch,_dateRangePickerController.selectedRange!.endDate!.millisecondsSinceEpoch);



              notifyListeners();

            }
            finish(context);
          },
          onCancel: () {
            _dateRangePickerController.selectedDate = null;
            finish(context);
          },
        ),
      );
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),

            content: calendarWidget(),
          );
        });
    notifyListeners();
  }
  // uploadLoading(BuildContext context,int total) {
  //   AlertDialog alert = AlertDialog(
  //     contentPadding: const EdgeInsets.symmetric(vertical: 15),
  //     shape: const RoundedRectangleBorder(
  //
  //         borderRadius: BorderRadius.all(Radius.circular(15.0))),
  //     backgroundColor: Colors.white,
  //     actions: [
  //       Row(
  //         children:  [
  //           const Padding(
  //             padding: EdgeInsets.symmetric(vertical: 10),
  //             child: CircularProgressIndicator(color: Colors.blue),
  //           ),
  //           const SizedBox(width: 10,),
  //           Consumer<WebProvider>(
  //               builder: (context,value,child) {
  //                 return Text(value.i.toString()+"/");
  //               }
  //           ),
  //           Text(total.toString()+" Uploading..."),
  //         ],
  //       )      ],
  //   );
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
  List<MemberModelForClearance> memberDetailsList = [];
  fetchExcelFireStore(BuildContext context,int start,int end){
    String coordinatorName='';
    String addedDate='';
    int i=0;
    int j=0;
    uploadLoading(context, 100);
    db.collection('MEMBERS')
        .where("ADDED_DATE_MILLIS", isGreaterThanOrEqualTo:start )
        .where("ADDED_DATE_MILLIS", isLessThanOrEqualTo:end)
        .orderBy("ADDED_DATE_MILLIS",descending: false)
        .get().then((event) {
      memberDetailsList.clear();
      if(event.docs.isNotEmpty){
        print(event.docs.length.toString()+"psoossiie");
        for (var element in event.docs) {
          Map<dynamic, dynamic> map = element.data();

          // String receiptStatus="notViewed";
          // String paymentUpi="Nil";
          // if( element.data().containsKey("Receipt Status")){
          //   receiptStatus="Viewed";
          // }
          // if( element.data().containsKey("PaymentUpi")){
          //   paymentUpi=element.get('PaymentUpi').toString();
          // }

          try{
            db.collection("COORDINATORS").doc(map['ADDED_BY'].toString()).get().then((value){
              if(value.exists){
                Map<dynamic, dynamic> map2 = value.data() as Map;
                coordinatorName = map2["NAME"]??"NIL";
                notifyListeners();

          memberDetailsList.add(MemberModelForClearance(
            element.id,
            map['ADDED_DATE_MILLIS'].toString(),
            map['NAME']??"NIL",
            map['PHONE_NUMBER']??"NIL",
            map['STATE']??"NIL",
            map['DISTRICT']??"NIL",
            map['ASSEMBLY']??"NIL",
            map['UNIT']??"NIL",
            map['AGE'].toString(),
            map['ADDED_BY']??"NIL",
            map['ADDED_DATE_MILLIS'].toString(),
            map['ADDRESS']??"NIL",
            map['EDUCATION']??"NIL",
            map['GENDER']??"NIL",
            map['LEVEL']??"NIL",
            map['MEMBER_ID']??"NIL",
            map['PIN_CODE']??"NIL",
            map['PROFESSION']??"NIL",
            map['STATUS']??"NIL",
            map['VOTER_ID']??"NIL",
            coordinatorName



          ));
          print(memberDetailsList.length.toString()+"  llllllllpp");

          notifyListeners();
              }else{

                memberDetailsList.add(MemberModelForClearance(
                    element.id,
                    map['ADDED_DATE_MILLIS'].toString(),
                    map['NAME']??"NIL",
                    map['PHONE_NUMBER']??"NIL",
                    map['STATE']??"NIL",
                    map['DISTRICT']??"NIL",
                    map['ASSEMBLY']??"NIL",
                    map['UNIT']??"NIL",
                    map['AGE'].toString(),
                    map['ADDED_BY']??"NIL",
                    map['ADDED_DATE_MILLIS'].toString(),
                    map['ADDRESS']??"NIL",
                    map['EDUCATION']??"NIL",
                    map['GENDER']??"NIL",
                    map['LEVEL']??"NIL",
                    map['MEMBER_ID']??"NIL",
                    map['PIN_CODE']??"NIL",
                    map['PROFESSION']??"NIL",
                    map['STATUS']??"NIL",
                    map['VOTER_ID']??"NIL",
                    "NIL"



                ));
                notifyListeners();

                j++;
                print(j.toString()+"cnncnnc");

              }
            });

          }
          catch(e){
            i++;
           print("uuuu "+i.toString());
          }

        }
      }
      finish(context);

    });
  }

  void createExcel(List<MemberModelForClearance> memberModelForClearancelist) async {
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];
    final List<Object> list = [
      'DATE',
      'TIME',
      'MEMBER ID',
      'NAME',
      'PHONE NUMBER',
      'STATE',
      'DISTRICT',
      'ASSEMBLY',
      'UNIT',
      'AGE',
      'ADDRESS',
      'VOTERID',
      'STATUS',
      'EDUCATION',
      'GENDER',
      'LEVEL',
      'PIN CODE',
      'PROFESSION',
      'ADDED BY',
      'COORDINATOR NAME',

    ];
    const int firstRow = 1;

    const int firstColumn = 1;

    const bool isVertical = false;

    sheet.importList(list, firstRow, firstColumn, isVertical);
    int i = 1;
    for (var element in memberModelForClearancelist) {
      int time= 00000000000;
      try{
        time =int.parse(element.time);
      }catch(e){

      }


      i++;
      final List<Object> list = [
        getDate(time.toString()),
        getTime(time.toString()),
        element.memberId,
        element.name,

        element.phone,
        element.state,
        element.district,
        element.assembly,
        element.unit,

        element.age,
        element.address,
        element.voterId,
        element.status,
        element.education,
        element.gender,
        element.level,
        element.pinCode,
        element.profession,
        element.addedBy,
        element.coordinatorName

      ];
      final int firstRow = i;

      const int firstColumn = 1;

      const bool isVertical = false;

      sheet.importList(list, firstRow, firstColumn, isVertical);
    }

    sheet.getRangeByIndex(1, 1, 1, 4).autoFitColumns();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    if(!kIsWeb){
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
    else{

      var blob = web_file.Blob([bytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'native');

      var anchorElement = web_file.AnchorElement(
        href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
      )..setAttribute("download", "data.xlsx")..click();
    }

  }


  int i=0;
  uploadLoading(BuildContext context,int total) {
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
      shape: const RoundedRectangleBorder(

          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      backgroundColor: Colors.white,
      actions: [
        Row(
          children:  [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CircularProgressIndicator(color: Colors.blue),
            ),
            const SizedBox(width: 10,),
            Consumer<WebProvider>(
                builder: (context,value,child) {
                  return Text(value.i.toString());
                }
            ),
            Text(total.toString()+" Uploading..."),
          ],
        )      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  List<CoordinatorDetailsModel> coordinatorDetailsList =[];
  void fetchCoordinators(BuildContext context){

    uploadLoading(context, 100);
    db.collection('COORDINATORS')
        .get().then((event) {
      coordinatorDetailsList.clear();
      if(event.docs.isNotEmpty){
        for (var element in event.docs) {
          Map<dynamic, dynamic> map = element.data() as Map;

          coordinatorDetailsList.add(CoordinatorDetailsModel(
            element.id,
            map['NAME']??"NIL",
            map['PHONE_NUMBER']??"NIL",
            map['STATE']??"NIL",
            map['DISTRICT']??"NIL",
            map['ASSEMBLY']??"NIL",
            map['UNIT']??"NIL",
            map['DESIGNATION'].toString(),
            map['ADDED_BY']??"NIL",
            map['ADDED_BY_ID']??"NIL",
            map['ADDED_DATE_MILLIS'].toString(),
            map['ADDRESS']??"NIL",

          ));
          print(coordinatorDetailsList.length);

          notifyListeners();

        }
      }
      finish(context);

    });
  }

  void createExcelCoordinators(List<CoordinatorDetailsModel> coordinatorList) async {
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];
    final List<Object> list = [
      'DATE',
      'TIME',
      'COORDINATOR ID',
      'NAME',
      'PHONE NUMBER',
      'STATE',
      'DISTRICT',
      'ASSEMBLY',
      'UNIT',
      'LEVEL',
      'ADDRESS',


    ];
    const int firstRow = 1;

    const int firstColumn = 1;

    const bool isVertical = false;

    sheet.importList(list, firstRow, firstColumn, isVertical);
    int i = 1;
    for (var element in coordinatorList) {
      int time= 00000000000;
      try{
        time =int.parse(element.addedDate);
      }catch(e){

      }


      i++;
      final List<Object> list = [
        getDate(time.toString()),
        getTime(time.toString()),
        element.coordinatorId,
        element.name,
        element.phone,
        element.state,
        element.district,
        element.assembly,
        element.unit,

        element.designationLevel,
        element.address,

      ];
      final int firstRow = i;

      const int firstColumn = 1;

      const bool isVertical = false;

      sheet.importList(list, firstRow, firstColumn, isVertical);
    }

    sheet.getRangeByIndex(1, 1, 1, 4).autoFitColumns();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    if(!kIsWeb){
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
    else{

      var blob = web_file.Blob([bytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'native');

      var anchorElement = web_file.AnchorElement(
        href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
      )..setAttribute("download", "data.xlsx")..click();
    }

  }


  getDate(String millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));

    var d12 = DateFormat('dd-MMM-yy').format(dt);
    return d12;
  }
  getTime(String millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));
    var d12 = DateFormat('hh:mm:ss a').format(dt);
    return d12;
  }
  getHour(String millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));
    var d12 = DateFormat('hh').format(dt);
    return d12;
  }


  int statePaidCount=0;
  List<String> memberList =[];
  void getStateCount(String state){
    db.collection("MEMBERS")
        .where("STATE", isEqualTo: state)
        .get()
        .then((value) {
            statePaidCount=0;
            memberList.clear();
              for(var e in value.docs){
                Map<dynamic, dynamic> map = e.data();
                if(!map.containsKey("REQUEST_STATUS")){
                  memberList.add(map.toString());
                  statePaidCount = memberList.length;
                  notifyListeners();
                }else if(map["REQUEST_STATUS"] == "APPROVE"){
                  memberList.add(map.toString());
                  statePaidCount = memberList.length;
                  print(map.length.toString()+"  333333");
                  notifyListeners();

                }else{
                }
              }
        });
      }

      Future<void> changeCoordinatorId() async {
      int i =0;
        await db.collection("MEMBERS").where("ADDED_BY",isEqualTo: "1693836804125").get().then((value){
          if(value.docs.isNotEmpty){
            for(var e in value.docs){
              i++;
                db.collection("MEMBERS").doc(e.id).set({"ADDED_BY":"1693396155401"},SetOptions(merge: true));
              print(i.toString()+"diiiir"+e.id);
            }
          }
        });
      }

      void getMembersCount(){
    db.collection("MEMBERS").get().then((value){
      print("lengath"+value.docs.length.toString());
    });
      }

}
