import 'package:flutter/material.dart';
import 'package:iuml_membership/Constants/my_functions.dart';
import 'package:provider/provider.dart';

import '../Models/masterReportModel.dart';
import '../constants/my_colors.dart';
import '../providers/Main_Provider.dart';
import 'coordinator_UnitLevel.dart';

class CoordinatorAssemblyLevelReport extends StatelessWidget {
  String state,district,from;
   CoordinatorAssemblyLevelReport({Key? key,required this.state,required this.district,required this.from}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    MainProvider mainProvider = Provider.of<MainProvider>(context,listen: false);
    return WillPopScope(
      onWillPop: () async {
        mainProvider.setListAfterSearch(from);
        return true;
      },
      child: Scaffold(
        body:  Column(
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
              child:Padding(
                padding: const EdgeInsets.only(right: 10.0,left: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('IUML', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.48,
                    ),),
                    Row(
                      children: [

                        Container(
                          // color: Colors.yellow,
                          width: width*0.5,
                          child: Text(
                            district,
                            textAlign: TextAlign.end,
                            // maxLines: 2,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.42,
                            ),),
                        ),SizedBox(width: 5,),
                        Image.asset('assets/distIcon.png',scale: 3,),


                      ],),
                  ],
                ),
              ),
            ),
            SizedBox(height: height*0.02,),
            const Align(alignment: Alignment.center,
                child: Text('ASSEMBLY REPORT',style: TextStyle(
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
                        controller: value.searchController,
                        textAlign: TextAlign.left,
                        onChanged: (value) {
                          mainProvider.searchAssembly(value);

                        },
                        decoration: InputDecoration(
                            hintText: "Search Assembly",

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
            Consumer<MainProvider>(builder: (context, value, child) {
              return Flexible(
                child:
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                  child: GridView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 4,
                        // childAspectRatio: 10,
                        crossAxisCount: 3,
                      ),
                      itemCount: value.filterassemblyListForReport.length,
                      physics: ScrollPhysics(),

                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext ctx, index) {
                        var item = value.filterassemblyListForReport[index];
                              List<masterCordinatorModel> stateWiseCountList =
                              value.assemblyCordinator(state,district,item.name);


                        return  Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: InkWell(onTap: (){
                                mainProvider.searchController.text='';mainProvider.getAddedUnit(state,district,item.name);
                                callNext(CoordinatorUnitLevelScreen(district: district,state: state,assembly: item.name,from: 'UNIT_LEVEL'), context);

                              },
                                child:Container(
                                  width: 120,
                                  height: 90,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFFAFAFA),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                        color:Color(0x3F000000),
                                        blurRadius: 17,
                                        offset: Offset(0, 13),
                                        spreadRadius: -13,
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Text(item.name,
                                          textAlign: TextAlign.center,
                                          style:  TextStyle(
                                          color: stateWiseCountList.length>0?Colors.black:clFF5555,
                                          fontSize: 11,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.30,
                                        ),),
                                      ),
                                      Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Coordinators: ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color:Color(0xFF036802),
                                              fontSize: 10,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.24,
                                            ),
                                          ),
                                          Text(stateWiseCountList.length.toString(),
                                            style: const TextStyle(
                                            color: Color(0xFF036802),
                                            fontSize: 10,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.24,
                                          ),),
                                        ],
                                      ),
                                      Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Units: ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color:Color(0xFF036802),
                                              fontSize: 10,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.24,
                                            ),
                                          ),
                                          Consumer<MainProvider>(
                                            builder: (context,value,child) {
                                              return Text(item.value.toString(),
                                                style: const TextStyle(
                                                color: Color(0xFF036802),
                                                fontSize: 10,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.24,
                                              ),);
                                            }
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),),
                              ),
                            ),
                            Positioned(
                                child:stateWiseCountList.length>0?
                                Image.asset("assets/active.png",scale: 3,):
                                Image.asset("assets/inActiveCoordinator.png",scale: 3,)),
                          ],
                        );
                      }),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
