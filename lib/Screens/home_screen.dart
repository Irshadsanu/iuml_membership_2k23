import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:iuml_membership/Screens/Add_New_Member.dart';
import 'package:iuml_membership/Screens/bottom_navigation.dart';
import 'package:iuml_membership/Screens/payment_gateway.dart';
import 'package:iuml_membership/Screens/request_Pending_Page.dart';
import 'package:iuml_membership/constants/my_colors.dart';
import 'package:iuml_membership/constants/my_functions.dart';
import 'package:iuml_membership/constants/my_text.dart';
import 'package:iuml_membership/providers/Main_Provider.dart';
import 'package:provider/provider.dart';
import '../providers/donation_provider.dart';
import 'newPaymentGatewayScreen.dart';

class HomeScreen extends StatelessWidget {
  String uId;
  String from;
  String userName;String state,district, assembly, unit;
  String PhoneNumber,photo,address,loginLevel;
  HomeScreen({Key? key,
    required this.uId,
    required this.from,
    required this.userName,
    required this.state,
    required this.district,
    required this.assembly,
    required this.unit,
    required this.PhoneNumber,
    required this.photo,
    required this.address,required this.loginLevel,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      // mainProvider.fetchEvent(from,state, district, assembly, panchayath, unit);
    });
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;

    print(state+"STATE");
    print(district+"DISTRICT");
    print(assembly+"ASSEMBLY");
    print(unit+"UNIT");
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async{
          print(from+' CHFVJNRV');
          mainProvider.setListAfterSearch(from);
           if(from=='STATE_LEVEL'){
             mainProvider.getAllMembersCount();
             // mainProvider.getMembersCount(state, district, assembly, unit,"NATIONAL_LEVEL");
             // mainProvider.getUnPaidMembersCount(state, district, assembly, unit,"NATIONAL_LEVEL");
          }else if(from=='DISTRICT_LEVEL'){
             mainProvider.getPaidMemberCountState(state);
             // mainProvider.getMembersCount(state, district, assembly, '',"STATE_LEVEL");
             // mainProvider.getUnPaidMembersCount(state, district, assembly, '',"STATE_LEVEL");
           }else if(from=='ASSEMBLY_LEVEL'){
             print(assembly+' BGUJFHR');
             mainProvider.getPaidMemberCountDistrict(district);
             // mainProvider.getMembersCount(state, district, assembly, '',"DISTRICT_LEVEL");
             // mainProvider.getUnPaidMembersCount(state, district, assembly, '',"DISTRICT_LEVEL");
           }else{
             mainProvider.getPaidMemberCountAssembly(district,assembly);

             // mainProvider.getMembersCount(state, district, assembly, '',"ASSEMBLY_LEVEL");
             // mainProvider.getUnPaidMembersCount(state, district, assembly, '',"ASSEMBLY_LEVEL");
             mainProvider.memberAmount=0;
          }


          return true;
        },
        child: Scaffold(
          body: DefaultTabController(
            length: 2,
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [myGreen3, myGreen3]),
                // image: const DecorationImage(
                //     image: AssetImage("assets/baground.png"),
                //     scale: 1,
                //     fit: BoxFit.contain,
                //     alignment: Alignment(-0.5, -0.7)),
              ),
              child: Column(





                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children:  const [
                          // Padding(
                          //   padding: EdgeInsets.only(left: 8,right: 4,top: 8),
                          //   child:photo==""?CircleAvatar(
                          //     radius: 18,
                          //     backgroundColor: myGreen,
                          //     child: Icon(Icons.person,color: myWhite,),
                          //   ) :CircleAvatar(
                          //     backgroundImage:NetworkImage(photo),
                          //     radius: 18,
                          //   ),
                          // ),
                          SizedBox(width: 10),
                          Padding(
                            padding: EdgeInsets.only(top: 8,left: 4),
                            child: Text(
                            "IUML",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: InkWell(
                          // onTap: (){
                          //   FirebaseAuth auth = FirebaseAuth.instance;
                          //   auth.signOut();
                          //   callNextReplacement(const LoginScreen(), context);
                          // },
                          child: Row(
                            children: [
                               Text(from,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    fontFamily: "Poppins"),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                "assets/unitIcon.png",
                                scale: 3,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Consumer<MainProvider>(
                    builder: (context,val,child) {
                      return Container(
                        height: height*0.16,
                        width: 364,
                        margin: EdgeInsets.only(top:height*0.015,bottom: height*0.02,left: width*0.037,right: width*0.037),
                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(image: AssetImage("assets/homebg.png"),fit: BoxFit.fill)
                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                           Image.asset("assets/unpaidIcon.png",scale: 1.5,),
                           InkWell(onTap: (){
                             // mainProvider.loopLock();
                             // mainProvider.fetchMasterData(from,state,district,assembly);
                             // callNext(RegistrationReportScreen(
                             //   state: state,
                             //   from: from,
                             //   assembly: assembly,
                             //   distrct: district,
                             // ), context);
                           },
                             child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 const Text("All\n Members",style: TextStyle(color: Colors.white,fontFamily: "Poppins",fontSize: 16),textAlign: TextAlign.center),
                                 Text(val.allPaidMembersCount.toString(),
                                     style: TextStyle(color: Colors.white,fontFamily: "Poppins",fontSize: 30,fontWeight: FontWeight.w900),)
                               ],
                             ),
                           ),
                           Container(margin: const EdgeInsets.symmetric(vertical:10),height: height*0.16,width: 1,color: Colors.white60),
                           Image.asset("assets/allMembersIcon.png",scale: 1.5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Unpaid\nMembers",style: TextStyle(color: Colors.white,fontFamily: "Poppins",fontSize: 16),textAlign: TextAlign.center),
                                Text(val.allUnPaidMembersCount.toString(),
                                    style: const TextStyle(color: Colors.white,fontFamily: "Poppins",fontSize: 30,fontWeight: FontWeight.w900))
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        mainProvider.getLanguages(context,"English");
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(18)),
                          border: Border.all(color: Colors.white,width: 1)
                        ),
                          width: width/2.4,
                          height: 32,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/img_2.png"),
                              const SizedBox(width: 10,),
                              const Text("HOW TO USE",style: TextStyle(color: Colors.white,fontFamily: "Poppins",fontSize: 12),)
                            ],
                          )
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        mainProvider.fetchDetails();
                        mainProvider.alertSupport(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(18)),
                        border: Border.all(color: Colors.white,width: 1)
                      ),
                        width: width/2.4,
                        height: 32,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("SUPPORT",style: TextStyle(color: Colors.white,fontFamily: "Poppins",fontSize: 12),),
                              const SizedBox(width: 10,),
                            Image.asset("assets/img_3.png",scale: 1.5,),
                            ],
                          )
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 4,),

                from == "UNIT_LEVEL" ?  Expanded(
                    child: Container(
                      height: height,
                      // margin: EdgeInsets.only(top: height /4.2),
                      alignment: Alignment.topCenter,
                      decoration:  BoxDecoration(
                        color: mainColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        children: [
                          Consumer<MainProvider>(
                              builder: (context, providerValue, child) {
                            return TabBar(
                                padding: EdgeInsets.symmetric(horizontal: width / 45,vertical: 12),
                                labelPadding: EdgeInsets.zero,
                                indicator: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight:Radius.circular(20), ),
                                    color: myDarkGreen),
                                labelColor: Colors.white,
                                indicatorPadding:  EdgeInsets.all(5),
                                unselectedLabelColor: Colors.black,
                                onTap: (value) {
                                  providerValue.tabIndex(value);
                                },
                                tabs: [
                                  Tab(
                                    child: Container(
                                      width: width / 2,
                                      height: height / 28,

                                      child: const Center(
                                          child: Text("Paid Members",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w700))),
                                    ),
                                  ),
                                  Tab(
                                    child: Container(
                                      width: width / 2,
                                      height: height / 25,
                                      child: const Center(
                                          child: Text("UnPaid Members",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w700))),
                                    ),
                                  ),
                                ]);
                          }),

                          SizedBox(height: 5,),
                          Expanded(
                            child: Consumer<MainProvider>(
                              builder: (context,value,child) {
                                return TabBarView(
                                    children: [
                                      Column(
                                        children: [
                                          Consumer<MainProvider>(
                                              builder: (context, value, child) {
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                                                  child: Container(
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
                                                      onChanged: (value) {
                                                        mainProvider.searchAllMembers(value);

                                                      },
                                                      decoration: InputDecoration(
                                                        hintText: "Search Members",

                                                        hintStyle:  TextStyle(fontSize: 12, fontFamily: "Poppins", color: myBlack),
                                                        contentPadding: const EdgeInsets.symmetric(
                                                            vertical: 15, horizontal: 10),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(44),
                                                          borderSide: const BorderSide(color: Colors.white),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(44),
                                                          borderSide: const BorderSide(color: Colors.white),
                                                        ),
                                                          prefixIcon: Icon(Icons.search_rounded,color: myBlack,)

                                                        // suffixIcon: InkWell(
                                                        //   onTap: () {
                                                        //
                                                        //   },
                                                        //   child: AnimatedContainer(
                                                        //     width: 30,
                                                        //     duration: const Duration(milliseconds: 700),
                                                        //     child: Row(
                                                        //       children: [
                                                        //         Container(width: 1.5,color: myGreen,height: 26,),
                                                        //         AnimatedContainer(
                                                        //           duration: const Duration(milliseconds:500 ),
                                                        //           width:7,),
                                                        //         Icon(Icons.arrow_forward_rounded,color: myGreen,)
                                                        //       ],
                                                        //     ),
                                                        //   ),),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                          Expanded(
                                            child: value.memberModelList.isNotEmpty? ListView.builder(
                                              physics: const ScrollPhysics(),
                                                itemCount: value.memberModelList.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                var item= value.memberModelList[index];
                                              return Column(
                                               children: [
                                                InkWell(

                                                  onTap: () {
                                                    // editDeleteAlert(context,value.memberModelList[index].MemberId,value.memberModelList[index].paymentStatus);
                                                    callNext(RequestPendingPage(wantToShow:true,name: item.name, address: item.adddress, PhoneNumber: item.PhoneNumber, photo: item.photo, iD:item.MemberId,type: "NO", status: '',state:item.state ), context);
                                                  },
                                                  child: Container(
                                                    // height: 54,
                                                    margin:const EdgeInsets.symmetric(horizontal: 14),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                        color: Colors.white,
                                                        border: Border.all(color: myGrey2,width: 0.5,)),
                                                    child: ListTile(
                                                      leading: Container(
                                                        height: 44,
                                                          width: 45,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(8),color: myGrey2),
                                                          child:item.photo == "" ?
                                                          Image.asset("assets/profile.png",scale: 2.5 ) :
                                                          ClipRRect(
                                                              borderRadius: BorderRadius.circular(8),
                                                              child: Image.network(item.photo,fit: BoxFit.fill)),),
                                                      title:  Text(item.name,
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          fontFamily: "PoppinsMedium",
                                                          fontSize: 15,
                                                          color: Colors.black
                                                      ),),
                                                      subtitle: Text("Membership ID : ${item.MemberId}",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontFamily: "Poppins",
                                                          fontSize: 12,
                                                          color: myBlack.withOpacity(0.5)),),
                                                      trailing: Container(
                                                          width: 62,
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
                                                                    mainProvider.whatsappLaunch(number: item.PhoneNumber,message: 'hi');
                                                                  },
                                                                  child: Image.asset("assets/whatsapp.png",scale: 2.8,)),
                                                              InkWell(
                                                                  onTap: (){
                                                                    mainProvider.makingPhoneCall(item.PhoneNumber);

                                                                  },
                                                                  child: Image.asset("assets/Contact.png",scale: 2,)),
                                                            ],
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 5,)
                                              ],
                                             );
                                            }): const Center(child: Text("Please add members.")),
                                          )

                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Consumer<MainProvider>(
                                              builder: (context, value, child) {
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:BorderRadius.circular(44),
                                                      boxShadow: const [
                                                        BoxShadow(color: Colors.black26,
                                                            blurRadius:5.0)
                                                      ],
                                                    ),
                                                    child: TextField(
                                                      controller: value.unpaidSearchController,
                                                      textAlign: TextAlign.left,
                                                      onChanged:(value) {
                                                        mainProvider.searchUnpaidMembers(value);
                                                      },
                                                      decoration: InputDecoration(
                                                        hintText: "Search Members",
                                                        hintStyle:  TextStyle(fontSize: 12, fontFamily: "Poppins", color: myBlack),
                                                        contentPadding: const EdgeInsets.symmetric(
                                                            vertical: 15, horizontal: 10),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(44),
                                                          borderSide: const BorderSide(color: Colors.white),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(44),
                                                          borderSide: const BorderSide(color: Colors.white),
                                                        ),
                                                          prefixIcon: Icon(Icons.search_rounded,color: myBlack,)

                                                        // suffixIcon: InkWell(
                                                        //   onTap: () {},
                                                        //   child: AnimatedContainer(
                                                        //     width: 30,
                                                        //     duration: const Duration(milliseconds: 700),
                                                        //     child: Row(
                                                        //       children: [
                                                        //         Container(width: 1.5,color: myGreen,height: 26,),
                                                        //         AnimatedContainer(
                                                        //           duration: const Duration(milliseconds:500 ),
                                                        //           width:7,),
                                                        //         Icon(Icons.arrow_forward_rounded,color: myGreen,)
                                                        //       ],
                                                        //     ),
                                                        //   ),),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20.0,right: 20,top: 8,bottom: 8),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    value.selectAllMembers(context,value.memberModelList.indexWhere((element) => element.selected=true));
                                                  },
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text("Select All",
                                                      style: TextStyle(fontSize: 13,
                                                      fontFamily: "PoppinsMedium",
                                                      fontWeight: FontWeight.w700)),
                                                      const SizedBox(width: 5),
                                                      value.selectAll&&value.unPaidMemberModelList.where((element) => element.selected==true).isNotEmpty?
                                                      Image.asset("assets/memberSelect.png",scale: 3,) :
                                                      Image.asset("assets/memberUnselect.png",scale: 3,),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children:  [
                                                    const Text("Selected",
                                                      style: TextStyle(fontSize: 13,
                                                          fontFamily: "PoppinsMedium",
                                                          fontWeight: FontWeight.w400),),
                                                    SizedBox(width: 10,),
                                                    Text(value.unPaidMemberModelList.where((element) => element.selected==true).length.toString(),
                                                      style: const TextStyle(fontSize: 13,
                                                          fontFamily: "PoppinsMedium",
                                                          fontWeight: FontWeight.w700),)
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Consumer<MainProvider>(
                                            builder: (context,val,child) {
                                              return Expanded(
                                                child: val.unPaidMemberModelList.isEmpty?const Padding(
                                                  padding: EdgeInsets.only(top:100),
                                                  child: Text("Empty.."),
                                                ):ListView.builder(
                                                  shrinkWrap: true,
                                                    physics: const ScrollPhysics(),
                                                    itemCount: val.unPaidMemberModelList.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                    var item=val.unPaidMemberModelList[index];

                                                      return Column(
                                                        children: [
                                                          Consumer<DonationProvider>(
                                                            builder: (context,value3,child) {
                                                              return InkWell(
                                                                onTap:(){

                                                                  DonationProvider donationProvider =
                                                                  Provider.of<DonationProvider>(context, listen: false);
                                                                  val.mName = item.name;
                                                                  val.mPhone = item.PhoneNumber;
                                                                  donationProvider.transactionID.text =  DateTime.now().microsecondsSinceEpoch.toString()+generateRandomString(2);
                                                                  donationProvider.attempt(donationProvider.membershipAmount.toString(),item.MemberId,
                                                                      item.name,
                                                                      item.PhoneNumber,
                                                                      donationProvider.transactionID.text,
                                                                      state, district, assembly, unit,donationProvider.appVersion.toString(),val.attemptMap,);

                                                                  // callNext(PaymentGateway(amount: donationProvider.membershipAmount.toString(),username: userName,userID: uId,isFromRequest: 'New',
                                                                  // address: address,photo: photo,profession: item.proffession,unit: unit,name: item.name,phone: item.PhoneNumber,loginLevel: loginLevel, from: from,), context);

                                                                  if(Platform.isIOS){
                                                                    callNext(NewPaymentGatewayScreen(id: "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=mb%20${donationProvider.transactionID.text}&am=${donationProvider.membershipAmount.toString()}&cu=INR",
                                                                      state:state, district: district, assembly: assembly, unit: unit, from: from, username:userName, userID: uId, photo: photo, profession:item.proffession, address:  item.adddress, loginLevel: loginLevel, amount:donationProvider.membershipAmount.toString(),), context);

                                                                  }else if(Platform.isAndroid){
                                                                    if(value3.lockMindGateOption=="ON"&&value3.intentPaymentOption=="OFF"){


                                                                      callNext(NewPaymentGatewayScreen(id: "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=mb%20${donationProvider.transactionID.text}&am=${donationProvider.membershipAmount.toString()}&cu=INR",
                                                                        state:state, district: district, assembly: assembly, unit: unit, from: from, username:userName, userID:uId, photo:photo, profession:item.proffession, address:  item.adddress, loginLevel: loginLevel, amount:donationProvider.membershipAmount.toString(),), context);

                                                                    }else{
                                                                      callNextReplacement(PaymentGateway(amount: donationProvider.membershipAmount.toString(),username: userName,userID: uId,isFromRequest: 'New',
                                                                        address: address,photo: photo,profession: item.proffession,unit: item.unit,name: item.name,phone: item.PhoneNumber,loginLevel: loginLevel,
                                                                        from: from, memberId: item.MemberId, state: item.state, district: item.district, assembly: item.assembly,), context);

                                                                    }



                                                                  }

                                                                 },
                                                               child: Container(
                                                                // height: 54,
                                                                margin:const EdgeInsets.symmetric(horizontal: 14),
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
                                                                              child:item.photo == ''? Image.asset("assets/profile.png",scale: 1.7,):Image.network(item.photo,fit: BoxFit.fill,))),
                                                                      title:  Text(item.name,
                                                                        style: const TextStyle(
                                                                            fontWeight: FontWeight.w500,
                                                                            fontFamily: "PoppinsMedium",
                                                                            fontSize: 15,
                                                                            color: Colors.black
                                                                        )),
                                                                      subtitle: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(item.MemberId,
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.w400,
                                                                                fontFamily: "Poppins",
                                                                                fontSize: 13,
                                                                                color: myBlack.withOpacity(0.5)),),
                                                                          Text("Payment Pending",
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.w400,
                                                                                fontFamily: "Poppins",
                                                                                fontSize: 13,
                                                                                color:myRed),),
                                                                        ],
                                                                      ),
                                                                      trailing: InkWell(
                                                                        onTap: (){
                                                                          val.showSelectionStatus(context,index,item.MemberId);
                                                                        },
                                                                        child: Container(
                                                                          width: 40,
                                                                          height: 40,
                                                                          child: item.selected?
                                                                          Image.asset("assets/memberSelect.png",scale: 3,) :
                                                                          Image.asset("assets/memberUnselect.png",scale: 3,),
                                                                      ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 5),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left: 75.0),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Container(
                                                                              width: 65,
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
                                                                                        mainProvider.whatsappLaunch(number: item.PhoneNumber,message: 'hi');
                                                                                      },
                                                                                      child: Image.asset("assets/whatsapp.png",scale: 2.8,)),
                                                                                  InkWell(
                                                                                      onTap: (){
                                                                                        mainProvider.makingPhoneCall(item.PhoneNumber);
                                                                                      },
                                                                                      child: Image.asset("assets/Contact.png",scale: 2)),
                                                                                ],
                                                                              )),
                                                                          SizedBox(height: 10,),
                                                                          InkWell(
                                                                            onTap: (){
                                                                              print(item.idStatus.toString()+"ririo");
                                                                              editDeleteAlert(context,item.MemberId,item.paymentStatus,uId,item.idStatus,item.state,item.assembly);
                                                                            },
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.only(right: 8.0),
                                                                              child: Container(
                                                                                width: 62,
                                                                                height: 34,
                                                                                decoration: BoxDecoration(
                                                                                    color: mainColor,
                                                                                    borderRadius: BorderRadius.circular(60),
                                                                                    border: Border.all(color: myGrey2,width: 0.5)),
                                                                                child: Center(
                                                                                    child: Text("Edit",
                                                                                      style: TextStyle(
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontFamily: "Poppins",
                                                                                          fontSize: 14,
                                                                                          color: myBlack
                                                                                      ),
                                                                                    )),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 5,)
                                                                  ],
                                                                ),
                                                              ),
                                                        );
                                                            }
                                                          ),
                                                        const SizedBox(height: 5,)
                                                      ],
                                                    );
                                                  }),
                                            );
                                          }
                                        ),
                                        Consumer<MainProvider>(
                                          builder: (context,val,child) {
                                            return Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Consumer<DonationProvider>(
                                                builder: (context,value3,child) {
                                                  return InkWell(
                                                    onTap: (){
                                                      DonationProvider donationProvider =
                                                      Provider.of<DonationProvider>(context, listen: false);
                                                      if(val.memberAmount!=0){
                                                        donationProvider.transactionID.text =  DateTime.now().microsecondsSinceEpoch.toString()+generateRandomString(2);
                                                        donationProvider.multipleAttempt( donationProvider.transactionID.text, state, district, assembly, unit,
                                                            donationProvider.appVersion.toString(),val.memberAmount.toString(),val.unPaidMemberModelList,val.attemptMap);

                                                        // callNext(PaymentGateway(isFromRequest: '',
                                                        //   amount: value.memberAmount.toString(),
                                                        //   username: userName,userID: uId,
                                                        //   address: address,photo: photo,profession: PhoneNumber,unit: unit, name: '', phone: '',loginLevel: loginLevel, from: from,), context);
                                                        if(Platform.isIOS){
                                                          callNext(NewPaymentGatewayScreen(id: "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=mb%20${donationProvider.transactionID.text}&am=${val.memberAmount.toString()}&cu=INR",
                                                            state:state, district: district, assembly: assembly, unit: unit, from: from, username:userName, userID: uId, photo: photo, profession:"", address:  address, loginLevel: loginLevel, amount:val.memberAmount.toString(),), context);

                                                        }else if(Platform.isAndroid){
                                                          if(value3.lockMindGateOption=="ON"&&value3.intentPaymentOption=="OFF"){


                                                            callNext(NewPaymentGatewayScreen(id: "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=mb%20${donationProvider.transactionID.text}&am=${val.memberAmount.toString()}&cu=INR",
                                                              state:state, district: district, assembly: assembly, unit: unit, from: from, username:userName, userID:uId, photo:photo, profession:"", address:  address, loginLevel: loginLevel, amount:val.memberAmount.toString()), context);

                                                          }else{
                                                            callNextReplacement(PaymentGateway(isFromRequest: '',
                                                              amount: val.memberAmount.toString(),
                                                              username: userName,userID: uId,
                                                              address: address,photo: photo,profession: "",unit: unit, name: '', phone: PhoneNumber,loginLevel: loginLevel, from: from,
                                                              memberId: '', state: state,district:district, assembly: assembly, ), context);

                                                          }



                                                        }
                                                        }
                                                      },
                                                    child: Container(
                                                      height: 42,
                                                      width: width,
                                                      decoration: BoxDecoration(
                                                        color: myDarkGreen,
                                                        borderRadius: BorderRadius.circular(51),
                                                      ),
                                                      child: Center(
                                                        child: Text("Pay ₹${val.memberAmount}",
                                                            style: const TextStyle(fontSize: 14,
                                                                fontFamily: "PoppinsMedium",
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              ),
                                            );
                                          }
                                        ),
                                          SizedBox(height: 20,)
                                      ],
                                    ),
                              ]);
                            }
                          ),
                        ),
                      ],
                    ),
                  ),
                ):
               Expanded(
                child: Container(
                  height: height,
                  // margin: EdgeInsets.only(top: height /4.2),
                  alignment: Alignment.topCenter,
                  decoration:  BoxDecoration(
                    color: mainColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 14,),
                      Consumer<MainProvider>(
                          builder: (context, value, child) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                              child: Container(
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
                                    hintText:   from=="NATIONAL_LEVEL"?"Search States":
                                    from == "STATE_LEVEL"?"Search Districts":
                                    from== "DISTRICT_LEVEL"?"Search Assembly":
                                    "Search Units",
                                    hintStyle:  TextStyle(fontSize: 14, fontFamily: "Poppins", color: myBlack,fontWeight: FontWeight.w500),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
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
                                    print(' CIFJFCF');
                                    value.search(text,from);
                                  },
                                ),
                              ),
                            );
                          }),
                        SizedBox(height: 5,),

                        Align(
                          alignment:Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 13.0),
                              child: Text(
                                from=="NATIONAL_LEVEL"?"All States":
                                from == "STATE_LEVEL"?state:
                                from== "DISTRICT_LEVEL"?district:
                                from== "ASSEMBLY_LEVEL"?assembly:
                                unit,
                                style: style3,),
                            )),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 4,top: 4),
                        child: Container(height: 1,width: width,color: myBlack.withOpacity(0.5),),
                      ),
                      SizedBox(height: 5,),
                           Expanded(
                             child: ListView.builder(
                                 itemCount: mainProvider.getProcess(from).length,
                                 itemBuilder: (context, index) {
                                   var item = mainProvider.getProcess(from)[index];
                                      return Column(
                                        children: [
                                          InkWell(
                                            onTap:(){
                                              if(from=="NATIONAL_LEVEL") {
                                                mainProvider.clearSearch();
                                                mainProvider.getPaidMemberCountState(item);
                                                // mainProvider.getMembersCount(item, district, assembly, '',"STATE_LEVEL");
                                                // mainProvider.getUnPaidMembersCount(item, district, assembly, '',"STATE_LEVEL");
                                                print(item+"hhhhhhh");
                                                // mainProvider.chckStateRegLock(item);
                                                mainProvider.getAllDistrict(item);
                                                mainProvider.getStateCoordinators(item);
                                                mainProvider.checkStateAdditionLock(item);
                                                // mainProvider.fetchNominees("STATE_LEVEL",item, '', '', '');
                                                callNext(BottomNavigationScreen(from: "STATE_LEVEL", uid: uId, userName: userName, state: item,district: '', assembly: '', unit: '', photo: photo , phoneNumber: PhoneNumber , address: address,loginLevel: loginLevel), context);
                                              }
                                              else if(from == "STATE_LEVEL"){

                                                print(from.toString()+"jdfeee");
                                                mainProvider.clearSearch();
                                                mainProvider.getPaidMemberCountDistrict(item);
                                                // mainProvider.getMembersCount(state, item, assembly, '',"DISTRICT_LEVEL");
                                                // mainProvider.getUnPaidMembersCount(state, item, assembly, '',"DISTRICT_LEVEL");
                                                print(item+"hhhhhhh222");
                                                mainProvider.getAllAssembly(state, item);
                                                // mainProvider.chckStateRegLock(state);
                                                mainProvider.getDistrictCoordinators(state,item);
                                                mainProvider.checkStateAdditionLock(state);
                                                mainProvider.getRequests(state);

                                                // mainProvider.fetchNominees("STATE_LEVEL", state, item, '', '');
                                                print(state+"ttuutt");
                                                print(item+"yyuyuy");
                                                callNext(BottomNavigationScreen(from: "DISTRICT_LEVEL", uid: uId, userName: userName, state: state,district: item, assembly: '', unit: '',photo: photo,phoneNumber: PhoneNumber,address: address,loginLevel: loginLevel), context);
                                              } else if(from == "DISTRICT_LEVEL"){
                                                mainProvider.clearSearch();
                                                mainProvider.getPaidMemberCountAssembly(district,item);
                                                // mainProvider.chckStateRegLock(state);
                                                mainProvider.getAddedUnit(state,district,item);
                                                mainProvider.getAssemblyCoordinators(state,district,item);
                                                // mainProvider.getMembersCount(state, district, item, '',"ASSEMBLY_LEVEL");
                                                // mainProvider.getUnPaidMembersCount(state, district, item, '',"ASSEMBLY_LEVEL");
                                                // mainProvider.fetchNominees("ASSEMBLY_LEVEL", state, district, item, item);
                                                mainProvider.checkStateAdditionLock(state);


                                                print(state+"iwoiwiw");
                                                print(item+"bvvbv");
                                                callNext(BottomNavigationScreen(from: "ASSEMBLY_LEVEL", uid: uId, userName: userName, state: state,district: district, assembly: item, unit: '',photo: photo,phoneNumber: PhoneNumber,address: address,loginLevel: loginLevel), context);
                                              }
                                              else if(from == "ASSEMBLY_LEVEL"){
                                                mainProvider.clearSearch();

                                                // mainProvider.chckStateRegLock(state);
                                                mainProvider.getMembersCount(state, district, assembly, item,"UNIT_LEVEL");
                                                mainProvider.getUnPaidMembersCount(state, district, assembly, item,"UNIT_LEVEL");
                                                print("dfnednje");
                                                mainProvider.getMembers(state, district, assembly, item);
                                                mainProvider.getUnpaidMembers(state, district, assembly, item);
                                                mainProvider.getPaidMembers(state, district, assembly, item);
                                                mainProvider.getUnitCoordinators(state, district, assembly, item);
                                                // mainProvider.getRequests(state, district, assembly);
                                                // mainProvider.getAddedUnit(state,district,assembly,panchayath);
                                                // mainProvider.fetchNominees("UNIT_LEVEL", state, district, assembly, item);
                                                mainProvider.checkStateAdditionLock(state);


                                                print(item+"opoopaaa");
                                                print(state+"opoop");
                                                print(district+"oeoiio");
                                                print(item+"AJIJI");
                                                callNext(BottomNavigationScreen(from: "UNIT_LEVEL", uid: uId, userName: userName, state: state,district: district, assembly: assembly, unit: item,photo: photo,phoneNumber: PhoneNumber,address: address,loginLevel: loginLevel), context);
                                              }
                                              // else if(from == "PANCHAYATH_LEVEL"){
                                              //   print("dfnednje"+item);
                                              //   mainProvider.getMembers(state, district, assembly, panchayath, item);
                                              //   mainProvider.getUnpaidMembers(state, district, assembly, panchayath, item);
                                              //   mainProvider.fetchNominees(from, state, district, assembly, panchayath, item);
                                              //   // mainProvider.getAddedUnit(state,district,assembly,panchayath);
                                              //   print(item+"opoopaaa");
                                              //   print(state+"opoop");
                                              //   print(district+"oeoiio");
                                              //   print(item+"AJIJI");
                                              //   callNext(BottomNavigationScreen(from: "UNIT_LEVEL", uid: uId, userName: userName, state: state,district: district, assembly: assembly, panchayath: panchayath, unit: item,photo: "",proffetion: "",address: "",), context);
                                              // }
                                              },
                                            child: Container(
                                              // height: 54,
                                              margin:const EdgeInsets.symmetric(horizontal: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(81),
                                                  color: Colors.white,
                                                  border: Border.all(color: myGrey2,width: 0.5,)),
                                              child: ListTile(
                                                leading: Container(
                                                    height: 48,
                                                    width: 48,
                                                    child: Image.asset( from=="NATIONAL_LEVEL"?"assets/stateIcon.png":
                                                    from == "STATE_LEVEL"?"assets/district.png":
                                                    from== "DISTRICT_LEVEL"?"assets/assembly.png":
                                                    "assets/unit.png",scale: from=="NATIONAL_LEVEL"?3:2.5,)),
                                                title:  Text(item,
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "PoppinsMedium",
                                                      fontSize: 15,
                                                      color: Colors.black
                                                  ),),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5,)
                                        ],
                                      );
                                    }),

                        ),
                      ],
                    ),
                  ),
                ),
                ],
              ),
            ),
          ),
          floatingActionButton:from=="ASSEMBLY_LEVEL"?Consumer<MainProvider>(
            builder: (context,value,child) {
              return value.addUnitLock?
              FloatingActionButton(
                backgroundColor: myDarkGreen,
                onPressed: (){
                  if(from=="ASSEMBLY_LEVEL"){
                    mainProvider.unitCT.clear();
                    addUnitAlert(context);
                  }

                },
                child: const Icon(Icons.add,size: 40,),
              ):SizedBox();
            }
          ):SizedBox()
        ),
      ),
    );
  }

  // addPanchayathAlert(BuildContext context) {
  //   MainProvider mainProvider =
  //   Provider.of<MainProvider>(context, listen: false);
  //   final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  //
  //
  //   AlertDialog alert = AlertDialog(
  //     backgroundColor: Colors.white,
  //     scrollable: true,
  //     title: Container(
  //       alignment: Alignment.center,
  //       child: const Text(
  //         "Add Panchayath",
  //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  //       ),
  //     ),
  //     content:  Form(
  //       key: _formKey2,
  //       child: Column(
  //         children: [
  //           Consumer<MainProvider>(
  //               builder: (context,value,child) {
  //                 return Center(
  //                   child: Container(width: MediaQuery.of(context).size.width*0.7,
  //                     child: TextFormField(
  //                       decoration: InputDecoration(
  //                         contentPadding: const EdgeInsets.symmetric(horizontal: 10),
  //                         labelText: 'Panchayath Name',
  //                         filled: true,
  //                         fillColor: Colors.white,
  //                         border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(30),
  //                           borderSide: BorderSide(width: 0.5, color: myGrey2),
  //                         ),
  //                         enabledBorder: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(30),
  //                           borderSide: BorderSide(width: 0.5, color: myGrey2),
  //                         ),
  //                         focusedBorder: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(30),
  //                           borderSide: BorderSide(width: 0.5, color: myGrey2),
  //                         ),
  //                       ),
  //                       // validator: (text) => text == '' ? 'Pleas Enter Unit Name' : null,
  //                       autofocus: false,
  //                       enabled: true,
  //                       controller: value.panchayathCT,
  //                       validator: (text){
  //                         if(text!.isEmpty){
  //                           return '';
  //                         } else{
  //                           return null;
  //                         }
  //                       },
  //                     ),
  //                   ),
  //                 );
  //               }
  //           ),
  //           const SizedBox(height: 20,),
  //           Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //
  //               TextButton(
  //                 style: TextButton.styleFrom(
  //                   primary: Colors.black,
  //                   backgroundColor: Colors.white.withOpacity(1),
  //                   maximumSize: const Size(230, 50),
  //                   elevation: 5,
  //                   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
  //                 ),
  //                 child: const Text("Cancel",style: TextStyle(fontWeight: FontWeight.w800)),
  //                 onPressed: () {
  //                   finish(context);
  //                 },
  //               ),
  //               TextButton(
  //                 style: TextButton.styleFrom(
  //                   primary: Colors.black,
  //                   backgroundColor: Colors.white.withOpacity(1),
  //                   maximumSize: const Size(230, 50),
  //                   elevation: 5,
  //                   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
  //
  //                 ),
  //                 child: const Text("Add",style: TextStyle(fontWeight: FontWeight.w800)),
  //                 onPressed: () {
  //                   final FormState? form = _formKey2.currentState;
  //                   if (form!.validate()) {
  //                     print(' NINDnduended'+assembly);
  //                     mainProvider.addPanchayath(state,district,assembly,uId);
  //                     mainProvider.getAddedPanchayath(state,district,assembly);
  //                     Navigator.pop(context);
  //                   }
  //                 },
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //
  //   );
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  addUnitAlert(BuildContext context) {
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      scrollable: true,
      title: Container(
        alignment: Alignment.center,
        child: const Text(
          "Add Unit",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      content:  Form(
        key: _formKey,
        child: Column(
          children: [
            Consumer<MainProvider>(
                builder: (context,value,child) {
                  return Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.7,
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          labelText: 'Unit Name',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(width: 0.5, color: myGrey2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(width: 0.5, color: myGrey2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(width: 0.5, color: myGrey2),
                          ),
                        ),
                        autofocus: false,
                        enabled: true,
                        controller: value.unitCT,
                        validator: (text){
                          if(text!.isEmpty){
                            return '';
                          } else{
                            return null;
                          }
                        },
                      ),
                    ),
                  );
                }
            ),
            const SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Colors.white.withOpacity(1),
                    maximumSize: const Size(230, 50),
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                  ),
                  child: const Text("Cancel",style: TextStyle(fontWeight: FontWeight.w800)),
                  onPressed: () {
                    finish(context);
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Colors.white.withOpacity(1),
                    maximumSize: const Size(230, 50),
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),

                  ),
                  child: const Text("Add",style: TextStyle(fontWeight: FontWeight.w800)),
                  onPressed: () {
                    final FormState? form = _formKey.currentState;
                    if (form!.validate()) {
                      print(' NINDnduended'+assembly);
                      mainProvider.addUnit(state,district,assembly,uId);
                      mainProvider.getAddedUnit(state,district,assembly);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),

    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  editDeleteAlert(BuildContext context,String memberId,String paymentStatus,String uid,String idStatus,String state,String assembly) {
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      scrollable: true,
      title: const Text(
        "Do you want to edit/delete?",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      content: Consumer<MainProvider>(
        builder: (context,value,child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                value.deleteMemberLoader?CircularProgressIndicator(color: myGreen,):
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
                          mainProvider.deleteMember(memberId,context,uid,state,assembly);

                          mainProvider.getMembersCount(state, district, assembly, unit, from);
                          mainProvider.getUnPaidMembersCount(state, district, assembly, unit, from);

                        }),
                  ),
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
                          mainProvider.editMember(memberId);
                          mainProvider.getProfessions();
                          mainProvider.getEducations();
                          callNext(AddNewMember(
                            from: from, state: state, district: district, assembly: assembly, unit: unit,
                            uid: uId, idStatus: idStatus, proffetion: PhoneNumber,photo: photo,address: address, type: 'Edit',MemberId: memberId, userName: userName,paymentStatus: paymentStatus,loginLevel: loginLevel), context);
                        }),
                  ),

                ],
              ),
            ],
          );
        }
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


}

String generateRandomString(int length) {
  final random = Random();
  const availableChars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  final randomString = List.generate(length,
          (index) => availableChars[random.nextInt(availableChars.length)]).join();

  return randomString;
}