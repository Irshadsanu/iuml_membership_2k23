import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iuml_membership/Screens/request_Pending_Page.dart';
import 'package:iuml_membership/constants/my_colors.dart';
import 'package:iuml_membership/providers/Main_Provider.dart';
import 'package:provider/provider.dart';

import '../Constants/my_functions.dart';

class LoginMembersList extends StatelessWidget {
  final String phone;
   const LoginMembersList({Key? key,required this.phone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double height=MediaQuery.of(context).size.height;
    final double width=MediaQuery.of(context).size.width;

    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.getMemberList(phone);

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/Splash.jpg",),fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 40),
                  // color: Colors.red,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       SizedBox(
                         // width: width,
                         child: Text(
                          "Registered Members List\nWith $phone",
                          style: const TextStyle(
                              fontFamily: 'BarlowCondensed',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                          ),
                           textAlign: TextAlign.center
                        ),
                       ),

                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: width/1.15,
                    child: Consumer<MainProvider>(
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              // SizedBox(height: height/4,),
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const ScrollPhysics(),
                                itemCount: value.memberDocList.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  DocumentSnapshot memberDoc = value.memberDocList[index];
                                  Map mDocData = memberDoc.data() as Map;
                                  return InkWell(
                                    onTap: (){
                                      if(mDocData["STATUS"].toString() == "PAID"){
                                      if(!mDocData.containsKey("REQUEST_STATUS")){
                                        print("sdfghjkl"+phone);
                                        callNextReplacement(RequestPendingPage(wantToShow: true, name: mDocData["NAME"].toString(), address: mDocData["ADDRESS"].toString(), PhoneNumber: mDocData["PHONE_NUMBER"].toString(), photo: mDocData["PHOTO"].toString(),iD: mDocData["MEMBER_ID"].toString(),type: "YES", status: '', state: mDocData["STATE"].toString(),), context);

                                      }else if(mDocData["REQUEST_STATUS"] == "APPROVE"){
                                        print("irshad");

                                        callNextReplacement(RequestPendingPage(wantToShow: true, name: mDocData["NAME"].toString(), address: mDocData["ADDRESS"].toString(), PhoneNumber: mDocData["PHONE_NUMBER"].toString(), photo: mDocData["PHOTO"].toString(),iD: mDocData["MEMBER_ID"].toString(),type: "YES", status: '',state: mDocData["STATE"].toString()), context);
                                      }else {
                                        print("hiba");
                                        callNextReplacement(RequestPendingPage(wantToShow: false, name: mDocData["NAME"].toString(), address: mDocData["ADDRESS"].toString(), PhoneNumber: mDocData["PHONE_NUMBER"].toString(), photo: mDocData["PHOTO"].toString(),iD: mDocData["MEMBER_ID"].toString(),type: "YES", status: '',state: mDocData["STATE"].toString()), context);
                                      }
                                   }else{
                                        callNextReplacement(RequestPendingPage(wantToShow: false,name:mDocData["NAME"].toString(), address: mDocData["ADDRESS"].toString(), PhoneNumber: mDocData["PHONE_NUMBER"].toString(), photo: mDocData["PHOTO"].toString(),iD: mDocData["MEMBER_ID"].toString(),type: "YES", status: 'UNPAID',state: mDocData["STATE"].toString()), context);

                                      }
                                    },
                                    child: Container(
                                      // height: 54,
                                      margin:const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.white,
                                          border: Border.all(color: myGrey2,width: 0.5,)),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: Container(
                                                height: 44,
                                                width: 45,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: myGrey2),
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(8),
                                                    child:mDocData["PHOTO"].toString() == ''?
                                                    Image.asset("assets/profile.png",scale: 1.7,):
                                                    Image.network(mDocData["PHOTO"].toString(),fit: BoxFit.fill,)
                                                )),
                                            title:  Text(mDocData["NAME"].toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "PoppinsMedium",
                                                    fontSize: 15,
                                                    color: Colors.black
                                                )),
                                            subtitle: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(mDocData["MEMBER_ID"].toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: "Poppins",
                                                      fontSize: 13,
                                                      color: myBlack.withOpacity(0.5)),),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 5),

                                        ],
                                      ),
                                    ),
                                  );


                                },
                              ),
                            ],
                          );
                        }),
                  ),
                ),

              ],
            ),
          ),
        ),

      ),
    );
  }
}
