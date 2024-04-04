import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:ui' as ui;
import '../constants/my_colors.dart';
import '../constants/my_text.dart';
import '../providers/donation_provider.dart';

class MemberShipCardScreen extends StatelessWidget {
  String uid;
  String proffetion;
  String photo;
  String userName;

  MemberShipCardScreen({Key? key,required this.uid,required this.proffetion,
  required this.photo,required this.userName}) : super(key: key);

  ScreenshotController screenshotController = ScreenshotController();
  GlobalKey previewContainer = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: mainColor,
        leading: Icon(Icons.arrow_back_ios_new, color: myGreen),
        title: Text("IUML",
            style: TextStyle(
                fontFamily: "PoppinsMedium",
                color: myGreen,
                fontWeight: FontWeight.w900,
                fontSize: 22)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'My Membership Card',
                  style: style3,
                )),
            SizedBox(
              height: height * 0.04,
            ),
            SizedBox(height: 200,),

            Text("Coming Soon..."),
            // RepaintBoundary(
            //   key: previewContainer,
            //   child: Screenshot(
            //     controller: screenshotController,
            //     child: Container(
            //       height: 500,
            //       // width: 304,
            //       margin: EdgeInsets.symmetric(horizontal: 28),
            //       decoration: const BoxDecoration(
            //           borderRadius: BorderRadius.all(Radius.circular(29)),
            //           image: DecorationImage(
            //               fit: BoxFit.cover,
            //               image: AssetImage(
            //                 'assets/membCard1.png',
            //               ))),
            //       child: Padding(
            //         padding: const EdgeInsets.only(left: 10,right: 10),
            //         child: Column(
            //           // mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //
            //             Padding(
            //               padding: const EdgeInsets.only(top: 25.0),
            //               child: CircleAvatar(
            //                 backgroundColor: Colors.red,
            //                 radius: 50,
            //               ),
            //             ),
            //             SizedBox(height: 50,),
            //
            //             Container(height: 160,
            //             // color: Colors.black,
            //               child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                 children: [
            //                   const Text(
            //                     'IUML',
            //                     textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                       color: Colors.white,
            //                       fontSize: 22.85,
            //                       fontFamily: 'PoppinsMedium',
            //                       fontWeight: FontWeight.w700,
            //                     ),
            //                   ),
            //                   SizedBox(height: height*0.015,),
            //                   Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Expanded(flex:2,
            //                         child: Container(width:width*0.25,
            //                           child: const Text(
            //                             'Name ',
            //                             style: TextStyle(
            //                               color: Colors.white,
            //                               fontSize: 11.92,
            //                               fontFamily: 'PoppinsMedium',
            //                               fontWeight: FontWeight.w700,
            //                             ),
            //                           ),
            //                         ),
            //                       ),Expanded(flex: 5,
            //                         child: SizedBox(width: 180,
            //                           child:  Text(maxLines: 2,
            //                             userName,
            //                             style: TextStyle(overflow: TextOverflow.ellipsis,
            //                               color: Colors.white,
            //                               fontSize: 11.92,
            //                               fontFamily: 'PoppinsMedium',
            //                               fontWeight: FontWeight.w700,
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //
            //                     ],
            //                   ),
            //                   Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Expanded(flex: 2,
            //                         child: Container(
            //                           // width:width*0.25,
            //                           child: const Text(
            //                             'Proffession ',
            //                             style: TextStyle(
            //                               color: Colors.white,
            //                               fontSize: 11.92,
            //                               fontFamily: 'PoppinsMedium',
            //                               fontWeight: FontWeight.w700,
            //                             ),
            //                           ),
            //                         ),
            //                       ),Expanded(flex: 5,
            //                         child: Container(
            //                           // width: 180,
            //                           child:  Text(maxLines: 2,
            //                             proffetion,
            //                             style: TextStyle(overflow: TextOverflow.ellipsis,
            //                               color: Colors.white,
            //                               fontSize: 11.92,
            //                               fontFamily: 'PoppinsMedium',
            //                               fontWeight: FontWeight.w700,
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //
            //                     ],
            //                   ),
            //                   Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Expanded(flex:2,
            //                         child: Container(width:width*0.25,
            //                           child: const Text(
            //                             'House Name ',
            //                             style: TextStyle(
            //                               color: Colors.white,
            //                               fontSize: 11.92,
            //                               fontFamily: 'PoppinsMedium',
            //                               fontWeight: FontWeight.w700,
            //                             ),
            //                           ),
            //                         ),
            //                       ),Expanded(flex: 5,
            //                         child: Container(width: 200,
            //                           child:  Text(maxLines: 2,
            //                             houseName,
            //                             style: TextStyle(overflow: TextOverflow.ellipsis,
            //                               color: Colors.white,
            //                               fontSize: 11.92,
            //                               fontFamily: 'PoppinsMedium',
            //                               fontWeight: FontWeight.w700,
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //
            //                     ],
            //                   ),
            //
            //                 ],
            //               ),
            //             ),
            //             SizedBox(height: 100,),
            //             Align(alignment: Alignment.bottomCenter,
            //               child: Container(
            //                 alignment: Alignment.bottomCenter,
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(bottom: 15.0),
            //                   child: Column(
            //                     children:  [
            //                       const Text(
            //                         'Member ID',
            //                         style: TextStyle(
            //                             fontFamily: "PoppinsMedium",
            //                             fontSize: 12,
            //                             fontWeight: FontWeight.w700,
            //                             color: Colors.white),
            //                       ),
            //                       Text(
            //                         uid,
            //                         style: const TextStyle(
            //                             fontFamily: "PoppinsMedium",
            //                             fontSize: 12,
            //                             fontWeight: FontWeight.w700,
            //                             color: Colors.white),
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //
            //
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 35,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     InkWell(
            //       onTap: () async {
            //         // Capture the screenshot of the widget
            //         final Uint8List? imageBytes = await _captureScreenshot();
            //
            //         // Save the image to the device's gallery
            //         await saveImageToGallery(imageBytes!);
            //
            //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //           content: const Text('Receipt saved to gallery!'),
            //           backgroundColor: (Colors.black),
            //           action: SnackBarAction(
            //             label: 'dismiss',
            //             onPressed: () {
            //               print("after Function loaded");
            //             },
            //           ),
            //         ));
            //       },
            //       child: Column(
            //         children: [
            //           CircleAvatar(
            //             radius: 15,
            //             backgroundColor: Colors.white,
            //             child: Center(
            //                 child: Image.asset(
            //               'assets/downloadPng.png',
            //               scale: 2,
            //             )),
            //           ),
            //           Text(
            //             'Download',
            //             style: TextStyle(
            //                 decoration: TextDecoration.underline,
            //                 fontFamily: "PoppinsMedium",
            //                 fontSize: 13,
            //                 fontWeight: FontWeight.w700,
            //                 color: myDarkGreen),
            //           )
            //         ],
            //       ),
            //     ),
            //     SizedBox(
            //       width: 80,
            //     ),
            //     InkWell(onTap: (){
            //       donationProvider.createImage(
            //           'Send', '', screenshotController);
            //     },
            //       child: Column(
            //         children: [
            //           CircleAvatar(
            //             radius: 15,
            //             backgroundColor: Colors.white,
            //             child: Center(
            //                 child: Image.asset(
            //               'assets/SharePng.png',
            //               scale: 2,
            //             )),
            //           ),
            //           Text(
            //             'Share',
            //             style: TextStyle(
            //                 decoration: TextDecoration.underline,
            //                 fontFamily: "PoppinsMedium",
            //                 fontSize: 13,
            //                 fontWeight: FontWeight.w700,
            //                 color: myDarkGreen),
            //           )
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Future<Uint8List?> _captureScreenshot() async {
    // Find the widget to capture
    RenderRepaintBoundary boundary = previewContainer?.currentContext
        ?.findRenderObject() as RenderRepaintBoundary;

    // Capture the image of the widget
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);

    // Convert the image to bytes
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List? imageBytes = byteData?.buffer.asUint8List();

    return imageBytes;
  }

  Future<void> saveImageToGallery(Uint8List imageBytes) async {
    // Save the image to the device's gallery
    final result = await ImageGallerySaver.saveImage(imageBytes, quality: 100);

    // Show a message to the user
    if (result['isSuccess']) {
      print('Image saved to gallery.');
    } else {
      print('Failed to save image to gallery.');
    }
  }
}
