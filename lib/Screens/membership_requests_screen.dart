import 'package:flutter/material.dart';
import 'package:iuml_membership/Constants/my_functions.dart';
import 'package:iuml_membership/Screens/request_profile_data_screen.dart';
import 'package:iuml_membership/constants/my_colors.dart';
import 'package:provider/provider.dart';

import '../providers/Main_Provider.dart';

class MembershipRequestsScreen extends StatelessWidget {
  String uId;
  String state;
  String district;
  String assembly;
   MembershipRequestsScreen({super.key,required this.uId,required this.state,required this.district,required this.assembly,});

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context,listen: false);

    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        centerTitle: true,
        title: Text("Requests",style:TextStyle(color: myBlack,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: "Poppins"),),
        // leadingWidth: 100,
        // leading:InkWell(
        //   onTap: (){
        //   },
        //   child: Row(
        //     children: [
        //       Icon(Icons.arrow_back_ios_new,color: myDarkGreen,),
        //       Text("IUML",
        //         style:TextStyle(color: myGreen2,fontSize: 16,fontWeight: FontWeight.bold,fontFamily: "Poppins"),
        //       ),
        //     ],
        //   ),
        // ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Consumer<MainProvider>(
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 5),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:BorderRadius.circular(44),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26,
                            blurRadius:5.0)
                      ],
                    ),
                    child: TextField(
                      controller: value.searchController,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14, fontFamily: "Poppins", color: myBlack,fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                          hintText: "Search Members",
                          hintStyle:  TextStyle(fontSize: 14, fontFamily: "Poppins", color: myBlack,fontWeight: FontWeight.w500),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(44),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(44),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          prefixIcon: Icon(Icons.search_rounded,color: myBlack,)
                      ),
                      onChanged: (text){
                        mainProvider.searchRequestMembers(text);
                      },
                    ),
                  ),
                );
              }),
          SizedBox(height: 20,),
          Expanded(
            child: Consumer<MainProvider>(
                builder: (context,value,child) {
                  return value.requestMembersList.isNotEmpty?
                  ListView.builder(
                      itemCount: value.requestMembersList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var item= value.requestMembersList[index];
                        print(item.memberId+"rroprop");
                        return Column(
                          children: [
                            InkWell(
                              onTap: (){
                                mainProvider.editRequest(item.memberId);
                                callNext(RequestProfileDataScreen(), context);
                              },
                              child: Container(
                                margin:const EdgeInsets.symmetric(horizontal: 18),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Colors.white,
                                    border: Border.all(color: myGrey2,width: 0.5,)),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Container(
                                          height: 44,
                                          width: 45,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: myGrey2),
                                          child: item.photo!=""?
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.network(item.photo,fit: BoxFit.fill,))
                                              :Image.asset("assets/profile.png",scale: 1.7,)),
                                      title:  Text(item.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "PoppinsMedium",
                                            fontSize: 15,
                                            color: Colors.black
                                        ),),
                                      subtitle: Text("Phone : "+item.phone,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "PoppinsMedium",
                                            fontSize: 15,
                                            color: Colors.black
                                        ),),
                                      trailing: Container(
                                          width: 68,
                                          height: 34,
                                          decoration: BoxDecoration(
                                              color: mainColor,
                                              borderRadius: BorderRadius.circular(81),
                                              border: Border.all(color: myGrey2,width: 0.5)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  mainProvider.whatsappLaunch(number: item.phone, message: '');
                                                },
                                                  child: Image.asset("assets/whatsapp.png",scale: 2.8,)),
                                              InkWell(
                                                  onTap: (){
                                                    mainProvider.makingPhoneCall(item.phone);
                                                  },
                                                  child: Image.asset("assets/Contact.png",scale: 2,)),
                                            ],
                                          )),
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            mainProvider.rejectRequest(item.memberId,state,district,assembly,uId);
                                            const snackBar = SnackBar(
                                                content: Text('Rejected Successfully'));
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            mainProvider.getRequests(state);

                                          },
                                          child: Container(
                                            height: 30,
                                            width: 124,
                                            margin: const EdgeInsets.symmetric(horizontal: 12),
                                            decoration: BoxDecoration(
                                              color: clFF7070,
                                              borderRadius: BorderRadius.circular(52),
                                            ),
                                            child: const Center(
                                              child: Text("Reject",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "PoppinsMedium"
                                                ),),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap:(){
                                            mainProvider.acceptRequest(item.memberId,uId,item.name,item.phone,item.state,item.district,item.assembly,item.unit);
                                            const snackBar = SnackBar(
                                                content: Text('Approved Successfully'));
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            mainProvider.getMembersCount(item.state,item.district,item.assembly,item.unit,'ASSEMBLY_LEVEL');

                                            // mainProvider.getRequests(state, district, assembly);
                                            },
                                          child: Container(
                                            height: 30,
                                            width: 124,
                                            margin: const EdgeInsets.symmetric(horizontal: 12),
                                            decoration: BoxDecoration(
                                              color: cl02B100,
                                              borderRadius: BorderRadius.circular(52),
                                            ),
                                            child: const Center(
                                              child: Text("Approve",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "PoppinsMedium"
                                                ),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),

                              ),
                            ),
                            SizedBox(height: 5,)
                          ],
                        );
                       })
                      :Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                          Text("There is no Request is Pending"),
                        ],
                      );
                }
            ),
          ),
        ],
      ),
    );
  }
}
