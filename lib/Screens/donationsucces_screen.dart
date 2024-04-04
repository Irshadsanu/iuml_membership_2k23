import 'dart:math';
import 'package:flutter/material.dart';
import 'package:iuml_membership/Screens/bottom_navigation.dart';
import 'package:iuml_membership/Screens/request_Pending_Page.dart';
import '../../constants/my_colors.dart';
import '../../providers/donation_provider.dart';
import 'package:provider/provider.dart';

import '../Constants/my_functions.dart';
import '../providers/Main_Provider.dart';

class DonationSuccess extends StatefulWidget {
  String state,district,assembly,unit,from,userName,uid,photo,profession,address,loginLevel;

  DonationSuccess({super.key,required this.state,required this.district,
    required this.assembly,required this.unit,
    required this.from,
    required this.userName,
    required this.uid,
    required this.photo,
    required this.profession,
    required this.address,
    required this.loginLevel,
    });
  @override
  _DonationSuccessState createState() => _DonationSuccessState();
}

class _DonationSuccessState extends State<DonationSuccess> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

    print(widget.uid+"feoooo"+widget.userName+"feoooo"+widget.state+"feoooo"+
        widget.district+"feoooo"+widget.assembly+"feoooo"+widget.unit+"feoooo"+
        widget.photo+"feoooo"+ widget.profession+"feoooo"+widget.address+"feoooo"+ widget.loginLevel);

    Future.delayed(const Duration(seconds: 3), () {
      print(donationProvider.donorStatus.toString() + "  1114455 5   "  + widget.from);

      if (donationProvider.donorStatus == "Success") {
        if(widget.from!='REQUEST') {

          print(widget.uid+"diid"+widget.userName+"jdncn"+widget.state+"ncvb"+
              widget.district+"vvvbb"+widget.assembly+"ncvvni"+widget.unit+"vfhuuf"+
              widget.photo+"gnjnvn"+ widget.profession+"nguuut"+widget.address+"tyruiu"+ widget.loginLevel);


          // mainProvider.chckStateRegLock(widget.state);
          mainProvider.checkStateAdditionLock(widget.state);
          mainProvider.getMembersCount(widget.state, widget.district, widget.assembly, widget.unit,'');
          mainProvider.getUnPaidMembersCount(widget.state, widget.district, widget.assembly, widget.unit,'');
          print("dfnednje");
          mainProvider.getMembers(widget.state, widget.district, widget.assembly,  widget.unit);
          mainProvider.getUnpaidMembers(widget.state, widget.district,  widget.assembly, widget.unit);
          // mainProvider.fetchNominees(widget.from,widget. state, widget.district, widget.assembly, widget.unit);


          callNextReplacement(BottomNavigationScreen(from: "UNIT_LEVEL",
            uid: widget.uid, userName: widget.userName,
            state: widget.state,district: widget.district,
            assembly: widget.assembly, unit: widget.unit,photo: widget.photo,
            phoneNumber: widget.profession,address: widget.address,loginLevel: widget.loginLevel), context);

        }else{
          callNextReplacement( RequestPendingPage(wantToShow: false, name: '', address: '', PhoneNumber: '', photo: '',iD: '',type: "YES", status: '',state: ''), context);

        }

      }else {
        if (widget.from != 'REQUEST') {
          mainProvider.getMembers(
              widget.state, widget.district, widget.assembly, widget.unit);
          mainProvider.getUnpaidMembers(
              widget.state, widget.district, widget.assembly, widget.unit);
          callNextReplacement(BottomNavigationScreen(from: "UNIT_LEVEL",
            uid: widget.uid,
            userName: widget.userName,
            state: widget.state,
            district: widget.district,
            assembly: widget.assembly,
            unit: widget.unit,
            photo: widget.photo,
            phoneNumber: widget.profession,
            address: widget.address,
              loginLevel: widget.loginLevel), context);
        }
      }
    });
  }

  // @override
  // void dispose() {
  //   print('Dispose used');
  //   setState(() {
  //     super.dispose();
  //   });
  //
  // }

  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;

    return SafeArea(
      child: Consumer<DonationProvider>(
          builder: (context, value, child) {
            // value.donorStatus == "Success";
            return Scaffold(
              backgroundColor: value.donorStatus == "Success" ?myWhite3:myWhiteFailed,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const SizedBox(height: 45,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            // child:
                            //       Consumer<HomeProvider>(
                            //         builder: (context,value,child) {
                            //           return Align(alignment: Alignment.topRight,
                            //             child: InkWell(onTap: (){
                            //               launch("whatsapp://send?phone=${value.contactNumber}");
                            //             },
                            //               child:
                            //               Card(
                            // shape: const RoundedRectangleBorder(
                            // borderRadius: BorderRadius.all(Radius.circular(25))),
                            //                 elevation: 5,
                            //                child:   SizedBox(
                            //                  height: height*0.06,width: width*0.35,
                            //                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //                    children: [
                            //                      Image.asset(
                            //                           "assets/whatsapIconNew.png",
                            //                           scale: 3,
                            //                         ),
                            //                      const Text( "Get Support",
                            //                                  style: TextStyle(color: myBlack3,fontSize: 15),
                            //                                ),
                            //                    ],
                            //                  ),
                            //                )
                            //               ),
                            //             ),
                            //           );
                            //         }
                            //       ),
                          ),
                          Consumer<DonationProvider>(
                              builder: (context, value, child) {

                                return value.donorStatus == "Success" ?
                                SizedBox(height: height * 0.15,) : SizedBox(
                                  height: height * 0.15,);
                              }
                          ),
                          SizedBox(
                            child: Consumer<DonationProvider>(
                                builder: (context, value, child) {

                                  return value.donorStatus == "Success"
                                      ? Center(
                                        child: Image.asset(
                                    "assets/payment_success.png",
                                    scale: 2.7,
                                  ),
                                      )
                                      : value.donorStatus == "Failed"
                                      ? Center(
                                        child: Image.asset(
                                        "assets/payment_fail.png",
                                        scale: 2.5
                                  ),
                                      )
                                      :  Center(
                                         child: SizedBox(
                                          width: 200,
                                          height: 200,
                                           child: CircularProgressIndicator(
                                          color: myDarkGreen,)),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    Consumer<DonationProvider>(
                        builder: (context, value, child) {

                          return value.donorStatus == "Success"
                              ? Column(
                            children: [
                              const SizedBox(height: 20,),
                              Text("Your Payment has been ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: myDarkGreen,
                                  fontSize: 19,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,),
                              ),
                              Text("Success !",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: myDarkGreen,
                                  fontSize: 23,
                                  fontFamily: "PoppinsMedium",
                                  fontWeight: FontWeight.bold,),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     const Padding(
                              //       padding: EdgeInsets.only(top: 8.0),
                              //       child: Text("₹",style: TextStyle(
                              //           fontWeight: FontWeight.w400,
                              //           fontSize: 30,
                              //           color:Colors.black),),
                              //     ),
                              //     Text(value.donorAmount,),
                              //   ],
                              // )
                            ],
                          ) : value.donorStatus == "Failed"
                              ? Column(
                            children: [
                              const SizedBox(height: 20,),
                              Text('Your Payment has been',
                                  style: TextStyle(fontWeight: FontWeight.w700,
                                      fontSize: 19,
                                      color: myRed2,
                                      fontFamily: "Poppins")),
                                Text('Failed !',
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 23,
                                      color: myRed2,
                                      fontFamily: "PoppinsMedium")),
                              const SizedBox(height: 15,),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     const Padding(
                              //       padding: EdgeInsets.only(top: 8.0),
                              //       child: Text("₹", style: TextStyle(
                              //           fontWeight: FontWeight.w400,
                              //           fontSize: 30,
                              //           color: Colors.black),),
                              //     ),
                              //     Text(value.donorAmount,),
                              //   ],
                              // )
                            ],
                          ) : const SizedBox();
                        }),
                    // const SizedBox(height: 25,),

                  ],
                ),
              ),
            );
          }
      ),
    );
  }


  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}
