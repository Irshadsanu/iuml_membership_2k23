import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:iuml_membership/Models/Member_Model_Class.dart';
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../Constants/my_functions.dart';
import '../Screens/donationsucces_screen.dart';
import '../deviceinfo.dart';
import '../timeservice.dart';
import '../timestampmodel.dart';
import '../upimodel.dart';
import 'Main_Provider.dart';
// import 'package:universal_html/html.dart' as web_file;





class DonationProvider extends ChangeNotifier{

  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController amountCT = TextEditingController();
  TextEditingController nameTC = TextEditingController();
  TextEditingController phoneTC = TextEditingController();
  TextEditingController transactionID = TextEditingController();
  TextEditingController districtCt = TextEditingController();
  TextEditingController stateCt = TextEditingController();
  TextEditingController assemblyCt = TextEditingController();
  TextEditingController panchayathCt = TextEditingController();
  TextEditingController unitCt = TextEditingController();
  TextEditingController leveltCt = TextEditingController();
  TextEditingController memberIdCt = TextEditingController();
  List<String> memberIds=[];
  String? appVersion;
  String buildNumber="";
  String currentVersion='';
  String newRecptNum='Generating';




  DateTime donationTime = DateTime.now();
  String donorName = '';
  String donorNumber = '';
  String donorPlace = '';
  String donorID = '';
  String donorAmount = '';
  String donorApp = '';
  String? onOfButton = '';
  String donorReceiptPrinted = '';
  String donorStatus = '';
  String bookingName='';
  String borderPoint='';
  String countofPeople='';
  String clss='';
  String distrct='';
  String mandalam='';
  String panchayath='';
   int membershipAmount=0;

  String  lockMindGateOption='OFF';
  String  intentPaymentOption='OFF';


  DonationProvider(){
    getAppVersion();
    getMembershipAmount();
    lockMindGatePaymentOption();
    lockIntentPaymentOption();
    lockIosGooglePayButton();
  }




  static const platformChanel = MethodChannel('payuGateway');
  Future<void> upiIntent(String orderId,String memberId,BuildContext context,
      String amount,String name,String phone,String app,String appver,String state,String
  district,String assembly,String unit,String level,String userID,   String username,
      String address,   String photo,
      String profession,String isFromRequest,String loginLevel,) async {


    print('what is name   :  '+memberId);

    String txnID=orderId;
    print("code here111");
    UpiModel upiModel= await getUpiUri(app, amount.replaceAll(',', ''),txnID);
    print("code here22");
    var arguments={'Uri':upiModel.uri,};

    if(Platform.isAndroid){
      String status=await platformChanel.invokeMethod(app,arguments);
      print(status.toString()+"ddddddddd");

      if(status!='NoApp'){

        if(status!='FAILED'){
          print("code isss here");
          upDatePayment( memberId,state, district, assembly, unit, level,"SUCCESS",
              status, context, txnID, app,upiModel.upiId,appver, userID,username,address,photo,profession,isFromRequest,amount,name,phone,loginLevel);
        }else{
          print("code isss here22222");
          // upDatePayment(memberId,state, district, assembly, panchayath, unit,
          //     level,"SUCCESS", "no response", context, txnID, app,upiModel.upiId,appver, userID,    username,    address,    photo,    profession,isFromRequest);
          upDatePayment(memberId,state, district, assembly, unit, level,"FAILED", "no response", context, txnID, app,upiModel.upiId,appver,
              userID,username,address,photo,profession,isFromRequest,amount,name,phone,loginLevel);
          ///commented AMEEN
        }

      }else{
        print("fffff");
        String url='';
        if(app=='BHIM'){
          url='https://play.google.com/store/apps/details?id=in.org.npci.upiapp&hl=en_IN&gl=US';
        }else if(app=='GPay'){
          url='https://play.google.com/store/apps/details?id=com.google.android.apps.nbu.paisa.user&hl=en_IN&gl=US';
        }else if(app=='Paytm'){
          url='https://play.google.com/store/apps/details?id=net.one97.paytm&hl=en_IN&gl=US';
        }else if(app=='PhonePe'){
          url='https://play.google.com/store/apps/details?id=com.phonepe.app&hl=en_IN&gl=US';
        }
        _launchURL(url);
      }
    }

  }
  Future<void> multipleUpiIntent(String orderId,BuildContext context,String amount,String app,String appver,String state,
      String district,String assembly,String unit,String level, List<String> memberIds,
    String  userID,String    username,  String  address,String photo,String  profession,String name,String phone,String loginLevel) async {


    print('what is name   :  '+nameTC.text+amount);

    String txnID=orderId;
    print("code here111");
    UpiModel upiModel= await getUpiUri(app, amount.replaceAll(',', ''),txnID);
    print("code here22");
    var arguments={'Uri':upiModel.uri,};

    if(Platform.isAndroid){
      String status=await platformChanel.invokeMethod(app,arguments);
      print(status.toString()+"ddddddddd");

      if(status!='NoApp'){

        if(status!='FAILED'){
          print("code isss here");
          multipleUpDatePayment(state, district, assembly, unit, level,"SUCCESS", status, context, txnID, app,upiModel.upiId,appver,memberIds, userID,username, address,photo,profession,amount,loginLevel);
        }else{
          print("code isss here22222");
          multipleUpDatePayment(state, district, assembly, unit, level,"FAILED", "no response", context, txnID, app,upiModel.upiId,appver,memberIds, userID,username,address,photo,profession,amount,loginLevel);
        }

      }else{
        print("fffff");
        String url='';
        if(app=='BHIM'){
          url='https://play.google.com/store/apps/details?id=in.org.npci.upiapp&hl=en_IN&gl=US';
        }else if(app=='GPay'){
          url='https://play.google.com/store/apps/details?id=com.google.android.apps.nbu.paisa.user&hl=en_IN&gl=US';
        }else if(app=='Paytm'){
          url='https://play.google.com/store/apps/details?id=net.one97.paytm&hl=en_IN&gl=US';
        }else if(app=='PhonePe'){
          url='https://play.google.com/store/apps/details?id=com.phonepe.app&hl=en_IN&gl=US';
        }
        _launchURL(url);
      }
    }

  }
  String PhonepeIntentUrl="";







