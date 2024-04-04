import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iuml_membership/Constants/my_functions.dart';
import 'package:provider/provider.dart';

import '../Models/masterReportModel.dart';
import '../constants/my_colors.dart';
import '../providers/Main_Provider.dart';
import 'coordinator_DistrictLevel.dart';

class CoordinatorsStateReportScreen extends StatelessWidget {
  String from,state,district,assembly;
   CoordinatorsStateReportScreen({Key? key,required this.from,required this.state
     ,required this.district,required this.assembly}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(from+' inhsuidv');
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    return WillPopScope(
        onWillPop: () async {
          mainProvider.setListAfterSearch(from);
          return true;
        },
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: width,
              height: height*0.13,
              decoration:   const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF103907),
                        Color(0xFF0C3104)
                      ]
                  )
              ),
              child:  Padding(
                padding: const EdgeInsets.only(right: 20.0,left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('IUML',
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.48,
                    ),),
                    Row(
                      children: [
                        const Text('STATES',style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.42,
                        ),),
                        SizedBox(width: 5,),
                        Image.asset('assets/distIcon.png',scale: 3,),


                      ],),
                  ],
                ),
              ),
            ),
            SizedBox(height: height*0.02,),
            const Align(
                alignment: Alignment.center,
                child: Text('STATE REPORT',style: TextStyle(
                  color: Color(0xFF232323),
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.42,
                ),)),
            SizedBox(height: 4,),
            Consumer<MainProvider>(
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: myGreen),
                        borderRadius:BorderRadius.circular(44),
                        // boxShadow: const [
                        //   BoxShadow(color: Colors.black26,
                        //       blurRadius:5.0)
                        // ],
                      ),
                      child: TextField(
                        // controller: value.searchController,
                        textAlign: TextAlign.left,
                        onChanged: (value) {
                          mainProvider.search(value,'NATIONAL_LEVEL');

                        },
                        decoration: InputDecoration(
                            hintText: "Search States",

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

                        ),
                      ),
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 15,top: 8),
              child: Container(
                width: 400,
                // color: Colors.yellow,
                child: Row(
                  children: [
                    SizedBox(
                      width: width*0.54,
                      child: const Text("State", style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.42,
                      ),),
                    ),
                    SizedBox(
                      // width:width*0.2,
                        child: Text(
                          "Total Coordinators",
                          style:  TextStyle(
                            color: myBlack,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.51,
                          ),)),
                  ],
                ),
              ),
            ),
            Consumer<MainProvider>(builder: (context, value, child) {
              return Flexible(
                child: ListView.builder(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                  physics: ScrollPhysics(),
                    itemCount: from=='NATIONAL_LEVEL'?
                    value.stateList.length:from=='STATE_LEVEL'?1:0,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var item;
                      if(from=='NATIONAL_LEVEL'){
                        item= value.stateList[index];
                      }else if(from=='STATE_LEVEL'){
                        item= value.stateList.where((element) => element==state).toSet().toList()[index];
                      }
                      List<masterCordinatorModel> stateWiseCountList =
                          value.stateCordinator(item);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: InkWell(onTap: (){
                          mainProvider.searchController.text='';
                          mainProvider.getAllDistrict(item);
                          callNext(CoordinatorsDistrictReportScreen(state: item,from: 'DISTRICT_LEVEL'), context);
                        },
                          child: Container(
                            width: 318,
                            height: 60,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x28000000),
                                  blurRadius: 7,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(width:width*0.6,
                                  child: Text(item, style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 1.15,
                                    letterSpacing: 0.42,
                                  ),)),
                              SizedBox(
                                  // width:width*0.2,
                                 child: Text(
                                   stateWiseCountList.length.toString(),
                                      style: const TextStyle(
                                        color: Color(0xFF036802),
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.51,
                                      ),)),
                            ],
                          ),),
                        ),
                      );
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }
}
