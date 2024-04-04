import 'package:flutter/material.dart';
import 'package:iuml_membership/Constants/my_functions.dart';
import 'package:iuml_membership/Screens/add_coordinator_scren.dart';
import 'package:iuml_membership/Screens/request_Pending_Page.dart';
import 'package:provider/provider.dart';
import '../constants/my_colors.dart';
import '../constants/my_text.dart';
import '../providers/Main_Provider.dart';

class CoordinatorScreen extends StatelessWidget {
  String from;
  String state;
  String district;
  String assembly;
  String unit;
  String userName;
  String phoneno;
  String uId;
  String photo;
  String address;
  String coordinatorLevel;
   CoordinatorScreen({super.key,required this.from,required this.state,required this.district,required this.assembly, required this.unit,
     required this.userName,required this.phoneno,required this.uId,required this.photo,required this.address,required this.coordinatorLevel,});

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        centerTitle: true,
        title:  Text("Coordinators",
            style:appbarStyle
        ),
        leadingWidth: 100,
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),

       from=="UNIT_LEVEL"? Column(
          children: [
            photo!=''?CircleAvatar(
              radius: 45,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(photo,),
            )
                :Container(
                height: 80,
                width: 85,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: myWhite3,
                  boxShadow: const [
                    BoxShadow(color: Colors.black26,
                        blurRadius:1.0)
                  ],
                ),
                child: Image.asset("assets/profile.png",scale: 2,color: myGreen3, )),
            SizedBox(height: 5,),
            Text(userName,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: "PoppinsMedium",
                  fontSize: 13,
                  color: Colors.black
              ),),
            InkWell(
              onTap: (){
                callNext( RequestPendingPage(
                  wantToShow: true,
                  name: userName,
                  address: address,
                  PhoneNumber:phoneno,
                  iD: uId,
                  photo:photo,
                  type: "YES",
                  status: '',
                  state: state,
                ), context);
              },
              child: Container(
                height: 30,
                width: 120,
                margin: const EdgeInsets.symmetric(horizontal: 18,vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(81),
                    border: Border.all(color:myDarkGreen )
                ),
                child:  Center(
                  child: Text("Profile",
                    style: TextStyle(
                        color: myDarkGreen,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        fontFamily: "PoppinsMedium",
                        letterSpacing: 0.39
                    ),),
                ),
              ),
            ),

            SizedBox(height: 20,),
          ],
        ):SizedBox(),


          Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 15,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(from=="NATIONAL_LEVEL"?"NATIONAL LEVEL"
                    : from=="STATE_LEVEL"?"STATE LEVEL"
                    : from=="DISTRICT_LEVEL"?"DISTRICT LEVEL"
                    : from=="ASSEMBLY_LEVEL"?"ASSEMBLY LEVEL"
                    : "UNIT LEVEL",
                style: style2,),
                Consumer<MainProvider>(
                  builder: (context,value,child) {
                    print(coordinatorLevel+" ppspospo "+from);
                    return from=='NATIONAL_LEVEL'||value.stateCoordinatorLock && coordinatorLevel!=from?
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: (){
                          mainProvider.clearCoordinators();
                          callNext(AddCoordinatorScreen(from: from, state: state, district: district, assembly: assembly,unit: unit,type:"",coordId: '',uId: uId), context);
                        },
                        child: Container(
                          height: 28,
                          width: 140,
                          // margin: const EdgeInsets.symmetric(horizontal: 75),
                          decoration: BoxDecoration(
                            color: myDarkGreen,
                            borderRadius: BorderRadius.circular(52),
                          ),
                          child:  const Center(
                            child: Text("Add Coordinators",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "PoppinsMedium"
                              ),),
                          ),
                        ),
                      ),
                    )

                        :SizedBox();
                  }
                )
              ],
            ),
          ),
          Expanded(
            child: Consumer<MainProvider>(
                builder: (context,value,child) {
                  return value.getCoordinator(from).isNotEmpty? ListView.builder(
                      itemCount: value.getCoordinator(from).length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var item= value.getCoordinator(from)[index];
                        print(from+"rroprop");
                        return Column(
                          children: [
                            InkWell(
                              onLongPress: (){
                               if(from=="NATIONAL_LEVEL"||coordinatorLevel!=from){
                                 committeeAlert(context,item.coordinatorId,from,item.state,item.district,item.assembly,item.unit,item.phone,uId);

                               }
                            },
                              child: Container(
                                margin:const EdgeInsets.symmetric(horizontal: 18),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(23),
                                    color: Colors.white,
                                    border: Border.all(color: myGrey2,width: 0.5,),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius:2.0)
                                  ],),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Container(
                                          height: 44,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: myGrey,
                                            boxShadow: const [
                                              BoxShadow(color: Colors.black26,
                                                  blurRadius:1.0)
                                            ],
                                          ),
                                          child: item.photo!=""?
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.network(item.photo,fit: BoxFit.fill,))
                                              :Image.asset("assets/profile.png",scale: 2,)),
                                      title:  Text(item.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "PoppinsMedium",
                                            fontSize: 13,
                                            color: Colors.black
                                        ),),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(item.phone,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "PoppinsMedium",
                                                fontSize: 13,
                                                color: Colors.black
                                            ),),
                                            from == "NATIONAL_LEVEL"?
                                            SizedBox(): from == "STATE_LEVEL"?
                                            Text(item.state,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "PoppinsMedium",
                                                  fontSize: 13,
                                                  color: Colors.black
                                              ),):from == "DISTRICT_LEVEL"?
                                            Text(item.district,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "PoppinsMedium",
                                                  fontSize: 13,
                                                  color: Colors.black
                                              ),):from == "ASSEMBLY_LEVEL"?
                                            Text(item.assembly,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "PoppinsMedium",
                                                  fontSize: 13,
                                                  color: Colors.black
                                              ),):
                                            Text(item.unit,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "PoppinsMedium",
                                                  fontSize: 13,
                                                  color: Colors.black
                                              ),),
                                          Text(item.designation,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "PoppinsMedium",
                                                fontSize: 12,
                                                color: Colors.black
                                            ),),
                                        ],
                                     ),

                                      trailing: Container(
                                          width: 62,
                                          height: 34,
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              color: mainColor,
                                              borderRadius: BorderRadius.circular(81),
                                              border: Border.all(color: myGrey2,width: 0.5)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap:(){
                                                  mainProvider.whatsappLaunch(number: item.phone,message: 'hi');
                                                },
                                                  child: Image.asset("assets/whatsapp.png",scale: 2.8,)),
                                              SizedBox(width: 3,),
                                              InkWell(
                                                  onTap:(){
                                                    mainProvider.makingPhoneCall(item.phone);
                                                  },
                                                  child: Image.asset("assets/Contact.png",scale: 1,)),
                                            ],
                                          )),
                                    ),
                                    SizedBox(height: 5,),
                                  ],
                                ),

                              ),
                            ),
                            SizedBox(height: 5,)
                          ],
                        );
                      }):Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                        Center(
                            child: Text("There is no Coordinator")),
                    ],
                  );
                }
            ),
          ),
        ],
      ),

    );

  }


  committeeAlert(BuildContext context,String id,String from,String state, String district,
      String assembly,String unit,String phnNo,String uid) {
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      scrollable: true,
      title:  const Text(
        "Do you want to Edit/Delete?",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      actions: [
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
                  child: Text('Edit', style: TextStyle(color: myBlack)),
                  onPressed: () {
                    finish(context);
                    mainProvider.editCoordinator(id);
                    callNext(AddCoordinatorScreen(from: from, state: state, district: district, assembly: assembly, unit: unit,type: "Edit",coordId: id,uId: uId), context);
                  }),
            ),
            Consumer<MainProvider>(
              builder: (context,val,child) {
                return val.coordinatorDeleteLoader?CircularProgressIndicator(color: myDarkGreen,):
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
                        'Delete',
                        style: TextStyle(color: myWhite),
                      ),
                      onPressed: () {
                     mainProvider.deleteCordinator(id, from, state, district, assembly, unit,phnNo,context,uid);
                      }),
                );
              }
            ),
          ],
        ),
        SizedBox(height: 5,),
      ],
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

}