  Future<UpiModel> getUpiUri(String app,String amount,String txnID) async {
    print("fese");
    double amt=0;

    try{
      amt=double.parse(amount);

    }catch(e){}

    if(amt<2000){
      app=app+'2000';
    }

    var snapshot = await mRoot.child("0").child("AccountDetials").child('PaymentGateway').child(app).once();
    Map<dynamic, dynamic> map = snapshot.snapshot.value as Map;
    String upiId=map['UpiId'];
    String upiName=map['UpiName'];
    String upiAdd=map['UpiAdd'];
    print(upiId+'vgrtbhyju');
    // UpiModel upiModel=UpiModel(upiId, 'upi://pay?pa=$upiId&pn=$upiName&am=$amount&cu=INR&mc=8651&m&purpose=00&tn=kx ${txnID}$upiAdd');
    UpiModel upiModel=UpiModel(upiId, 'upi://pay?pa=$upiId&pn=$upiName&am=$amount&cu=INR&mc=8651&tn=ix ${txnID}$upiAdd');
    return upiModel ;
  }

  var outputDayNode = DateFormat('d/MM/yyy');

  upDatePayment(String memberId,String state,String district,
      String assembly,String unit,
      String level,String status, String response, BuildContext context,
      String orderID, String app, String upiIdP,String appver,
      String userID,String username,String address,String photo,String profession,String isFromRequest,String memberAmount,String memberName,String phone,String loginLevel,) async {
    print(status+"djjdjjc");


    print(memberId+"sdcsc"+status+"djjdjjc"+state+"nnnn"+district+"sd"+assembly+"sdas"+unit+"ooo"+panchayath);


    if(isFromRequest!='Request') {
      callNextReplacement(DonationSuccess(state: state,uid: userID,address: address,
          photo: photo,profession: profession,userName: username,
          district: district,
          assembly: assembly,
          unit: unit, from: '',loginLevel: loginLevel), context);
    }else{
      callNextReplacement(DonationSuccess(state: state,userName: username,
        profession: profession,uid: userID,photo: photo,address: address,
        district: district,
        assembly: assembly,
        unit: unit, from: 'REQUEST',loginLevel:loginLevel), context);
    }
    MainProvider providerValue = Provider.of<MainProvider>(context,listen: false);

    // var outputDayNode = DateFormat('yyyy_M_d');
    String name = memberName;
    DateTime now =DateTime.now();
    String timeString="";
    TimeStampModel? timeStampModel=await TimeService().getTime();

    if(timeStampModel!=null){
      now = timeStampModel.datetime.toLocal();
      timeString = outputDayNode.format(now).toString();
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageVersion = packageInfo.version;



    // String amount="1";





    HashMap<String, Object> map = HashMap();

    map["Receipt Status"]="Viewed";
    map["Amount"] = memberAmount;
    map["Responds"] = response;
    map["Name"] = name;
    map["PhoneNumber"] = phone;
    map["Time"] = now.millisecondsSinceEpoch.toString();
    map["Payment_Date"] = DateTime.now();
    map["Payment_Date_millis"] = DateTime.now().millisecondsSinceEpoch.toString();
    map["ID"] = orderID;

    if (status == "SUCCESS") {
      map["Status"] = "Success";
      map["Receipt Status"]="notViewed";
    } else {
      map["Status"] = "Failed";
    }



    print(state+"   payment state");
    print(district+"   district2222");
    print(assembly+"    assembly3333");
    print(unit+"  unit444");
    print(level+" level555");
    print(status+"   status666");
    print(memberId+"   memberid7777");
    print(isFromRequest+"   from88888");
    print(memberAmount+"   amounttttttttttt");
    print(name+"   name9999");
    print(phone+"   ejhygt");
    print(orderID+"   eie8ue8e");

    map["state"] = state;
    map["district"] = district;
    map["assembly"] = assembly;
    map["panchayath"] = panchayath;
    map["unit"] = unit;
    map["level"] = level;

    map["PaymentApp"] = app;

    if(Platform.isIOS){
      map["Platform"] = "IOS";
    }else if(Platform.isAndroid){
      map["Platform"] = "ANDROID";
    }
    else{
      map["Platform"] = "NIL";
    }

    map["UpiID"] = "";
    map["RefNo"] = "App";
    map["PaymentUpi"] = upiIdP;
    map["PrintStatus"] = 'Not Printed';
    map["AppVersion"] = appver;
    print(memberId.toString()+"podpodo");
    if(memberId!=''){
      map["member_id"] = memberId;

    } if (status == "SUCCESS" && isFromRequest=='Request'){
      print("TESTTTTTTTTTTTTTTTTTTTTTTT");
      providerValue.addMember(context,'',"New",'','Nil',providerValue.memberUnit.text.toUpperCase(),
          providerValue.requestMemberAssembly,providerValue.requestMemberDistrict,
          providerValue.requestMemberState,memberId,'REQUEST');
    }

    String? strDeviceID = "";

    if(Platform.isAndroid){
      strDeviceID= await DeviceInfo().fun_initPlatformState();

    }
    map["DeviceId"] = strDeviceID!;




    db.collection("MonitorNode").doc(orderID).set(map);


    print(memberId.toString()+"wuiwuw");
    if (status == "SUCCESS") {
      print("successsss1111"+memberId);




      HashMap<String, Object> dataMap =map;

      dataMap["Amount"] = double.parse(memberAmount);
      dataMap['Time']=now.millisecondsSinceEpoch;
      dataMap['LastForDigits']=orderID.substring(orderID.length-4,orderID.length);
      dataMap['Receipt Status']="notViewed";
      dataMap['MemberID']=memberId;
      print(memberId.toString()+"eaj1222");
      db.collection('Payments').doc(orderID).set(dataMap);
      print(memberId.toString()+"wowww");
      print(orderID.toString()+"eoieiiiei");
        db.collection('MEMBERS').doc(memberId).set({"STATUS":"PAID","PAYMENT_URL":'Payments/$orderID'},SetOptions(merge: true));
      print("ioooooooooooooooooooo");
      db.collection('Attempts').doc(orderID).set({"Status":"Success"},SetOptions(merge: true));

      db.collection("TOTAL_STATES").doc(state).set({"UNPAID_MEMBERS":FieldValue.increment(-1)},SetOptions(merge: true));
      db.collection("TOTAL_STATES").doc(state).set({"PAID_MEMBERS":FieldValue.increment(1)},SetOptions(merge: true));

      db.collection("TOTAL_ASSEMBLY").doc(assembly).set({"UNPAID_MEMBERS_ASSEMBLY":FieldValue.increment(-1),"UNPAID_MEMBERS_DISTRICT":FieldValue.increment(-1)},SetOptions(merge: true));
      db.collection("TOTAL_ASSEMBLY").doc(assembly).set({"PAID_MEMBERS_ASSEMBLY":FieldValue.increment(1),"PAID_MEMBERS_DISTRICT":FieldValue.increment(1)},SetOptions(merge: true));




    }

    getDonationDetailsForReceipt(orderID);


    // amountTC.clear();
    // nameTC.clear();
    // phoneTC.clear();
    // wardTC.clear();
    // selectedWard = null;
    notifyListeners();
  }

  multipleUpDatePayment(String state,String district,String assembly,
      String unit,String level,String status, String response, BuildContext context,
      String orderID, String app, String upiIdP,String appver, List<String> memberIds,String userID,String username,
      String address,String photo,String  profession,String memberAmount,String loginLevel) async {
    callNextReplacement(DonationSuccess(state: state, district: district, assembly: assembly,
       unit: unit, from: '',uid: userID,userName: username,address: address,photo: photo,profession: profession,loginLevel: loginLevel), context);
    // var outputDayNode = DateFormat('yyyy_M_d');

    print(memberIds.toString()+"riororo");
    DateTime now =DateTime.now();
    String timeString="";
    TimeStampModel? timeStampModel=await TimeService().getTime();

    if(timeStampModel!=null){

      now = timeStampModel.datetime.toLocal();
      timeString = outputDayNode.format(now).toString();

    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageVersion = packageInfo.version;



    // String amount="1";



    HashMap<String, Object> map = HashMap();

    map["Receipt Status"]="Viewed";
    map["Amount"] =  memberAmount;
    map["Responds"] = response;
    map["Name"] = '';
    map["PhoneNumber"] = '';
    map["Time"] = now.millisecondsSinceEpoch.toString();
    map["Payment_Date"] = timeString;
    map["ID"] = orderID;

    if (status == "SUCCESS") {
      map["Status"] = "Success";
      map["Receipt Status"]="notViewed";
    } else {
      map["Status"] = "Failed";
    }

    print(state+"   payment state");
    print(district+"   district2222");
    print(assembly+"    assembly3333");
    print(unit+"  unit444");
    print(level+" level555");
    print(status+"   status666");
    print(memberIds.toString()+"   memberid7777");
    print(memberAmount+"   amounttttttttttt");
    print(nameTC.text.toString()+"   name9999");
    print(orderID+"   ejhygt");



    map["state"] = state;
    map["district"] = district;
    map["assembly"] = assembly;
    map["panchayath"] = panchayath;
    map["unit"] = unit;
    map["level"] = level;

    map["PaymentApp"] = app;

    if(Platform.isIOS){
      map["Platform"] = "IOS";
    }else if(Platform.isAndroid){
      map["Platform"] = "ANDROID";
    }
    else{
      map["Platform"] = "NIL";
    }

    map["UpiID"] = "";
    map["RefNo"] = "App";
    map["PaymentUpi"] = upiIdP;
    map["PrintStatus"] = 'Not Printed';
    map["AppVersion"] = appver;
    map["Member_Ids"]=memberIds;
    String? strDeviceID = "";

    if(Platform.isAndroid){

      strDeviceID= await DeviceInfo().fun_initPlatformState();

    }
    map["DeviceId"] = strDeviceID!;




    db.collection("MonitorNode").doc(orderID).set(map);



    if (status == "SUCCESS") {
      print("successsss1111");




      HashMap<String, Object> dataMap =map;

      dataMap["Amount"] = double.parse(memberAmount);
      dataMap['Time']=now.millisecondsSinceEpoch;
      dataMap['LastForDigits']=orderID.substring(orderID.length-4,orderID.length);
      dataMap['Receipt Status']="notViewed";
      dataMap['Member_Ids']=memberIds;
      db.collection('Payments').doc(orderID).set(dataMap);
      for(var i in memberIds) {
        db.collection('MEMBERS').doc(i).set(
            {"STATUS": "PAID","PAYMENT_URL":'Payments/$orderID'}, SetOptions(merge: true));
      }
      db.collection('Attempts').doc(orderID).set({"Status":"Success"},SetOptions(merge: true));



      db.collection("TOTAL_STATES").doc(state).set({"UNPAID_MEMBERS":FieldValue.increment(-(memberIds.length))},SetOptions(merge: true));
      db.collection("TOTAL_STATES").doc(state).set({"PAID_MEMBERS":FieldValue.increment(memberIds.length)},SetOptions(merge: true));

      db.collection("TOTAL_ASSEMBLY").doc(assembly).set({"UNPAID_MEMBERS_ASSEMBLY":FieldValue.increment(-(memberIds.length)),
        "UNPAID_MEMBERS_DISTRICT":FieldValue.increment(-(memberIds.length))},SetOptions(merge: true));

      db.collection("TOTAL_ASSEMBLY").doc(assembly).set({"PAID_MEMBERS_ASSEMBLY":FieldValue.increment(memberIds.length),
        "PAID_MEMBERS_DISTRICT":FieldValue.increment(memberIds.length)},SetOptions(merge: true));
    }

    getDonationDetailsForReceipt(orderID);


    // amountTC.clear();
    // nameTC.clear();
    // phoneTC.clear();
    // wardTC.clear();
    // selectedWard = null;
    notifyListeners();
  }


  Future<void> getAppVersion() async {
    print('wfevgrbrtrhyj');

    PackageInfo.fromPlatform().then((value) {


      currentVersion=value.version;
      buildNumber = value.buildNumber;
      appVersion=buildNumber;

      print(appVersion.toString()+"edfesappversion");


      notifyListeners();
    });

  }

  getDonationDetailsForReceipt(String paymentID){
    print("11144555"+paymentID);
    donationTime = DateTime.now();
    bookingName='';
    borderPoint='';
    countofPeople='';
    clss='';
    donorName = '';
    donorNumber = '';
    donorPlace = '';
    donorStatus = '';
    donorReceiptPrinted = 'notPrinted';
    donorID = paymentID;
    db.collection("MonitorNode").doc(paymentID).get().then((value){
      if(value.exists){
        // donationTime=DateTime.fromMillisecondsSinceEpoch(int.parse(value.get("Time").toString()));
        // donorName=value.get("Name").toString();
        // donorNumber=value.get("PhoneNumber").toString();
        // donorID = paymentID;

        donorStatus  = value.get("Status").toString();
        // donorStatus = 'Success';
        ///commented AMEEN

        print(donorStatus+' JJJBNJ ');
        // // donorStatus ='Success';
        // // print(donorStatus+' kmkmde');
        // donorAmount = double.parse(value.get("Amount").toString()).toStringAsFixed(0);
        // donorApp = value.get("PaymentApp").toString();
        // distrct = value.get("district").toString();
        // mandalam = value.get("assembly").toString();
        // panchayath = value.get("panchayath").toString();

        notifyListeners();


      }


    });
  }



  attempt(String cAmount,String memberId,String name,String phone,String orderID,
      String state,String district,String assembly,String unit,String appver,Map map2)  async {

    String timeString ="";

    DateTime now =DateTime.now();
    TimeStampModel? timeStampModel=await TimeService().getTime();

    if(timeStampModel!=null){
      now = timeStampModel.datetime.toLocal();
      timeString = outputDayNode.format(now).toString();
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageVersion = packageInfo.version;


    memberIds.clear();
    String amount=cAmount;
    amountCT.text=cAmount;
    nameTC.text=name;
    phoneTC.text=phone;
    transactionID.text=orderID;
    districtCt.text=district;
    stateCt.text=state;
    assemblyCt.text=assembly;
    panchayathCt.text=panchayath;
    unitCt.text=unit;
    leveltCt.text="UNIT_LEVEL";
    memberIdCt.text=memberId;

    print(state+"fffgg"+district+"vnvnn"+assembly+"sdjvv"+panchayath+"dasw"+unit);


    HashMap<String, Object> map = HashMap();


    map["Amount"] = amount;
    map["Name"] = name;
    map["PhoneNumber"] = phone;
    map["Payment_Date"] = timeString;
    map["Time"] = now.millisecondsSinceEpoch.toString();
    map["ID"] = orderID;
    map["state"] = state;
    map["district"] = district;
    map["assembly"] = assembly;
    // map["panchayath"] = panchayath;
    map["unit"] = unit;
    map["member_id"] = memberId;




    if(Platform.isIOS){
      map["Platform"] = "IOS";
    }else if(Platform.isAndroid){
      map["Platform"] = "ANDROID";
    } else{
      map["Platform"] = "NIL";
    }


    map["AppVersion"] = appver;

    String? strDeviceID = "";
    if(Platform.isAndroid){
      strDeviceID= await DeviceInfo().fun_initPlatformState();

    }
    map["DeviceId"] = strDeviceID!;

    Map<dynamic, dynamic> dataMap =map;
    // Map<dynamic, dynamic> dataMap2 = map2;
    Map<dynamic, dynamic> dataMap3=Map();
    double amt= 0.0;

    try{
      amt=double.parse(amount);

    }catch(e){}
    dataMap["Amount"] = amt;

    if(map2.isEmpty){
      dataMap["FROM"] = 'UNPAID';
    }

    print(map2.toString()+"rooooogjjjjjjj");
    dataMap3.addAll(dataMap);
    dataMap3.addAll(map2);



    // print(dataMap2.toString()+"dpdoodood");

   await db.collection('Attempts').doc(orderID).set(dataMap3.cast());


    print(dataMap.toString()+"033333333");
    print(dataMap3.toString()+"8787878");
    print(map2["PHOTO"].toString()+"dodoiodid");


    // db.collection('Attempts').doc(orderID).set(dataMap2.cast(),SetOptions(merge: true));

    notifyListeners();
  }
  void multipleAttempt(String orderID,String state,String district,String assembly,
      String unit,String appver, String memberAmnt, List<MemberModel> unPaidMemberModelList,Map map2) async {

    String timeString ="";
    memberIds.clear();
    DateTime now =DateTime.now();
    TimeStampModel? timeStampModel=await TimeService().getTime();

    if(timeStampModel!=null){
      now = timeStampModel.datetime.toLocal();
      timeString = outputDayNode.format(now).toString();
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageVersion = packageInfo.version;





    amountCT.text=memberAmnt;

    transactionID.text=orderID;
    districtCt.text=district;
    stateCt.text=state;
    assemblyCt.text=assembly;
    panchayathCt.text=panchayath;
    unitCt.text=unit;
    leveltCt.text="UNIT_LEVEL";
    memberIds=unPaidMemberModelList.where((e) => e.selected == true).map((e) => e.MemberId).toList();


    HashMap<String, Object> map = HashMap();


    map["Amount"] = memberAmnt;
    map["Payment_Date"] = timeString;
    map["Time"] = now.millisecondsSinceEpoch.toString();
    map["ID"] = orderID;
    map["state"] = state;
    map["district"] = district;
    map["assembly"] = assembly;
    // map["panchayath"] = panchayath;
    map["unit"] = unit;
    map["MEMBER_IDS"]=
        unPaidMemberModelList.where((e) => e.selected == true).map((e) => e.MemberId).toList();


    if(Platform.isIOS){
      map["Platform"] = "IOS";
    }else if(Platform.isAndroid){
      map["Platform"] = "ANDROID";
    } else{
      map["Platform"] = "NIL";
    }


    map["AppVersion"] = appver;

    String? strDeviceID = "";
    if(Platform.isAndroid){
      strDeviceID= await DeviceInfo().fun_initPlatformState();

    }
    map["DeviceId"] = strDeviceID!;

    HashMap<String, Object> dataMap =map;
    double amt= 0.0;

    try{
      amt=double.parse(memberAmnt);

    }catch(e){}
    dataMap["Amount"] = amt;




    db.collection('Attempts').doc(orderID).set(dataMap);

    Map<dynamic, dynamic> dataMap2 = map2;
    print(dataMap2.toString()+"dpdoodood");

    db.collection('Attempts').doc(orderID).set(dataMap2.cast(),SetOptions(merge: true));
    notifyListeners();
  }








  createImage(String from, String donorName,ScreenshotController screenshotController) async {
    String imgName=DateTime.now().millisecondsSinceEpoch.toString();

    await screenshotController.capture().then((Uint8List? image) async {
      print("Funtion fist print$image");
      if (image != null) {
        // printStatus(donationTime.millisecondsSinceEpoch.toString());
        //,donorID);
        if(!kIsWeb){
          print("!kIsWeb worked");
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = await File('${directory.path}/$imgName.png').create();
          await imagePath.writeAsBytes(image);


          if (from == 'Print') {
            OpenFile.open(imagePath.path);
          } else {
            Share.shareFiles([imagePath.path],);
          }
        }
        else{

        }

      }


      // Handle captured image
    });
  }
  void getMembershipAmount() {

    // int amount = 1;
    mRoot.child("0").onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
         membershipAmount = map["membershipAmount"];
         // membershipAmount =1;

         // membershipAmount= amount;
         print(membershipAmount.toString()+"dfjwedew22");

      }
    });
  }

  lockIntentPaymentOption(){
    mRoot.child('0').child('IntentPaymentOption').onValue.listen((event) {
      if(event.snapshot.exists){
        intentPaymentOption=event.snapshot.value.toString();
        notifyListeners();
      }
    });

  }
  lockMindGatePaymentOption(){
    mRoot.child('0').child('MindGatePaymentOption').onValue.listen((event) {
      if(event.snapshot.exists){
        lockMindGateOption=event.snapshot.value.toString();
        notifyListeners();
      }
    });

  }


  void listenForPayment(String order_id,BuildContext paymentContext,String state,String district,String assembly,String unit,String from,String userName,String uid ,String photo,String profession,String address,String loginLevel ){

    print("listencodehereeee111"+order_id);

    db.collection("MonitorNode").where("ID",isEqualTo: order_id).snapshots().listen(
            (event) {

          if(event.docs.isNotEmpty){
            print("listencodehereeee22"+order_id);

            Map<dynamic, dynamic> map = event.docs.first.data();

            print(from+"sdjqwe33222");



            if (map["Status"].toString() == "Success" && from=='Request'){
              MainProvider providerValue = Provider.of<MainProvider>(paymentContext,listen: false);

              print("TESTTTTTTTTTTTTTTTTTTTTTTT");
              providerValue.addMember(paymentContext,'',"New",'','Nil',providerValue.memberUnit.text.toUpperCase(),
                  providerValue.requestMemberAssembly,providerValue.requestMemberDistrict,
                  providerValue.requestMemberState,map["member_id"].toString(),'REQUEST');

              callNextReplacement(DonationSuccess(state: state,userName: userName,
                  profession: profession,uid: uid,photo: photo,address: address,
                  district: district,
                  assembly: assembly,
                  unit: unit, from: 'REQUEST',loginLevel:loginLevel), paymentContext);
            }else{
              print("listencodehereeee555"+order_id);
              if(map["Status"] !=null ) {
                print("listencodehe88888888"+order_id);
                getDonationDetailsForReceipt(order_id);




                print(state+"ckc"+district+"cnbcbc"+assembly+"njxnjxn"+unit+"cbbcb"+from+"ncnn"+userName+"cuueu"+loginLevel+"cmcm"+profession+"vkkv"+photo+"vmkvk"+uid);
                callNextReplacement(DonationSuccess(state: state, district:district, assembly:assembly, unit:unit, from:from, userName: userName, uid: uid, photo: photo, profession:profession, address:address, loginLevel:loginLevel,), paymentContext);

              }
              notifyListeners();

            }

          }
          notifyListeners();



        });
    print("listencodehereeee33");
    print("msfpaperrevolutioncoderheree33");




  }
  Future<void> launchUrlUPI(BuildContext context, Uri _url) async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    } else {


    }
  }
  createQrImage(String from, String donorName,ScreenshotController screenshotController) async {
    String imgName=DateTime.now().millisecondsSinceEpoch.toString();
    // ScreenshotController screenshotController = ScreenshotController();
    await screenshotController
        .capture().then((Uint8List? image) async {
      if (image != null) {

        if(!kIsWeb){
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = await File('${directory.path}/$imgName.png').create();
          await imagePath.writeAsBytes(image);


          if (from == 'Print') {
            OpenFile.open(imagePath.path);
          } else {
            Share.shareFiles([imagePath.path],);
          }
        }
        else{
          // ByteData bytes=ByteData.view(image.buffer);
          //
          // var blob = web_file.Blob([bytes], 'image/png', 'native');
          //
          // var anchorElement = web_file.AnchorElement(
          //   href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
          // )..setAttribute("download", "data.png")..click();
        }

      }


      // Handle captured image
    });
  }
  String  androidGooglePayButton='OFF';
  lockIosGooglePayButton(){
    mRoot.child('0').child('androidGooglePayButton').onValue.listen((event) {
      if(event.snapshot.exists){
        androidGooglePayButton=event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }
  String  androidPhonePayButton='OFF';
  lockIosPhonePayButton(){
    mRoot.child('0').child('androidPhonePayButton').onValue.listen((event) {
      if(event.snapshot.exists){
        androidPhonePayButton=event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }


}



void _launchURL(String _url) async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}