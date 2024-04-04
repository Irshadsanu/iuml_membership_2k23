import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iuml_membership/constants/my_colors.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import '../Constants/my_functions.dart';
import '../providers/Main_Provider.dart';
import '../providers/donation_provider.dart';
import 'login_screen.dart';
import 'dart:ui' as ui;


class RequestPendingPage extends StatelessWidget {
  bool wantToShow;
  String name;
  String iD;
  String address;
  String PhoneNumber;
  String photo;
  String type;
  String status;
  String state;
   RequestPendingPage({super.key,required this.wantToShow,
     required this.name,required this.address,required this.PhoneNumber,required this.photo,required this.iD,required this.type,required this.status,required this.state});


  ScreenshotController screenshotController = ScreenshotController();
  GlobalKey previewContainer = new GlobalKey();


  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    print(photo+"IUYTDUIOP");
    print(name+"pendingname");
    print(state+"mmccmmc");
    // wantToShow = false;

    return  Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height/5.5,
              width: width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                image: DecorationImage(image: AssetImage("assets/Background_Iuml.png"),
                fit: BoxFit.fill)
              ),
              child: SafeArea(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal:width/13 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: const [
                           Text("Welcome to",style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold)),
                           Text("IUML",style: TextStyle(fontFamily: "Coolvetica",
                               fontSize: 52,color: Colors.white ),),
                         ],
                       ),
                       Image.asset("assets/ladder.png",scale: 8,),

                     ],
                  ),
                ),
              ),
            ),


            SizedBox(height: height/55),
            wantToShow == true? Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 28),
              child: RepaintBoundary(
                 key: previewContainer,
                child: Screenshot(
                  controller: screenshotController,
                  child: Stack(
                    children: [

                      Positioned(
                        top: height*0.15,
                        left: width*0.248,
                        child: photo!=""? CircleAvatar(
                          // height: 150,
                          //   width: 100,
                          //   decoration: BoxDecoration(
                          //     color: Colors.red,
                          //       shape: BoxShape.circle,image: DecorationImage(image: NetworkImage(photo))),
                          radius: 68,
                          backgroundColor: Colors.white60,
                          backgroundImage: NetworkImage(photo),
                          // child:Image.network(photo)
                        ): CircleAvatar(
                            radius: 68,
                            backgroundColor: Colors.white60,
                            child:Icon(Icons.person,color: myDarkGreen ,size: 40)
                        ),
                      ),
                      Container(
                        height: height/1.5,
                        // height: 570,
                        width: width,
                        decoration:   BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          // color: Colors.red,
                          image: const DecorationImage(
                            image: AssetImage("assets/id_card.png"),
                            fit: BoxFit.fill
                          )
                        ),
                        // child: Column(
                        //   children: [
                        //     SizedBox(height: height/40),
                        //     Image.asset("assets/iuml_logo.png",scale: 2.5),
                        //     Text("Membership Card",style: TextStyle(
                        //       fontFamily: "Poppins",
                        //         fontWeight: FontWeight.bold,color: myGreen)),
                        //
                        //
                        //     SizedBox(height: height/85),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //    Container(height: 60,width: 15,decoration: BoxDecoration(
                        //      color: myDarkGreen,borderRadius: const BorderRadius.only(
                        //        topRight: Radius.circular(15),
                        //    bottomRight:  Radius.circular(15))
                        //    ),),
                        //     photo!=""? CircleAvatar(
                        //       radius: 45,
                        //        backgroundImage:NetworkImage(photo)
                        //     ): CircleAvatar(
                        //       radius: 45,
                        //        backgroundColor: Colors.white60,
                        //        child:Icon(Icons.person,color: myDarkGreen ,size: 40)
                        //         ),
                        //         Container(height: 60,width: 15,decoration: BoxDecoration(
                        //             color: myDarkGreen,borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),
                        //             bottomLeft:  Radius.circular(15))
                        //         ),)
                        //       ],
                        //     ),
                        //     Container(
                        //       height: height/2.7,
                        //       width: width,
                        //       decoration: const BoxDecoration(
                        //           image: DecorationImage(
                        //         image: AssetImage("assets/Membership_Card_Bg.png"),fit: BoxFit.fill
                        //       )),
                        //       child: Stack(
                        //         children: [
                        //           Positioned(
                        //             top: 75,
                        //               left: 80,
                        //               child: Image.asset("assets/lader-8.png",scale: 3,)),
                        //           Column(
                        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Padding(
                        //                 padding: EdgeInsets.only(left: width/8,top: height/7),
                        //                 child: Column(
                        //                   mainAxisAlignment: MainAxisAlignment.start,
                        //                   children: [
                        //                     Row(
                        //                       crossAxisAlignment: CrossAxisAlignment.start,
                        //                       children:  [
                        //                         const Icon(Icons.person_2_outlined,color: Colors.white,),
                        //                         const SizedBox(width: 5),
                        //                         SizedBox(
                        //                           width: width*0.6,
                        //                           child: Text(name,style: const TextStyle(
                        //                             fontFamily: "Poppins",
                        //                               color: Colors.white),),
                        //                         )
                        //                       ],
                        //                     ),
                        //                     const SizedBox(height: 5,),
                        //                     Row(
                        //                       crossAxisAlignment: CrossAxisAlignment.center,
                        //                       children:  [
                        //                          Image.asset("assets/memberIdCard.png",scale:2.7,),
                        //                         const SizedBox(width: 5),
                        //                         SizedBox(
                        //                           width: width*0.6,
                        //                           child: Text(iD,style: const TextStyle(
                        //                               fontFamily: "Poppins",
                        //                               color: Colors.white),),
                        //                         )
                        //                       ],
                        //                     ),
                        //                     const SizedBox(height: 5),
                        //                     Row(
                        //                       crossAxisAlignment: CrossAxisAlignment.start,
                        //                       children: [
                        //                         const Icon(Icons.phone,color: Colors.white,size: 20),
                        //                         SizedBox(width: 5),
                        //                         Text(
                        //                           "+91 $PhoneNumber",
                        //                           style: const TextStyle(color: Colors.white,fontFamily: "Poppins",),)
                        //                       ],
                        //                     ),
                        //                     const SizedBox(height: 5,),
                        //                     Row(
                        //                       crossAxisAlignment: CrossAxisAlignment.start,
                        //                       children:  [
                        //                         const Icon(Icons.home_outlined,color: Colors.white),
                        //                         SizedBox(width: 5,),
                        //                         Container(
                        //                           // color: Colors.yellow,
                        //                           width: width*0.6,
                        //                           child: Text(address.replaceAll(RegExp(r"\s+"), " "),
                        //                             style: const TextStyle(
                        //                               color: Colors.white,
                        //                               fontFamily: "Poppins",),),
                        //                         )
                        //                       ],
                        //                     ),
                        //
                        //
                        //                     // SizedBox(height: 30,),
                        //
                        //
                        //                   ],
                        //                 ),
                        //               ),
                        //
                        //
                        //               // SizedBox(height: 1,)
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     )
                        //
                        //
                        //   ],
                        // )
                      ),
                      Positioned(
                        top: height*0.082,
                        left: width*0.361,
                        child: Container(
                          // color: Colors.red,

                          child: SizedBox(
                            width: width*0.5,
                            child:  Text(state,
                              style: const TextStyle(color: Colors.white,fontFamily: "Poppins",fontSize: 13),),
                          ),
                        ),
                      ),
                      Positioned(
                        top: height*0.35,
                        left: width*0.28,
                        child: SizedBox(
                          width: width*0.6,
                          child: Text(iD,style: const TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white),),
                        ),
                      ),
                      Positioned(
                        top: height*0.28,
                        child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: width/8,top: height/7),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:  [
                                              const Icon(Icons.person_2_outlined,color: Colors.white,),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: width*0.6,
                                                child: Text(name,style: const TextStyle(
                                                  fontFamily: "Poppins",
                                                    color: Colors.white),),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 5,),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children:  [
                                               Image.asset("assets/memberIdCard.png",scale:2.7,),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: width*0.6,
                                                child: Text(iD,style: const TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: Colors.white),),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.phone,color: Colors.white,size: 20),
                                              // SizedBox(width: 5),
                                              SizedBox(
                                                width: width*0.6,
                                                child: Text(
                                                  "+91 $PhoneNumber",
                                                  style: const TextStyle(color: Colors.white,fontFamily: "Poppins",),),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 5,),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:  [
                                              const Icon(Icons.home_outlined,color: Colors.white),
                                              SizedBox(width: 5,),
                                              Container(
                                                // color: Colors.yellow,
                                                width: width*0.6,
                                                child: Text(address.replaceAll(RegExp(r"\s+"), " "),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins",),),
                                              )
                                            ],
                                          ),


                                          // SizedBox(height: height*0.06,),



                                        ],
                                      ),
                                    ),

                                    ]),
                      ),
                      Positioned(
                        bottom: height*0.016,
                        left: 72,
                        child: Container(
                          padding: EdgeInsets.only(left: width*0.02,),
                          // color: Colors.red,

                          child: SizedBox(
                            width: width*0.5,
                            child: const Text(
                              " Dec 2027",
                              style: TextStyle(color: Colors.white70,fontFamily: "Poppins",fontSize: 12),),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ):
         status=="UNPAID"? Column(
           children:[
             SizedBox(height: height/3.7),
             const Text("Your Payment is Pending...",
                 style: TextStyle(
                   color: Color(0xffFF4101),
                   fontFamily: "Poppins",
                   fontWeight: FontWeight.w800,
                   fontSize: 20,

                 )),
             const SizedBox(height: 15),
             // CircularProgressIndicator(
             //   color: myDarkGreen,
             //
             // )
           ],
         ):Column(
              children:[
                SizedBox(height: height/3.7),
                const Text("Please wait until your request is approved",
                  style: TextStyle(
                    fontFamily: "Poppins"
                ),),
                const Text("Your Request is Pending",style: TextStyle(
                    color: Color(0xffFF4101),
                    fontFamily: "Poppins",
                  fontWeight: FontWeight.w800,
                  fontSize: 20,

                )),
                const SizedBox(height: 15),
                // CircularProgressIndicator(
                //   color: myDarkGreen,
                //
                // )
              ],
            ),
           wantToShow? Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  InkWell(
                    onTap: () async {
                      MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
                      // Capture the screenshot of the widget
                      final Uint8List? imageBytes = await _captureScreenshot();

                      // Save the image to the device's gallery
                      await mainProvider.saveImageToGallery(imageBytes!);

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Membership Card saved to gallery!'),
                        backgroundColor: (Colors.black),

                      ));
                    },
                    child:  Column(
                      children: [
                        Icon(Icons.file_download_outlined,color: myDarkGreen,size: 17),
                        Text("Download",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w700,fontSize: 13,color: myDarkGreen,decoration: TextDecoration.underline),),
                      ],
                    ),
                  ),
                  const SizedBox(width: 25),
                  InkWell(
                    onTap: (){
                      DonationProvider donationProvider =
                      Provider.of<DonationProvider>(context, listen: false);
                      donationProvider.createImage(
                          'Send', '', screenshotController);
                    },
                    child: Column(
                      children: [
                        Transform.rotate(
                            angle: 30.56,
                            child:  Icon(Icons.send_rounded,color: myDarkGreen,size: 15,)),
                        Text("Share",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w700,fontSize: 13,color: myDarkGreen,decoration: TextDecoration.underline),),

                      ],
                    ),
                  ),

                ],
              ),
            ):SizedBox(),
            SizedBox(height: height/70),
            wantToShow==true||type=="YES"?
                 Container(
              width: 163,
              height: 43,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(54),border: Border.all(color: myDarkGreen)),
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return  AlertDialog(
                          backgroundColor: Colors.white,
                          scrollable: true,
                          title: const Text(
                            "Do you want to Logout",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          content: Consumer<MainProvider>(
                              builder: (context,value,child) {
                                return
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 35,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: myDarkGreen),
                                              borderRadius: BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            child: TextButton(
                                                child: Text('Cancel', style: TextStyle(color: myBlack)),
                                                onPressed: () {
                                                  finish(context);
                                                }),
                                          ),
                                          Container(
                                            height: 35,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: myDarkGreen),
                                              color: myDarkGreen,
                                              borderRadius: BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            child: TextButton(
                                                child: Text(
                                                  'Logout',
                                                  style: TextStyle(color: myWhite),
                                                ),
                                                onPressed: () {
                                                  FirebaseAuth auth = FirebaseAuth.instance;
                                                  auth.signOut();
                                                  callNextReplacement(const LoginScreen(), context);
                                                }),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                              }
                          ),
                        );
                      },
                    );
                  },
                  child: SizedBox(
                    width: 80,
                    // color: Colors.yellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:  [
                        Text("LogOut",style: TextStyle(color: myDarkGreen)),
                        SizedBox(width: 3,),
                        Icon(Icons.logout_outlined,color: myDarkGreen),

                      ],),
                  ),
                ),
              ),
            )
                :type=="YES"&&status=='UNPAID'?
            Container(
              width: 163,
              height: 43,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(54),border: Border.all(color: myDarkGreen)),
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return  AlertDialog(
                          backgroundColor: Colors.white,
                          scrollable: true,
                          title: const Text(
                            "Do you want to Logout",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          content: Consumer<MainProvider>(
                              builder: (context,value,child) {
                                return
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 35,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: myDarkGreen),
                                              borderRadius: BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            child: TextButton(
                                                child: Text('Cancel', style: TextStyle(color: myBlack)),
                                                onPressed: () {
                                                  finish(context);
                                                }),
                                          ),
                                          Container(
                                            height: 35,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: myDarkGreen),
                                              color: myDarkGreen,
                                              borderRadius: BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            child: TextButton(
                                                child: Text(
                                                  'Logout',
                                                  style: TextStyle(color: myWhite),
                                                ),
                                                onPressed: () {
                                                  FirebaseAuth auth = FirebaseAuth.instance;
                                                  auth.signOut();
                                                  callNextReplacement(const LoginScreen(), context);
                                                }),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                              }
                          ),
                        );
                      },
                    );
                  },
                  child: SizedBox(
                    width: 80,
                    // color: Colors.yellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:  [
                        Text("LogOut",style: TextStyle(color: myDarkGreen)),
                        SizedBox(width: 3,),
                        Icon(Icons.logout_outlined,color: myDarkGreen),

                      ],),
                  ),
                ),
              ),
            )
                :const SizedBox(),
            SizedBox(height: height/70),
          ],
        ),
      ),
    );
  }
  Future<Uint8List?> _captureScreenshot() async {
    // Find the widget to capture
    RenderRepaintBoundary boundary = previewContainer.currentContext
        ?.findRenderObject() as RenderRepaintBoundary;

    // Capture the image of the widget
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);

    // Convert the image to bytes
    final ByteData? byteData =
    await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List? imageBytes = byteData?.buffer.asUint8List();

    return imageBytes;
  }

}

