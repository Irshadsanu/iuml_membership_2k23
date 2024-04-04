import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/my_functions.dart';
import '../constants/my_colors.dart';
import '../constants/my_text.dart';
import '../providers/Main_Provider.dart';
import 'add_counsilors_screen.dart';

class CouncilorsScreen extends StatelessWidget {
  String from;
  String uId;
  String state, district, assembly,unit;
   CouncilorsScreen({super.key,required this.from,required this.uId,required this.state,
     required this.district,
     required this.assembly,
     required this.unit});

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context,listen: false);

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        centerTitle: true,
        title:  Text(from=="NATIONAL_LEVEL"?"NATIONAL LEVEL":
        from=="STATE_LEVEL"?"STATE LEVEL":
        from=="DISTRICT_LEVEL"?"DISTRICT LEVEL":from=="ASSEMBLY_LEVEL"?"ASSEMBLY LEVEL":"UNIT LEVEL",
            style:appbarStyle
        ),
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 10.0),
        //   child: Row(
        //     children: [
        //       Icon(Icons.arrow_back_ios_new,color: myDarkGreen,),
        //       Text("IUML",style: TextStyle(color: myGreen2,fontSize: 16,fontWeight: FontWeight.bold,fontFamily: "Poppins"),)
        //     ],
        //   ),
        // ),
        leadingWidth: 100,
      ),
      body: Column(
        children: [
          // const SizedBox(height: 10),
          // Consumer<MainProvider>(
          //     builder: (context, providerValue, child) {
          //       return TabBar(
          //           padding: EdgeInsets.symmetric(horizontal: width / 45,vertical: 12),
          //           labelPadding: EdgeInsets.zero,
          //           indicator: BoxDecoration(
          //               borderRadius: const BorderRadius.only(
          //                 topLeft: Radius.circular(20),
          //                 topRight:Radius.circular(20), ),
          //               color: myDarkGreen),
          //           labelColor: Colors.white,
          //           indicatorPadding:  EdgeInsets.all(5),
          //           unselectedLabelColor: Colors.black,
          //           onTap: (value) {
          //             providerValue.tabIndex(value);
          //           },
          //           tabs: [
          //             Tab(
          //               child: Container(
          //                 width: width / 2,
          //                 height: height / 28,
          //
          //                 child: const Center(
          //                     child: Text("Councilors",
          //                         style: TextStyle(
          //                             fontFamily: "Poppins",
          //                             fontWeight: FontWeight.w700))),
          //               ),
          //             ),
          //             Tab(
          //               child: Container(
          //                 width: width / 2,
          //                 height: height / 25,
          //                 child: const Center(
          //                     child: Text("Nominees",
          //                         style: TextStyle(
          //                             fontFamily: "Poppins",
          //                             fontWeight: FontWeight.w700))),
          //               ),
          //             ),
          //           ]);
          //     }),

          InkWell(
            onTap: (){
              MainProvider mainProvider = Provider.of<MainProvider>(context,listen: false);
              // mainProvider.loopMembers();
              mainProvider.clearSelection();
              print(from+' iuvnifevne');
              if(from == "UNIT_LEVEL") {
                // mainProvider.getPaidMembers(state, district, assembly, unit);
              }else if(from=='ASSEMBLY_LEVEL'){
                mainProvider.assemblyUnitNomineeList(state, district, assembly, unit, from);
              }else if(from=='DISTRICT_LEVEL'){
                print(' ICUFEICFIFIE');
                mainProvider.districtAssmblyNomineeList(state, district, assembly,unit,from);
                // mainProvider.nomineesAssembly(state, district, assembly,from);
              } else if(from=='STATE_LEVEL'){
                mainProvider.stateDistrictNomineeList(state,from);
                // mainProvider.fetchNominees(from, state, district, assembly, unit);
              }else{
                mainProvider.nationalStatetNomineeList(from);
              }
              callNext(AddCounsilorsScreen(uId: uId,from: from, state: state,district: district,assembly: assembly,unit: unit,), context);
            },
            child: Consumer<MainProvider>(
                builder: (context,value,child) {
                  return
                    value.stateCounselorLock || from=='NATIONAL_LEVEL'||value.getNominees(from).isNotEmpty?
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          height: 28,
                          width: 154,
                          // margin: const EdgeInsets.symmetric(horizontal: 75),
                          decoration: BoxDecoration(
                            color: myDarkGreen,
                            borderRadius: BorderRadius.circular(52),
                          ),
                          child:  Center(
                            child: Text(from=="UNIT_LEVEL"?"Add Councilor Nominees":"Add Councilors",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "PoppinsMedium"
                              ),),
                          ),
                        ),
                      ),
                    ):SizedBox();
                }
            ),
          ),
          from=="UNIT_LEVEL"?  Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(unit,style: style3,),
              )) :from=="ASSEMBLY_LEVEL"? Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(assembly,style: style3,),
              ))
              : from=="DISTRICT_LEVEL"?Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Text(district,style: style3,),
                  )): from=="STATE_LEVEL"?Align(
                     alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                         child: Text(state,style: style3,),
                  )):SizedBox(),
          SizedBox(height: 10,),
          Consumer<MainProvider>(
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                  child: Container(
                    height: 50,
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
                      onChanged: (item){
                        MainProvider mainProvider = Provider.of<MainProvider>(context,listen:false);
                        mainProvider.searchNominees(from, item);
                      },
                    ),
                  ),
                );
              }),

          const SizedBox(height: 20),
          Expanded(
            child: Consumer<MainProvider>(
              builder: (context,value,child) {
                return ListView.builder(
                    itemCount: value.getNominees(from).length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var item = value.getNominees(from)[index];
                      print(value.getNominees(from).length.toString()+"988888");
                      return Column(
                        children: [
                          Container(
                            margin:const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(81),
                                color: Colors.white,
                                border: Border.all(color: myGrey2,width: 0.5,)),
                            child: ListTile(
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
                              subtitle: Text("Membership ID : ${item.memberId}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                    fontSize: 13,
                                    color: myBlack),),
                              trailing: Container(
                                  width: 62,
                                  height: 34,
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: myGrey2.withOpacity(0.3)),
                                      color: mainColor,borderRadius: BorderRadius.circular(81)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          mainProvider.whatsappLaunch(number: item.phone, message: '');
                                        },
                                          child: Image.asset("assets/whatsapp.png",scale: 2.8,)),
                                      SizedBox(width: 4,),
                                      InkWell(
                                        onTap: (){
                                          mainProvider.makingPhoneCall(item.phone);
                                        },
                                          child: Image.asset("assets/Contact.png",scale: 2,)),
                                    ],
                                  )),
                            ),
                          ),
                          SizedBox(height: 5,)
                        ],
                      );
                    });
              }
            ),
          ),

        ],
      ),
    );
  }
}
