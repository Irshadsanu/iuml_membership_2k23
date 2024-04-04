import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iuml_membership/Constants/my_functions.dart';
import 'package:iuml_membership/Screens/Add_New_Member.dart';
import 'package:iuml_membership/providers/Main_Provider.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../constants/my_colors.dart';
import '../providers/login_provider.dart';

enum MobileVarificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
  SHOW_MOBILE_FORM_VERIFIED
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVarificationState currentSate = MobileVarificationState.SHOW_MOBILE_FORM_STATE;
  bool showTick = false;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  final FirebaseFirestore db = FirebaseFirestore.instance;
  late BuildContext context;
  String Code = "";
  late String verificationId;
  bool showLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpPage = false;
  bool isHovering = false;
  Future<void> signInWithPhoneAuthCredential(
      BuildContext context, PhoneAuthCredential phoneAuthCredential) async {
    if (kDebugMode) {
      print('done 1  $phoneAuthCredential');
    }
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
      await auth.signInWithCredential(phoneAuthCredential);
      if (kDebugMode) {
        print(' 1  $phoneAuthCredential');
      }
      setState(() {
        showLoading = false;
      });
      try {
        var LoginUser = authCredential.user;
        if (LoginUser != null) {
          LoginProvider loginProvider = LoginProvider();
          loginProvider.userAuthorized(LoginUser.phoneNumber, context);

          if (kDebugMode) {
            print("Login SUccess");

          }
        }
      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Otp failed'),
          backgroundColor: Colors.black,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(e.toString());
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          e.message ?? "",
        ),
      ));
    }
  }

  final FocusNode _pinPutFocusNode = FocusNode();
  Widget getMobileFormWidget(context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
  MainProvider mainProvider = Provider.of<MainProvider>(context,listen:false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 366,
              width: width,
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/login_new.png"),fit: BoxFit.fill)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/ladder.png",scale: 8,),
                  Image.asset("assets/WelcometoIUML.png",scale: 3,),
                  // Text("Welcome to",
                  // textAlign: TextAlign.center,
                  // style: TextStyle(
                  //   fontWeight: FontWeight.w600,
                  //   fontSize: 17,
                  //   fontFamily: "PoppinsMedium",
                  //   color: Colors.white,
                  //   letterSpacing : 0.51,
                  // ),),
                  // Text("IUML",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w700,
                  //     fontSize: 45,
                  //     fontFamily: "PoppinsMedium",
                  //     color: Colors.white,
                  //     letterSpacing : 0.51,
                  //   ),),

                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 35,left: 10),
              child: Text(
                "Login",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 50,),
            // currentSate == MobileVarificationState.SHOW_MOBILE_FORM_STATE?
            Padding(
              padding:
              const EdgeInsets.only(left: 18, right: 18,),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(81),
                  boxShadow: [
                    BoxShadow(
                      color: myShadowBlack,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: phoneController,
                  onChanged: (value) {
                    if (value.length == 10) {
                      showTick = true;
                      SystemChannels.textInput
                          .invokeMethod('TextInput.hide');
                    } else {
                      showTick = false;
                    }

                    setState(() {});
                  },
                  style:  TextStyle(color: myBlack, fontSize: 18,fontWeight: FontWeight.w700,fontFamily: "Poppins"),
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    counterStyle: const TextStyle(color: Colors.grey),
                    hintStyle:  TextStyle(
                        color: clC5C5C5,
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Mobile Number',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(81),
                      borderSide:  BorderSide(
                        color: myWhite
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(81),
                      borderSide:  BorderSide(
                        color: myWhite
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(81)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(81),
                      borderSide:  BorderSide(
                        color: myWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //     : Padding(
            //   padding:
            //   const EdgeInsets.only(left: 14, right: 14,),
            //   child: Container(
            //     height: 50,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5),
            //       boxShadow: [
            //         BoxShadow(
            //           color: myShadowBlack,
            //           blurRadius: 2,
            //         ),
            //       ],
            //     ),
            //     child: TextFormField(
            //       controller: phoneController,
            //       onChanged: (value) {
            //         if (value.length == 10) {
            //           showTick = true;
            //           SystemChannels.textInput
            //               .invokeMethod('TextInput.hide');
            //         } else {
            //           showTick = false;
            //         }
            //
            //         setState(() {});
            //       },
            //       style:  TextStyle(color: myBlack, fontSize: 18,fontWeight: FontWeight.w700,fontFamily: "Poppins",letterSpacing: 2.25),
            //       autofocus: false,
            //       keyboardType: TextInputType.number,
            //       textAlign: TextAlign.left,
            //       inputFormatters: [LengthLimitingTextInputFormatter(10)],
            //       decoration: InputDecoration(
            //         fillColor: Colors.white,
            //         filled: true,
            //         counterStyle: const TextStyle(color: Colors.grey),
            //         hintStyle:  TextStyle(
            //             color: myBlack.withOpacity(0.6),
            //             fontSize: 16,fontFamily: "Poppins",
            //             fontWeight: FontWeight.w500
            //         ),
            //         contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            //         hintText: 'Enter Your Phone Number',
            //         focusedBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(5),
            //           borderSide:  BorderSide(
            //               color: myWhite
            //           ),
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(5),
            //           borderSide:  BorderSide(
            //               color: myWhite
            //           ),
            //         ),
            //         errorBorder: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(5)),
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(5),
            //           borderSide:  BorderSide(
            //             color: myWhite,
            //           ),
            //         ),
            //         prefixIcon:
            //         Container(
            //           width: 60,
            //           // color: Colors.yellow,
            //           child: Row(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(12.0),
            //                 child: Text("+91",style: TextStyle(color: myDarkGreen,fontSize: 18,fontFamily: "Poppins",fontWeight: FontWeight.w700),),
            //               ),
            //               Container(
            //                 margin: const EdgeInsets.only(top: 8,bottom: 8,right: 5),
            //                 color: myDarkGreen,width: 1,)
            //             ],
            //           ),
            //         )
            //       ),
            //     ),
            //   ),
            // ),

            Center(
              child: InkWell(
                onTap: () async {
                  db.collection('USERS').where('PHONE_NUMBER',isEqualTo: "+91${phoneController.text}").get().then((value) async {
                    if(value.docs.isNotEmpty){
                      setState(() {
                        if (phoneController.text.length == 10) {
                          showLoading = true;
                        }
                      });
                      await auth.verifyPhoneNumber(
                          phoneNumber: "+91${phoneController.text}",
                          verificationCompleted:
                              (phoneAuthCredential) async {
                            setState(() {
                              showLoading = false;
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Verification Completed"),
                              duration: Duration(milliseconds: 3000),
                            ));
                            if (kDebugMode) {}
                          },
                          verificationFailed:
                              (verificationFailed) async {
                            setState(() {
                              showLoading = false;
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                              Text("Sorry, Verification Failed"),
                              duration: Duration(milliseconds: 3000),
                            ));
                            if (kDebugMode) {
                              print(verificationFailed.message.toString());
                            }
                          },
                          codeSent:
                              (verificationId, resendingToken) async {
                            setState(() {
                              showLoading = false;
                              currentSate = MobileVarificationState
                                  .SHOW_OTP_FORM_STATE;
                              this.verificationId = verificationId;

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    "OTP sent to phone successfully"),
                                duration:
                                Duration(milliseconds: 3000),
                              ));

                              if (kDebugMode) {
                                print("");
                              }
                            });
                          },
                          codeAutoRetrievalTimeout:
                              (verificationId) async {});
                    }else{
                      const snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          duration: Duration(milliseconds: 3000),
                          content: Text("No user Found!",
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });

                },
                child: showLoading
                    ?  Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: CircularProgressIndicator(
                      color: myDarkGreen,
                    )
                )
                    :Container(
                       height: 50,
                        // width: 340,
                      margin: const EdgeInsets.symmetric(horizontal: 18,vertical: 30),
                      decoration: BoxDecoration(
                          color: myDarkGreen,
                          borderRadius: BorderRadius.circular(81)
                      ),
                     child: const Center(
                       child: Text("Get OTP",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          fontFamily: "PoppinsMedium",
                        letterSpacing: 0.39
                      ),),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Text("Would you like to request for membership ?",
            style: TextStyle(fontFamily: "Poppins",
            fontSize: 13,
            color: cl5F5F5F,
            fontWeight: FontWeight.w400),),

            InkWell(
              onTap: (){
                mainProvider.clearAddMember();
                mainProvider.getAllStateDetailsFromJson();
                mainProvider.getProfessions();
                mainProvider.getEducations();
                callNext(AddNewMember(from: "Request", state: '', district: '', assembly: '',userName: '',
                    unit: '', uid: '', idStatus: 'WITH ID',  proffetion: '',photo: '',address: '', type: '',MemberId: "",paymentStatus: '',loginLevel: ''), context);
              },
              child: Container(
                height: 35,
                width: 144,
                margin: const EdgeInsets.symmetric(horizontal: 18,vertical: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(81),
                  border: Border.all(color:myDarkGreen )
                ),
                child:  Center(
                  child: Text("Request",
                    style: TextStyle(
                        color: myDarkGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        fontFamily: "PoppinsMedium",
                        letterSpacing: 0.39
                    ),),
                ),
              ),
            ),


            // Padding(
            //   padding: const EdgeInsets.only(left: 50, right: 50,top: 15,
            //   ),
            //   child: showLoading
            //       ? const Padding(
            //     padding: EdgeInsets.all(20.0),
            //     child: CircularProgressIndicator(
            //       color: Colors.green,
            //     ),
            //   )
            //       : MaterialButton(
            //       height: MediaQuery.of(context).size.height * .067,
            //       minWidth: MediaQuery.of(context).size.width,
            //       color: Colors.green,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(23),
            //       ),
            //       onPressed: () async {
            //         setState(() {
            //           if (phoneController.text.length == 10) {
            //             showLoading = true;
            //           }
            //         });
            //         await auth.verifyPhoneNumber(
            //             phoneNumber: "+91${phoneController.text}",
            //             verificationCompleted:
            //                 (phoneAuthCredential) async {
            //               setState(() {
            //                 showLoading = false;
            //               });
            //               ScaffoldMessenger.of(context)
            //                   .showSnackBar(const SnackBar(
            //                 content: Text("Verification Completed"),
            //                 duration: Duration(milliseconds: 3000),
            //               ));
            //               if (kDebugMode) {}
            //             },
            //             verificationFailed:
            //                 (verificationFailed) async {
            //               setState(() {
            //                 showLoading = false;
            //               });
            //               ScaffoldMessenger.of(context)
            //                   .showSnackBar(const SnackBar(
            //                 content:
            //                 Text("Sorry, Verification Failed"),
            //                 duration: Duration(milliseconds: 3000),
            //               ));
            //               if (kDebugMode) {
            //                 print(verificationFailed.message.toString());
            //               }
            //             },
            //             codeSent:
            //                 (verificationId, resendingToken) async {
            //               setState(() {
            //                 showLoading = false;
            //                 currentSate = MobileVarificationState
            //                     .SHOW_OTP_FORM_STATE;
            //                 this.verificationId = verificationId;
            //
            //                 ScaffoldMessenger.of(context)
            //                     .showSnackBar(const SnackBar(
            //                   content: Text(
            //                       "OTP sent to phone successfully"),
            //                   duration:
            //                   Duration(milliseconds: 3000),
            //                 ));
            //
            //                 if (kDebugMode) {
            //                   print("");
            //                 }
            //               });
            //             },
            //             codeAutoRetrievalTimeout:
            //                 (verificationId) async {});
            //       },
            //       child: const Text(
            //         "Get OTP",
            //         style: TextStyle(color: Colors.white, fontSize: 18),
            //       )),
            // )

          ],
        ),
      ),
    );
  }

  Widget getOtpFormWidget(context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 366,
              width: width,
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/login_new.png"),fit: BoxFit.fill)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/ladder.png",scale: 8,),
                  Image.asset("assets/WelcometoIUML.png",scale: 3,),
                  // Text("Welcome to",
                  // textAlign: TextAlign.center,
                  // style: TextStyle(
                  //   fontWeight: FontWeight.w600,
                  //   fontSize: 17,
                  //   fontFamily: "PoppinsMedium",
                  //   color: Colors.white,
                  //   letterSpacing : 0.51,
                  // ),),
                  // Text("IUML",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w700,
                  //     fontSize: 45,
                  //     fontFamily: "PoppinsMedium",
                  //     color: Colors.white,
                  //     letterSpacing : 0.51,
                  //   ),),

                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 35),
              child: Text(
                "Verify OTP",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              child: Column(
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
                      controller: otpController,
                      currentCode: "",
                      decoration: BoxLooseDecoration(
                        textStyle:  TextStyle(color: myBlack.withOpacity(0.6),fontSize: 18,fontWeight: FontWeight.w700),
                        radius: const Radius.circular(10),
                        strokeColorBuilder:  FixedColorBuilder(myGreen),
                      ),
                      onCodeChanged: (pin) {
                        if (pin!.length == 6) {
                          PhoneAuthCredential phoneAuthCredential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: pin);
                          signInWithPhoneAuthCredential(
                              context, phoneAuthCredential);
                          otpController.text = pin;
                          setState(() {
                            Code = pin;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              // width: 340,
              margin: const EdgeInsets.symmetric(horizontal: 22,vertical: 30),
              decoration: BoxDecoration(
                  color: myDarkGreen,
                  borderRadius: BorderRadius.circular(81)
              ),
              child: const Center(
                child: Text("Log In",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      fontFamily: "PoppinsMedium",
                      letterSpacing: 0.39
                  ),),
              ),
            ),
            showLoading
                ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircularProgressIndicator(
                color: myDarkGreen,
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();


  @override
  Widget build(BuildContext context) {

    return WillPopScope(

      onWillPop: () async => false,
      child: Scaffold(

          key: scaffoldKey,
          body: Container(
            child:
            currentSate == MobileVarificationState.SHOW_MOBILE_FORM_STATE
            // getMobileFormWidget
                ? getMobileFormWidget(context)
                : getOtpFormWidget(context),
          )),
    );
  }

}
