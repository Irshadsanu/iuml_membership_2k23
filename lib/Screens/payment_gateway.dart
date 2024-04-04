import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iuml_membership/Screens/donationsucces_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/my_colors.dart';
import '../../constants/my_functions.dart';

import 'package:provider/provider.dart';

import '../providers/donation_provider.dart';
import 'newPaymentGatewayScreen.dart';

class PaymentGateway extends StatelessWidget {
  String amount, userID,
      username, address,
      photo, profession, isFromRequest,
      unit,
      name,
      phone,
  loginLevel,
  from,memberId,state,district,assembly;
  PaymentGateway(
      {Key? key,
      required this.amount,
      required this.userID,
      required this.address,
      required this.photo,
      required this.profession,
      required this.username,
      required this.isFromRequest,
      required this.unit,required this.name,required this.phone,required this.loginLevel,required this.from,
        required this.memberId,required this.state,required this.district,required this.assembly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // homeProvider.checkInternet(context);
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);

    if (!kIsWeb) {
      return mobile(context);
    } else {
      return web(context);
    }
  }

  Widget body(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    print(height);
    print(width);

    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Container(
        //   alignment: Alignment.bottomCenter,
        //   decoration: const BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage("assets/mainPoster.png"),
        //       fit: BoxFit.cover
        //     )
        //   ),
        //   height: 200,
        // child:Container(
        //   margin: const EdgeInsets.symmetric(horizontal: 10),
        //   padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
        //   height: 80,
        //   width: width,
        //   decoration:  BoxDecoration(
        //       color: const Color(0xFFF3FDF0).withOpacity(0.80),
        //     borderRadius: const BorderRadius.only(
        //       topRight: Radius.circular(17),
        //       topLeft: Radius.circular(17),
        //     )
        //   ),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const Text(
        //         'Membership Charge',
        //         style: TextStyle(
        //           color: Color(0xFF303030),
        //           fontSize: 15,
        //           fontFamily: 'PoppinsMedium',
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        //       RichText(text:  TextSpan(
        //         children: [
        //           TextSpan(
        //             text: '₹',
        //             style: TextStyle(
        //               color: Color(0xFF303030),
        //               fontSize: 20,
        //               fontWeight: FontWeight.w400,
        //             ),
        //           ),
        //           TextSpan(
        //             text: amount,
        //             style: TextStyle(
        //               color: Color(0xFF303030),
        //               fontSize: 20,
        //               fontFamily: 'Poppins',
        //               fontWeight: FontWeight.w700,
        //             ),
        //           ),
        //         ]
        //       ))
        //     ],
        //   ),
        // ),
        // ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
              height: 104,
              width: width/1.15,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      'Membership Charge',
                      style: TextStyle(
                        color: Color(0xFF303030),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.42,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "₹" + amount,
                      style: const TextStyle(
                        color: Color(0xFF036802),
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.96,
                      ),
                    ),
                  ),
                ],
              )),
        ),

        Container(
          color: const Color(0xFFF3FDF0),
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 5),
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Payment Method',
                style: TextStyle(
                  color: Color(0xFF303030),
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //GPay
              //here
              Consumer<DonationProvider>(
                builder: (context11,value,child) {
                  return value.intentPaymentOption=="ON"?Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          print("gpay click");
                          if (donationProvider.memberIds.isEmpty) {

                            // String name = donationProvider.nameTC.text;
                            // String phone = donationProvider.phoneTC.text;
                            // String state = donationProvider.stateCt.text;
                            // String district = donationProvider.districtCt.text;
                            // String assembly = donationProvider.assemblyCt.text;
                            String panchayath = donationProvider.panchayathCt.text;
                            // String unit = donationProvider.unitCt.text;
                            String level = donationProvider.leveltCt.text;
                            // String memberId = donationProvider.memberIdCt.text;
                            String orderId = donationProvider.transactionID.text;
                            donationProvider.upiIntent(
                                orderId,
                                memberId,
                                context,
                                amount,
                                name,
                                phone,
                                "GPay",
                                donationProvider.appVersion.toString(),
                                state,
                                district,
                                assembly,
                                unit,
                                level,
                                userID,
                                username,
                                address,
                                photo,
                                profession,
                                isFromRequest,
                            loginLevel);
                          } else {
                            // String state = donationProvider.stateCt.text;
                            // String district = donationProvider.districtCt.text;
                            // String assembly = donationProvider.assemblyCt.text;
                            String panchayath = donationProvider.panchayathCt.text;
                            // String unit = donationProvider.unitCt.text;
                            String level = donationProvider.leveltCt.text;
                            String orderId = donationProvider.transactionID.text;
                            // String name = donationProvider.nameTC.text;
                            // String phone = donationProvider.phoneTC.text;
                            donationProvider.multipleUpiIntent(
                                orderId,
                                context,
                                amount,
                                "GPay",
                                donationProvider.appVersion.toString(),
                                state,
                                district,
                                assembly,
                                unit,
                                level,
                                donationProvider.memberIds,
                                userID,
                                username,
                                address,
                                photo,
                                profession,
                            name,phone,loginLevel);
                          }
                          // donationProvider.donorStatus == "Success";
                          // callNext(DonationSuccess(), context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.25, color: const Color(0xFFD0D0D0)),
                              borderRadius: BorderRadius.circular(73)),
                          height: 50,
                          child: Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                child: Image.asset("assets/gPayRound.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'G Pay',
                                style: TextStyle(
                                  color: Color(0xFF303030),
                                  fontSize: 16,
                                  fontFamily: 'PoppinsMedium',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_circle_right_outlined)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Paytm
                      // InkWell(
                      //   onTap: (){
                      //
                      //
                      //     if(donationProvider.memberIds.isEmpty) {
                      //       String amount = donationProvider.amountCT.text
                      //           .toString();
                      //       String name = donationProvider.nameTC.text;
                      //       String phone = donationProvider.phoneTC.text;
                      //       String state = donationProvider.stateCt.text;
                      //       String district = donationProvider.districtCt.text;
                      //       String assembly = donationProvider.assemblyCt.text;
                      //       String panchayath = donationProvider.panchayathCt.text;
                      //       String unit = donationProvider.unitCt.text;
                      //       String level = donationProvider.leveltCt.text;
                      //       String memberId = donationProvider.memberIdCt.text;
                      //       String orderId = donationProvider.transactionID.text;
                      //       donationProvider.upiIntent(
                      //         orderId,
                      //         memberId,
                      //         context,
                      //         amount,
                      //         name,
                      //         phone,
                      //         "Paytm",
                      //         donationProvider.appVersion.toString(),
                      //         state,
                      //         district,
                      //         assembly,
                      //         panchayath,
                      //         unit,
                      //         level, userID,    username,    address,    photo,    profession,isFromRequest);
                      //     }
                      //     else{
                      //       String state = donationProvider.stateCt.text;
                      //       String district = donationProvider.districtCt.text;
                      //       String assembly = donationProvider.assemblyCt.text;
                      //       String panchayath = donationProvider.panchayathCt.text;
                      //       String unit = donationProvider.unitCt.text;
                      //       String level = donationProvider.leveltCt.text;
                      //       String orderId = donationProvider.transactionID.text;
                      //       donationProvider.multipleUpiIntent(
                      //           orderId,
                      //           context,
                      //           amount,
                      //           "Paytm",
                      //           donationProvider.appVersion.toString(),
                      //           state,
                      //           district,
                      //           assembly,
                      //           panchayath,
                      //           unit,
                      //           level,donationProvider.memberIds, userID,    username,    address,    photo,    profession);
                      //     }
                      //
                      //
                      //
                      //   },
                      //   child: Container(
                      //     padding: const EdgeInsets.symmetric(horizontal: 15),
                      //     decoration: BoxDecoration(
                      //         border: Border.all(width: 0.25, color: const Color(0xFFD0D0D0)),
                      //         borderRadius: BorderRadius.circular(73)
                      //     ),
                      //     height: 50,
                      //     child: Row(
                      //       children: [
                      //         Container(
                      //           height: 35,
                      //           width: 35,
                      //           child: Image.asset("assets/PaytmRoud.png"),
                      //         ),
                      //         const SizedBox(width: 10,),
                      //         const Text(
                      //           'Paytm',
                      //           style: TextStyle(
                      //             color: Color(0xFF303030),
                      //             fontSize: 16,
                      //             fontFamily: 'PoppinsMedium',
                      //             fontWeight: FontWeight.w500,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      //BHM
                      InkWell(
                        onTap: () {
                          if (donationProvider.memberIds.isEmpty) {
                            String amount =
                                donationProvider.amountCT.text.toString();
                            // String name = donationProvider.nameTC.text;
                            // String phone = donationProvider.phoneTC.text;
                            // String state = donationProvider.stateCt.text;
                            // String district = donationProvider.districtCt.text;
                            // String assembly = donationProvider.assemblyCt.text;
                            String panchayath = donationProvider.panchayathCt.text;
                            // String unit = donationProvider.unitCt.text;
                            String level = donationProvider.leveltCt.text;
                            // String memberId = donationProvider.memberIdCt.text;
                            String orderId = donationProvider.transactionID.text;
                            donationProvider.upiIntent(
                                orderId,
                                memberId,
                                context,
                                amount,
                                name,
                                phone,
                                "BHIM",
                                donationProvider.appVersion.toString(),
                                state,
                                district,
                                assembly,
                                unit,
                                level,
                                userID,
                                username,
                                address,
                                photo,
                                profession,
                                isFromRequest,loginLevel);
                          } else {
                            // String state = donationProvider.stateCt.text;
                            // String district = donationProvider.districtCt.text;
                            // String assembly = donationProvider.assemblyCt.text;
                            String panchayath = donationProvider.panchayathCt.text;
                            // String unit = donationProvider.unitCt.text;
                            String level = donationProvider.leveltCt.text;
                            String orderId = donationProvider.transactionID.text;
                            // String name = donationProvider.nameTC.text;
                            // String phone = donationProvider.phoneTC.text;
                            donationProvider.multipleUpiIntent(
                                orderId,
                                context,
                                amount,
                                "BHIM",
                                donationProvider.appVersion.toString(),
                                state,
                                district,
                                assembly,
                                unit,
                                level,
                                donationProvider.memberIds,
                                userID,
                                username,
                                address,
                                photo,
                                profession,
                                name,phone,loginLevel);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.25, color: const Color(0xFFD0D0D0)),
                              borderRadius: BorderRadius.circular(73)),
                          height: 50,
                          child: Row(
                            children: [
                              Container(
                                height: 35,
                                width: width/11.2,
                                child: Image.asset("assets/BHMRound.png"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'BHIM',
                                style: TextStyle(
                                  color: Color(0xFF303030),
                                  fontSize: 16,
                                  fontFamily: 'PoppinsMedium',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_circle_right_outlined)
                            ],
                          ),
                        ),
                      ),


                    ],
                  ):SizedBox();
                }
              ),
              Consumer<DonationProvider>(
                  builder: (context2,value,child) {
                    return value.lockMindGateOption=="ON"?Column(
                      children: [
                        const SizedBox(height: 26),
                        const Text(
                          'Other Method',
                          style: TextStyle(
                            color: Color(0xFF303030),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: Consumer<DonationProvider>(
                            builder: (context1,value,child) {
                              return InkWell(
                                onTap: (){

                                  print("idab"+isFromRequest+"sdszd"+from);
                                  // String state = donationProvider.stateCt.text;
                                  // String district = donationProvider.districtCt.text;
                                  // String assembly = donationProvider.assemblyCt.text;
                                  // String unit = donationProvider.unitCt.text;
                                  String level = donationProvider.leveltCt.text;
                                  // String memberId = donationProvider.memberIdCt.text;
                                  String orderId = donationProvider.transactionID.text;



                                  var string =
                                  // await donationProvider.encryptQR(
                                      "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=ix%20${donationProvider.transactionID.text}&am=${amount}&cu=INR";
                                  // );

                                  print(string + " QQQQQQQQQQQ");
                                  print(orderId + " orfeeeridsffds");
                                  _launchUrlUPI(context, Uri.parse(string));
                                  donationProvider.listenForPayment(orderId, context, state, district, assembly, unit, from, username, userID, photo, profession, address, loginLevel);

                                },
                                child: Container(
                                  width: width / 2.5,
                                  height: 35,
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: myGreen,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Center(
                                    child: Text(
                                      // providerValue.indextab == 1?"Register" :"Next" ,
                                      "Select Other App",
                                      style: TextStyle(
                                          color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                        ),
                        const SizedBox(
                          height: 19,
                        ),
                        InkWell(
                          onTap: (){
                            print("idab"+isFromRequest+"sdszd"+from);
                            // String state = donationProvider.stateCt.text;
                            // String district = donationProvider.districtCt.text;
                            // String assembly = donationProvider.assemblyCt.text;
                            // String unit = donationProvider.unitCt.text;
                            String level = donationProvider.leveltCt.text;
                            String memberId = donationProvider.memberIdCt.text;
                            String orderId = donationProvider.transactionID.text;


                            var string =
                            // await donationProvider.encryptQR(
                                "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=ix%20${donationProvider.transactionID.text}&am=${amount}&cu=INR";
                            // );

                            print(string + " QQQQQQQQQQQ");
                            print(orderId + " orfeeeridsffds");
                            _launchUrlUPI(context, Uri.parse(string));
                            donationProvider.listenForPayment(orderId, context, state, district, assembly, unit, from, username, userID, photo, profession, address, loginLevel);

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 50,
                                  child: Image.asset("assets/gPayRound.png")),
                              const SizedBox(width: 12),


                              SizedBox(
                                  height: 50,
                                  child: Image.asset("assets/sbi.png",scale: 3,)),

                              SizedBox(
                                  height: 50,
                                  child: Image.asset("assets/BHMRound.png")),
                              const SizedBox(width: 12),
                              SizedBox(
                                  height: 50,
                                  child: Image.asset("assets/paytm.png",scale: 3,)),

                            ],
                          ),
                        ),
                        const SizedBox(height: 32,),
                        InkWell(
                          onTap: (){











                            var string =
                            // await donationProvider.encryptQR(
                                "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=ix%20${donationProvider.transactionID.text}&am=${amount}&cu=INR";
                            // );

                            callNext(NewPaymentGatewayScreen(id:string, state: donationProvider.stateCt.text.toString(), district: donationProvider.districtCt.text.toString(), assembly: donationProvider.assemblyCt.text.toString(), unit: donationProvider.unitCt.text.toString(), from: from, username: username, userID: userID, photo: photo, profession: profession, address: address, loginLevel: loginLevel, amount: amount,), context);

                          },
                          child: Container(
                            width: width,
                            height: 47,
                            decoration: BoxDecoration(
                                color: myGreen,
                                borderRadius: BorderRadius.circular(81),
                                border: Border.all(color: myDarkGreen, width: 0.5)),
                            child: Center(
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.qr_code,color: Colors.white,),
                                  SizedBox(width: 5),
                                  Text(
                                    "Scan QR & Pay",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: cWhite,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ):SizedBox();
                  }
              )
            ],
          ),
        )

        ///old gpay,paytm,bhm code below
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: 32),
        //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
        //   child: Column(
        //     children: [
        //       Align(
        //         alignment: Alignment.topLeft,
        //         child: Padding(
        //           padding: const EdgeInsets.only(top: 25, left: 25),
        //           child: Text(
        //             'Select Payment Platform',
        //
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 20),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Consumer<DonationProvider>(
        //                 builder: (context,value,child) {
        //                   return Column(
        //                     children: [
        //                       InkWell(
        //                         onTap: () {
        //                           print("gpay click");
        //                           String amount=donationProvider.amountCT.text.toString();
        //                           String name=donationProvider.nameTC.text;
        //                           String phone=donationProvider.phoneTC.text;
        //                           donationProvider.upiIntent(context, amount, name, phone,"GPay","");
        //                         },
        //                         child: Container(
        //                             width: width*.73,
        //                             height: 61,
        //                             decoration: BoxDecoration(
        //                                 borderRadius: BorderRadius.circular(15),
        //                                 color: Colors.white
        //                             ),
        //                             child: Image.asset('assets/gpay.png',scale: 3,)),
        //                       ),
        //                       SizedBox(height: 20,),
        //                       InkWell(
        //                         onTap: () {
        //                           String amount=donationProvider.amountCT.text.toString();
        //                           String name=donationProvider.nameTC.text;
        //                           String phone=donationProvider.phoneTC.text;
        //                           donationProvider.upiIntent(context, amount, name, phone,"Paytm","");
        //                         },
        //                         child:
        //                         Container(
        //                             width: width*.73,
        //                             height: 61,
        //                             decoration: BoxDecoration(
        //                                 borderRadius: BorderRadius.circular(15),
        //                                 color: Colors.white
        //
        //                             ),
        //                             child: Image.asset('assets/paytm.png',scale: 3,)),
        //                       ),
        //                       SizedBox(height: 20,),
        //
        //                       InkWell(
        //                         onTap: () {
        //
        //                           String amount=donationProvider.amountCT.text.toString();
        //                           String name=donationProvider.nameTC.text;
        //                           String phone=donationProvider.phoneTC.text;
        //                           donationProvider.upiIntent(context, amount, name, phone,"BHIM","");
        //                         },
        //                         child:
        //                         Container(
        //                             width: width*.73,
        //                             height: 61,
        //                             decoration: BoxDecoration(
        //                                 borderRadius: BorderRadius.circular(15),
        //                                 color: Colors.white
        //
        //                             ),
        //                             child: Image.asset('assets/bhim.png',scale: 3,)),
        //                       ),
        //
        //                     ],
        //                   );
        //                 }
        //             ),
        //
        //
        //
        //
        //
        //
        //
        //
        //           ],
        //         ),
        //       ),
        //
        //
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget mobile(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);

    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: const Color(0xFFF3FDF0),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              finish(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        title: const Text(
          "IUML",
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w700,
            fontFamily: "PoppinsMedium",
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(1.00, -0.00),
              end: Alignment(-1, 0),
              colors: [Color(0xFF103907), Color(0xFF0C3104)],
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Text(
                "$unit unit",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'PoppinsMedium',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 22,
                height: 22,
                child: Image.asset("assets/Districtunit.png"),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          )
        ],
      ),
      body: body(context),
    );
  }

  Widget web(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    DonationProvider donationProvider =
        Provider.of<DonationProvider>(context, listen: false);

    return Stack(
      children: [
        Row(
          children: [
            Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/KnmWebBacound1.jpg'),
                      fit: BoxFit.cover)),
              child: Row(
                children: [
                  SizedBox(
                      height: height,
                      width: width / 3,
                      child: Image.asset(
                        "assets/Grou 2.png",
                        scale: 4,
                      )),
                  SizedBox(
                    height: height,
                    width: width / 3,
                  ),
                  SizedBox(
                      height: height,
                      width: width / 3,
                      child: Image.asset(
                        "assets/Grup 3.png",
                        scale: 6,
                      )),
                ],
              ),
            ),
          ],
        ),
        Center(
          child: queryData.orientation == Orientation.portrait
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(width: width/3,),
                    SizedBox(
                      width: width,
                      child: Scaffold(
                        backgroundColor: const Color(0xFFF3FDF0),
                        appBar: AppBar(
                          backgroundColor: myGreen,
                          centerTitle: true,
                          title: const Text(
                            'Payment Method',
                          ),
                        ),
                        body: body(context),
                      ),
                    ),
                    // SizedBox(width: width/3,),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(width: width/3,),
                    SizedBox(
                      width: width / 3,
                      child: Scaffold(
                        backgroundColor: const Color(0xFFF3FDF0),
                        appBar: AppBar(
                          backgroundColor: myGreen,
                          centerTitle: true,
                          title: const Text(
                            'Payment Method',
                          ),
                        ),
                        body: body(context),
                      ),
                    ),
                    // SizedBox(width: width/3,),
                  ],
                ),
        )
      ],
    );
  }

  void showLoaderDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
        child: Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrlUPI(BuildContext context, Uri _url) async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    } else {
      // callNext(PaymentGateway(), context);
    }
  }
}
