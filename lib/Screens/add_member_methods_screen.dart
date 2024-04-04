import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iuml_membership/Constants/my_functions.dart';
import 'package:iuml_membership/Screens/Add_New_Member.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../constants/my_colors.dart';
import '../constants/my_text.dart';
import '../providers/Main_Provider.dart';


class AddMemberMethodsScreen extends StatefulWidget {
  String from;
  String state;
  String district;
  String assembly;
  String unit;
  String uid;
  String proffetion;
  String photo;
  String address;
  String userName;
  String loginLevel;
  AddMemberMethodsScreen({super.key,required this.from,required this.state,required this.district,required this.assembly,
    required this.unit,required this.uid,required this.proffetion,required this.photo,required this.address,
   required this.userName,required this.loginLevel});

  @override
  State<AddMemberMethodsScreen> createState() => _AddMemberMethodsScreenState();
}

class _AddMemberMethodsScreenState extends State<AddMemberMethodsScreen> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final verifyPhoneController = TextEditingController();

  final verifyOtpController = TextEditingController();

  bool verificationLoader = false;
  final FocusNode _pinPutFocusNode = FocusNode();
  String Code = "";
  bool phoneTextField = false;
  bool otpField = false;
  String randomOtp ='';

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context,listen:false);

    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        centerTitle: true,
        title:  Text("IUML",
          style:TextStyle(color: myGreen2,fontSize: 16,fontWeight: FontWeight.bold,fontFamily: "PoppinsMedium"),
        ),
        leading:Icon(Icons.arrow_back_ios_new,color: myDarkGreen,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Add New Member",
              style: style3,),
            // Padding(
            //   padding: const EdgeInsets.only(left: 8.0,top: 20),
            //   child: Row(
            //     children: [
            //       Text("Easy Method ",
            //       style: style3,),
            //       const Text("*",style: TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.bold),),
            //     ],
            //   ),
            // ) ,
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Register With ID Card, You have to upload ID proof Details",
                  // "The Easy Method means , You don’t need to type all data . Data will take from your Voter ID card",
              textAlign: TextAlign.justify,
              style: TextStyle(fontFamily: "Poppins",
              fontWeight: FontWeight.w400,
              fontSize: 14),),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  mainProvider.clearAddMember();
                  mainProvider.getProfessions();
                  mainProvider.getEducations();
                  callNextReplacement( AddNewMember(
                    from: widget.from,
                    state: widget.state,
                    district: widget.district,
                    assembly: widget.assembly,
                    unit: widget.unit,
                    uid: widget.uid,
                    idStatus: "WITH ID",
                    proffetion: widget.proffetion,
                    photo: widget.photo,
                    address: widget.address,
                    type: 'New',
                    MemberId: "",
                    userName: widget.userName,
                    paymentStatus: '',
                    loginLevel: widget.loginLevel,
                  ), context);
                  },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: myDarkGreen,
                    borderRadius: BorderRadius.circular(54),
                  ),
                  child: const Center(
                    child: Text("Register With ID Card",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "PoppinsMedium"
                      ),),
                  ),
                ),
              ),
            ),
            SizedBox(height: 37,),
            Text("OR",style: style11,),
            SizedBox(height: 37,),

            const Padding(
              padding: EdgeInsets.only(left: 8.0,right: 8),
              child: Text("Register with Phone number, You don't need to Enter ID card Details",
                textAlign: TextAlign.justify,
                style: TextStyle(fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontSize: 14),),
            ),
            Consumer<MainProvider>(
              builder: (context,val,child) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        phoneTextField =true;
                      });

                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(54),
                      ),
                      child:  Center(
                        child: Text("Register With Phone Number",
                          style: TextStyle(
                              color: myDarkGreen,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: "PoppinsMedium"
                          ),),
                      ),
                    ),
                  ),
                );
              }
            ),
            Column(
              children: [
                Consumer<MainProvider>(
                    builder: (context1,value,child) {
                    return phoneTextField?
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 5),
                          child: TextFormField(
                            onChanged: (value) {
                              if (value.length == 10) {
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                              } else {
                              }

                              setState(() {});
                            },
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.characters,
                            inputFormatters: [LengthLimitingTextInputFormatter(10)],
                            controller: verifyPhoneController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:const EdgeInsets.symmetric(vertical: 15,horizontal: 14),
                              hintStyle:TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w400,fontSize: 13,fontFamily: "Poppins"),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.black38,width: 0.5,
                                ), ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:  BorderSide(
                                    color: myGreen,width: 1,)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.black38,
                                  width: 0.5,
                                ),
                              ),
                              hintText: "Phone Number",

                            ),
                          ),
                        ),

                        Consumer<MainProvider>(
                          builder: (context,val,child) {
                            return InkWell(
                              onTap:() async {
                                if (verifyPhoneController.text.length == 10) {
                                // db.collection('MEMBERS').where('PHONE_NUMBER',isEqualTo: verifyPhoneController.text).get().then((value) async {
                                //   if(value.docs.isEmpty){
                                    setState(() {
                                      verificationLoader = true;
                                    });
                                    final dio = Dio();

                                    String ph="+91${verifyPhoneController.text}";

                                    int min = 100000; //min and max values act as your 6 digit range
                                    int max = 999999;
                                    var randomizer =  Random();
                                    var rNum = min + randomizer.nextInt(max - min);

                                     randomOtp=rNum.toString();
                                    final response = await dio.get('http://sapteleservices.com/SMS_API/sendsms.php?username=indianunionmuslimleague&password=12345&mobile=$ph&message=Welcome,$randomOtp\n- is your IUML membership verification code.\nINDIAN UNION MUSLIM LEAGUE&sendername=IUMLKL&routetype=1 &tid=1607100000000281347');
                                    print(response);

                                    if(response.statusCode==200){

                                      setState(() {
                                        phoneTextField = false;
                                        otpField = true;
                                        verificationLoader = false;
                                      });
                                      print("dfsjbdhf");

                                    }else{

                                      print(response.toString()+"aswqewe");

                                    }
                                  // }
                                  // else{
                                  //   const snackBar = SnackBar(
                                  //       backgroundColor: Colors.red,
                                  //       duration: Duration(milliseconds: 3000),
                                  //       content: Text("Number Already Exist!",
                                  //         textAlign: TextAlign.center,
                                  //         softWrap: true,
                                  //         style: TextStyle(
                                  //             fontSize: 18,
                                  //             color: Colors.white,
                                  //             fontWeight: FontWeight.bold),
                                  //       ));
                                  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  // }
                                // });
                                }
                              },
                              child: verificationLoader
                                  ?  Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: CircularProgressIndicator(
                                    color: myDarkGreen,
                                  )
                              )
                                  :Container(
                                height: 40,
                                // width: 340,
                                margin: const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                                decoration: BoxDecoration(
                                    color: myDarkGreen,
                                    borderRadius: BorderRadius.circular(81)
                                ),
                                child: const Center(
                                  child: Text("Send OTP",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: "PoppinsMedium",
                                        letterSpacing: 0.39
                                    ),),
                                ),
                              ),
                            );
                          }
                        ),
                      ],
                    ):SizedBox();
                  }
                ),
                otpField? Consumer<MainProvider>(
                  builder: (cntxt,value1,child) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                              top: 30
                          ),
                          child: PinFieldAutoFill(
                            codeLength: 6,
                            focusNode: _pinPutFocusNode,
                            keyboardType: TextInputType.number,
                            autoFocus: true,
                            controller: verifyOtpController,
                            currentCode: "",
                            decoration: BoxLooseDecoration(
                              textStyle:  TextStyle(color: myBlack.withOpacity(0.6),fontSize: 18,fontWeight: FontWeight.w700),
                              radius: const Radius.circular(10),
                              strokeColorBuilder:  FixedColorBuilder(myGreen),
                            ),
                            onCodeChanged: (pin) {
                              if (pin!.length == 6) {

                                verifyOtpController.text = pin;
                                if(verifyOtpController.text==randomOtp){
                                  mainProvider.clearAddMember();
                                  mainProvider.getProfessions();
                                  mainProvider.getEducations();

                                  value1.memberPhoneNumber.text = verifyPhoneController.text.toString();
                                  callNextReplacement( AddNewMember(
                                    from: widget.from,
                                    state: widget.state,
                                    district:widget.district,
                                    assembly: widget.assembly,
                                    unit: widget.unit,
                                    uid: widget.uid,
                                    idStatus: "WITH PHONE",
                                    proffetion: widget.proffetion,
                                    photo: widget.photo,
                                    address: widget.address,
                                    type: 'New',
                                    MemberId: "",
                                    userName: widget.userName,
                                    paymentStatus: '',
                                    loginLevel: widget.loginLevel,
                                  ), context);

                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text("Sorry, Verification code is not valid"),
                                    duration: Duration(milliseconds: 3000),
                                  ));
                                }
                                setState(() {
                                  Code = pin;
                                });
                              }
                            },
                          ),
                        ),
                        InkWell(
                          onTap: (){

                            // if(verifyOtpController.text==randomOtp){
                            //   mainProvider.clearAddMember();
                            //   mainProvider.getProfessions();
                            //   mainProvider.getEducations();
                            //
                            //   value1.memberPhoneNumber.text = verifyPhoneController.text.toString();
                            //   callNextReplacement( AddNewMember(
                            //     from: widget.from,
                            //     state: widget.state,
                            //     district:widget.district,
                            //     assembly: widget.assembly,
                            //     unit: widget.unit,
                            //     uid: widget.uid,
                            //     idStatus: "WITH PHONE",
                            //     proffetion: widget.proffetion,
                            //     photo: widget.photo,
                            //     address: widget.address,
                            //     type: 'New',
                            //     MemberId: "",
                            //     userName: widget.userName,
                            //     paymentStatus: '',
                            //     loginLevel: widget.loginLevel,
                            //   ), context);
                            //
                            // }else{
                            //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            //     content: Text("Sorry, Verification code is not valid"),
                            //     duration: Duration(milliseconds: 3000),
                            //   ));
                            // }

                          },
                          child: Container(
                            height: 40,
                            // width: 340,
                            margin: const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                            decoration: BoxDecoration(
                                color: myDarkGreen,
                                borderRadius: BorderRadius.circular(81)
                            ),
                            child: const Center(
                              child: Text("Proceed",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "PoppinsMedium",
                                    letterSpacing: 0.39
                                ),),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                ):SizedBox(),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
