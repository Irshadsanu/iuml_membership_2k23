import 'package:flutter/material.dart';
import 'package:iuml_membership/Models/counsilor_nominee_model.dart';
import 'package:iuml_membership/constants/my_colors.dart';
import 'package:iuml_membership/constants/my_functions.dart';
import 'package:provider/provider.dart';
import '../constants/my_text.dart';
import '../providers/Main_Provider.dart';

class CommitteeScreen extends StatelessWidget {
  String uId;
  String from;
  String state, district, assembly, unit;
   CommitteeScreen({super.key, required this.uId, required this.from, required this.state,
     required this.district,
     required this.assembly,
     required this.unit});

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

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
        title:  Text("Committee",
            style:appbarStyle
        ),
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 10.0),
        //   child: Row(
        //     children: [
        //       Icon(Icons.arrow_back_ios_new,color: myDarkGreen),
        //       Text("IUML",style: TextStyle(color: myGreen2,fontSize: 16,fontWeight: FontWeight.bold,fontFamily: "Poppins"),)
        //     ],
        //   ),
        // ),
        leadingWidth: 100,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            // from!="UNIT_LEVEL"?Column(
            //   children: [
            //     // Align(
            //     //   alignment: Alignment.centerLeft,
            //     //     child: Padding(
            //     //       padding: const EdgeInsets.only(left: 14.0),
            //     //       child: Text("District",style: style3,),
            //     //     )),
            //     Consumer<MainProvider>(
            //         builder: (context, value, child) {
            //           return Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
            //             child: Container(
            //               height: 45,
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius:BorderRadius.circular(44),
            //                 boxShadow: const [
            //                   BoxShadow(color: Colors.black26,
            //                       blurRadius:5.0)
            //                 ],
            //               ),
            //               child: TextField(
            //                 controller: value.searchController,
            //                 textAlign: TextAlign.left,
            //                 style: TextStyle(fontSize: 14, fontFamily: "Poppins", color: myBlack,fontWeight: FontWeight.w600),
            //                 decoration: InputDecoration(
            //                     hintText: "Search Members",
            //                     hintStyle:  TextStyle(fontSize: 14, fontFamily: "Poppins", color: myBlack,fontWeight: FontWeight.w500),
            //                     contentPadding: const EdgeInsets.symmetric(
            //                         vertical: 5, horizontal: 10),
            //                     focusedBorder: OutlineInputBorder(
            //                       borderRadius: BorderRadius.circular(44),
            //                       borderSide: const BorderSide(color: Colors.white),
            //                     ),
            //                     enabledBorder: OutlineInputBorder(
            //                       borderRadius: BorderRadius.circular(44),
            //                       borderSide: const BorderSide(color: Colors.white),
            //                     ),
            //                     prefixIcon: Icon(Icons.search_rounded,color: myBlack,)
            //                 ),
            //               ),
            //             ),
            //           );
            //         }),
            //
            //     Padding(
            //       padding: const EdgeInsets.all(10.0),
            //       child: Container(
            //         width: width,
            //         height: 35,
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius:BorderRadius.circular(81),
            //             border: Border.all(color: myDarkGreen,width: 0.5)
            //         ),
            //         child: Center(
            //           child: Text("Search",
            //             style: TextStyle(
            //                 fontSize: 14,
            //                 color: myDarkGreen,
            //                 fontWeight: FontWeight.w700,
            //                 fontFamily: "Poppins"
            //             ),),
            //         ),
            //       ),
            //     ),
            //   ],
            // ):SizedBox(),
            // InkWell(
            //   onTap: (){
            //     mainProvider.getNameOfMember();
            //     callNext( AddCommitteeScreen(uId: uId,from: from, state: state,district: district,assembly: assembly,panchayath: panchayath,unit: unit,), context);
            //   },
            //   child: Container(
            //     height: 40,
            //     margin: const EdgeInsets.symmetric(horizontal: 12),
            //     decoration: BoxDecoration(
            //       color: myDarkGreen,
            //       borderRadius: BorderRadius.circular(52),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: const [
            //         Text("Add Committee Member",
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 14,
            //           fontWeight: FontWeight.w700,
            //           fontFamily: "PoppinsMedium"
            //         ),),
            //         Icon(Icons.add,color: Colors.white,size: 30,)
            //       ],
            //     ),
            //   ),
            // ),
            from=="UNIT_LEVEL"? Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(unit+" Unit",style:const TextStyle(color: Colors.black,fontFamily: "Poppins",fontWeight: FontWeight.w700),),
            ):SizedBox(),


            ////Fixed vvbnm,mbcfghjjhg

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return SizedBox(
                      height: 200,
                      width: width/2,
                      child: Column(
                        children: [
                          Text("President",style:TextStyle(
                              fontFamily: "Poppins",
                              color: myGreen
                          )),
                          const SizedBox(
                            height: 8,
                          ),

                          value.committeeDesignationModelList.where((element) => element.desination=="President").isEmpty?
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            child: Image.asset("assets/img.png",scale: 2.5),
                          ): value.committeeDesignationModelList[value.committeeDesignationModelList.indexWhere((element) =>
                          element.desination=="President")].photo==''? CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            child:Icon(Icons.person,color: myGreen.withOpacity(0.5),size:35 ,),
                          ): CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(value.committeeDesignationModelList[value.committeeDesignationModelList.indexWhere((element) => element.desination=="President")].photo),
                          ),
                          const SizedBox(height: 5),
                          value.committeeDesignationModelList.where((element) => element.desination=="President").isNotEmpty?
                          Text(value.committeeDesignationModelList[value.committeeDesignationModelList.indexWhere((element) => element.desination=="President")].name,
                            style:const TextStyle(
                              fontFamily:"Poppins",
                              fontWeight:FontWeight.bold
                            ),
                            textAlign:TextAlign.center,
                          ):
                          const Text("Add Member",style:TextStyle(
                              fontFamily:"Poppins",
                              fontWeight:FontWeight.bold
                          ),
                            textAlign:TextAlign.center,
                          ),
                          value.committeeDesignationModelList.where((element) => element.desination=="President").isEmpty?
                          const SizedBox():
                          Text("Membership ID:${value.committeeDesignationModelList[value.committeeDesignationModelList
                              .indexWhere((element) => element.desination=="President")].memberId}",
                            style: const TextStyle(
                                          fontFamily:"poppins",
                                          fontSize: 11
                                        ),),
                                        const SizedBox(height: 10),
                                        InkWell(
                                          onTap: () {
                                            if(value.committeeDesignationModelList.where((element) => element.desination=="President").isEmpty){
                                              committeeAlert(context,"President", state, district, assembly, unit,"");
                                            }else{

                                            committeeAlert(context,"President", state, district, assembly, unit,value.committeeDesignationModelList[value.committeeDesignationModelList
                                                .indexWhere((element) => element.desination=="President")].memberId);
                                            }
                                          },
                                          child: Consumer<MainProvider>(
                                            builder: (context,value,child) {
                                              return
                                                value.stateCommitteeLock || from=='NATIONAL_LEVEL'?
                                                Container(
                                                height: 20,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: myDarkGreen,
                                                ),
                                                child:  Center(
                                                  child: Text(value.committeeDesignationModelList.where((element) => element.desination=="President").isEmpty?"Add":"Edit",style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins",
                                                    fontSize: 12
                                                  )),
                                                ),
                                              ):SizedBox();
                                            }
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                  }
                ),
                Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return SizedBox(
                      width: width/2,
                      height: 200,

                      child: Column(
                        children: [
                          Text("Secretary",style:TextStyle(
                              fontFamily: "Poppins",
                              color: myGreen
                          )),
                          const SizedBox(
                            height: 8,
                          ),

                          value.committeeDesignationModelList.where((element) => element.desination=="Secretary").isEmpty ?
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            child: Image.asset("assets/img.png",scale: 2.5),
                          ): value.committeeDesignationModelList[value.committeeDesignationModelList.indexWhere((element) =>
                          element.desination=="Secretary")].photo==''? CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            child:Icon(Icons.person,color: myGreen.withOpacity(0.5),size:35 ,),
                          ):CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(value.committeeDesignationModelList[value.committeeDesignationModelList.indexWhere((element) =>
                            element.desination=="Secretary")].photo),
                          ),
                          const SizedBox(height: 5),
                          value.committeeDesignationModelList.where((element) => element.desination=="Secretary").isNotEmpty?
                          Text(value.committeeDesignationModelList[value.committeeDesignationModelList.indexWhere((element) => element.desination=="Secretary")].name,style:TextStyle(
                              fontFamily:"Poppins",
                              fontWeight:FontWeight.bold
                          ),
                            textAlign:TextAlign.center,
                          ):
                          const Text("Add Member",style:TextStyle(
                              fontFamily:"Poppins",
                              fontWeight:FontWeight.bold
                          ),
                            textAlign:TextAlign.center,
                          ),
                          value.committeeDesignationModelList.where((element) => element.desination=="Secretary").isEmpty?
                          const SizedBox():
                          Text("Membership ID:${value.committeeDesignationModelList[value.committeeDesignationModelList
                              .indexWhere((element) => element.desination=="Secretary")].memberId}",
                            style: const TextStyle(
                                fontFamily:"poppins",
                                fontSize: 11
                            ),),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              if(value.committeeDesignationModelList.where((element) => element.desination=="Secretary").isEmpty){
                                committeeAlert(context,"Secretary", state, district, assembly, unit,"");
                              }else{
                              committeeAlert(context,"Secretary", state, district, assembly, unit,value.committeeDesignationModelList[value.committeeDesignationModelList
                                  .indexWhere((element) => element.desination=="Secretary")].memberId);
                              }
                            },
                            child: Consumer<MainProvider>(
                                builder: (context,value,child) {
                                return
                                  value.stateCommitteeLock|| from=='NATIONAL_LEVEL'?
                                  Container(
                                  height: 20,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: myDarkGreen,
                                  ),
                                  child:  Center(
                                    child: Consumer<MainProvider>(
                                      builder: (context,value2,child) {
                                        return Text(value.committeeDesignationModelList.where((element) => element.desination=="Secretary").isEmpty?"Add":"Edit",style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 12
                                        ));
                                      }
                                    ),
                                  ),
                                ):SizedBox();
                              }
                            ),
                          )
                        ],
                      ),
                    );
                  }
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return SizedBox(
                      height: 200,
                      width: width/2,
                      child: Column(
                        children: [
                          Text("Vice President",style:TextStyle(
                              fontFamily: "Poppins",
                              color: myGreen
                          )),
                          const SizedBox(
                            height: 8,
                          ),

                          value.committeeDesignationModelList.where((element) => element.desination=="Vice President").isEmpty?
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            child: Image.asset("assets/img.png",scale: 2.5),
                          ):value.committeeDesignationModelList[value.committeeDesignationModelList.indexWhere((element) =>
                          element.desination=="Vice President")].photo==''? CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            child:Icon(Icons.person,color: myGreen.withOpacity(0.5),size:35 ,),
                          ): CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(value.committeeDesignationModelList[value.committeeDesignationModelList.indexWhere((element) => element.desination=="Vice President")].photo),
                          ),
                          const SizedBox(height: 5),
                          value.committeeDesignationModelList.where((element) => element.desination=="Vice President").isNotEmpty?
                          Text(value.committeeDesignationModelList[value.committeeDesignationModelList.indexWhere((element) => element.desination=="Vice President")].name,
                            style:const TextStyle(
                              fontFamily:"Poppins",
                              fontWeight:FontWeight.bold
                          ),
                            textAlign:TextAlign.center,
                          ):
                          const Text("Add Member",
                            style:TextStyle(
                              fontFamily:"Poppins",
                              fontWeight:FontWeight.bold
                          ),
                            textAlign:TextAlign.center,
                          ),
                          value.committeeDesignationModelList.where((element) => element.desination=="Vice President").isEmpty?
                          const SizedBox():
                          Text("Membership ID:${value.committeeDesignationModelList[value.committeeDesignationModelList
                              .indexWhere((element) => element.desination=="Vice President")].memberId}",
                            style: const TextStyle(
                                fontFamily:"poppins",
                                fontSize: 11
                            ),),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              if(value.committeeDesignationModelList.where((element) => element.desination=="Vice President").isEmpty){
                                committeeAlert(context,"Vice President", state, district, assembly, unit,"");
                              }else{
                              committeeAlert(context,"Vice President", state, district, assembly, unit,value.committeeDesignationModelList[value.committeeDesignationModelList
                                  .indexWhere((element) => element.desination=="Vice President")].memberId);}
                            },
                            child: Consumer<MainProvider>(
                              builder: (context,value,child) {
                                return
                                  value.stateCommitteeLock|| from=='NATIONAL_LEVEL'?
                                  Container(
                                  height: 20,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: myDarkGreen,
                                  ),
                                  child:  Center(
                                    child: Text(
                                        value.committeeDesignationModelList.where((element) => element.desination=="Vice President").isEmpty?"Add":"Edit",style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily:"Poppins",
                                        fontSize: 12
                                    )),
                                  ),
                                ):SizedBox();
                              }
                            ),
                          )
                        ],
                      ),
                    );
                  }
                ),
                Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return SizedBox(
                      // color: Colors.red,
                      width: width/2,
                      height: 200,

                      child: Column(
                        children: [
                          Text("General Secretary",style:TextStyle(
                              fontFamily: "Poppins",
                              color: myGreen
                          )),
                          const SizedBox(
                            height: 8,
                          ),

                          value.committeeDesignationModelList.where((element) => element.desination=="General Secretary").isEmpty?
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            child: Image.asset("assets/img.png",scale: 2.5),
                          ):value.committeeDesignationModelList[value.committeeDesignationModelList.indexWhere((element) =>
                          element.desination=="General Secretary")].photo==''? CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            child:Icon(Icons.person,color: myGreen.withOpacity(0.5),size:35 ,),
                          ): CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(value.committeeDesignationModelList[value.committeeDesignationModelList.indexWhere((element) => element.desination=="General Secretary")].photo),
                          ),
                          const SizedBox(height: 5),
                          value.committeeDesignationModelList.where((element) => element.desination=="General Secretary").isNotEmpty?
                          Text(value.committeeDesignationModelList[value.committeeDesignationModelList.indexWhere((element) => element.desination=="General Secretary")].name,
                            style:const TextStyle(
                              fontFamily:"Poppins",
                              fontWeight:FontWeight.bold
                          ),
                            textAlign:TextAlign.center,
                          ):
                          const Text("Add Member",style:TextStyle(
                              fontFamily:"Poppins",
                              fontWeight:FontWeight.bold
                          ),
                            textAlign:TextAlign.center,
                          ),
                          value.committeeDesignationModelList.where((element) => element.desination=="General Secretary").isEmpty?
                          const SizedBox():
                          Text("Membership ID:${value.committeeDesignationModelList[value.committeeDesignationModelList
                              .indexWhere((element) => element.desination=="General Secretary")].memberId}",
                            style: const TextStyle(
                                fontFamily:"poppins",
                                fontSize: 11
                            ),),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              if(value.committeeDesignationModelList.where((element) => element.desination=="General Secretary").isEmpty){
                                committeeAlert(context,"General Secretary", state, district, assembly, unit,"");
                              }else{
                              committeeAlert(context,"General Secretary", state, district, assembly, unit,value.committeeDesignationModelList[value.committeeDesignationModelList
                                  .indexWhere((element) => element.desination=="General Secretary")].memberId);}
                            },
                            child: Consumer<MainProvider>(
                              builder: (context,value,child) {
                                return
                                  value.stateCommitteeLock|| from=='NATIONAL_LEVEL'?
                                  Container(
                                  height: 20,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: myDarkGreen,
                                  ),
                                  child:  Center(
                                    child: Text(
                                        value.committeeDesignationModelList.where((element) => element.desination=="General Secretary").isEmpty?"Add":"Edit",style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily:"Poppins",
                                        fontSize: 12
                                    )),
                                  ),
                                ):SizedBox();
                              }
                            ),
                          )
                        ],
                      ),
                    );
                  }
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return SizedBox(
                      width: width/2,
                      height: 200,

                      child: Column(
                        children: [
                          Text("Treasurer",style:TextStyle(
                              fontFamily: "Poppins",
                              color: myGreen
                          )),
                          const SizedBox(
                            height: 8,
                          ),

                          value.committeeDesignationModelList.where((element) => element.desination=="Treasurer").isEmpty?
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            child: Image.asset("assets/img.png",scale: 2.5),
                          ):value.committeeDesignationModelList[value.committeeDesignationModelList.indexWhere((element) =>
                          element.desination=="Treasurer")].photo==''? CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            child:Icon(Icons.person,color: myGreen.withOpacity(0.5),size:35 ,),
                          ): CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(value.committeeDesignationModelList[value.committeeDesignationModelList.indexWhere((element) => element.desination=="Treasurer")].photo),
                          ),
                          const SizedBox(height: 5),
                          value.committeeDesignationModelList.where((element) => element.desination=="Treasurer").isNotEmpty?
                          Text(value.committeeDesignationModelList[value.committeeDesignationModelList.indexWhere((element) => element.desination=="Treasurer")].name,
                            style:const TextStyle(
                              fontFamily:"Poppins",
                              fontWeight:FontWeight.bold
                          ),
                            textAlign:TextAlign.center,
                          ):
                          const Text("Add Member",style:TextStyle(
                              fontFamily:"Poppins",
                              fontWeight:FontWeight.bold
                          ),
                            textAlign:TextAlign.center,
                          ),
                          value.committeeDesignationModelList.where((element) => element.desination=="Treasurer").isEmpty?
                          const SizedBox():
                          Text("Membership ID:${value.committeeDesignationModelList[value.committeeDesignationModelList
                              .indexWhere((element) => element.desination=="Treasurer")].memberId}",
                            style: const TextStyle(
                                fontFamily:"poppins",
                                fontSize: 11
                            ),),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              if(value.committeeDesignationModelList.where((element) => element.desination=="Treasurer").isEmpty){
                                committeeAlert(context,"Treasurer", state, district, assembly, unit,"");
                              }else{
                              committeeAlert(context,"Treasurer", state, district, assembly, unit,value.committeeDesignationModelList[value.committeeDesignationModelList
                                  .indexWhere((element) => element.desination=="Treasurer")].memberId);}
                            },
                            child: Consumer<MainProvider>(
                              builder: (context,value,child) {
                                return
                                  value.stateCommitteeLock|| from=='NATIONAL_LEVEL'?
                                  Container(
                                  height: 20,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: myDarkGreen,
                                  ),
                                  child:  Center(
                                    child: Text(
                                        value.committeeDesignationModelList.where((element) => element.desination=="Treasurer").isEmpty?"Add":"Edit",style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily:"Poppins",
                                        fontSize: 12
                                    )),
                                  ),
                                ):SizedBox();
                              }
                            ),
                          )
                        ],
                      ),
                    );
                  }
                ),
              ],
            ),




            // Expanded(
            //   child: Consumer<MainProvider>(
            //     builder: (context,value,child) {
            //       return GridView.builder(
            //         physics: const NeverScrollableScrollPhysics(),
            //           itemCount: value.designationList.length,
            //           shrinkWrap: true,
            //           itemBuilder: (BuildContext context, int index) {
            //             // var item = value.committeeMembersList[index];
            //             return SizedBox(
            //               height: 300,
            //               child: Column(
            //                 children: [
            //                   Text(value.designationList[index],style: TextStyle(
            //                     fontFamily: "Poppins",
            //                     color: myGreen
            //                   )),
            //                   const SizedBox(
            //                     height: 8,
            //                   ),
            //
            //                   CircleAvatar(
            //                     radius: 45,
            //                     backgroundColor: Colors.white,
            //                     child: Image.asset("assets/img.png",scale: 2.5),
            //                   ),
            //                   const SizedBox(height: 5),
            //                   const Text("Add Member",style:TextStyle(
            //                       fontFamily:"Poppins",
            //                       fontWeight:FontWeight.bold
            //                   ),
            //                     textAlign:TextAlign.center,
            //                   ),
            //                   const Text("Membership ID: 123456",style: TextStyle(
            //                     fontFamily:"poppins",
            //                     fontSize: 11
            //                   ),),
            //                   const SizedBox(height: 10),
            //                   Container(
            //                     height: 20,
            //                     width: 70,
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(15),
            //                       color: myDarkGreen,
            //                     ),
            //                     child: const Center(
            //                       child: Text("Edit",style: TextStyle(
            //                         color: Colors.white,
            //                         fontFamily: "Poppins",
            //                         fontSize: 12
            //                       )),
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             );
            //           },
            //         gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 3,
            //           childAspectRatio: .6,
            //           mainAxisSpacing: 10,
            //         ),);
            //     }
            //   ),
            // ),

          ],
        ),
      ),
    );
  }



  committeeAlert(BuildContext context,String designation,String state,String district, String assembly,String unit,String oldID) {
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.memberUnit.clear();
    String memberId ="";
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      scrollable: true,
      title:  Text(
        "Select your Committee ${designation}",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13,fontFamily: "Poppins"),
      ),
      content:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
          child: Consumer<MainProvider>(
              builder: (context,value,child) {
                print(value.selectCommiteeList.length.toString()+' ICUFUCIFV');
                return Autocomplete<CounsilorNomineeModel>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    return value.selectCommiteeList
                        .where((CounsilorNomineeModel item) => item.name
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()))
                        .toList();
                  },
                  displayStringForOption: (CounsilorNomineeModel option) => option.name,
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      VoidCallback onFieldSubmitted) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      fieldTextEditingController.text = value.memberUnit.text;
                    });

                    return SizedBox(
                      child: TextFormField(
                        maxLines: null,
                        decoration: InputDecoration(
                          contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
                          hintStyle:  TextStyle(color: myBlack.withOpacity(0.6),
                              fontFamily: "PoppinsMedium",fontSize: 13,fontWeight: FontWeight.bold),
                          fillColor: Colors.white,
                          filled: true,
                          border: UnderlineInputBorder(
                            // borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(width: 2, color: clDDDDDD),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            // borderRadius: BorderRadius.circular(30),
                              borderSide:  BorderSide(
                                  color: myGreen,width: 2)),
                          enabledBorder:  UnderlineInputBorder(
                            // borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(width: 2, color: clDDDDDD),
                          ),
                          hintText: "Select",
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: 25,
                            color: Colors.black38,
                          ),
                        ),
                        validator: (value2) {
                          if (value2!.trim().isEmpty) {
                            return "Field is required";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (txt) {
                          value.memberUnit.text= txt;
                        },
                        controller: fieldTextEditingController,
                        focusNode: fieldFocusNode,
                      ),
                    );
                  },

                  onSelected: (CounsilorNomineeModel selection) {

                    value.memberUnit.text= selection.name;
                    memberId = selection.memberId;
                    value.requestMemberUnit= value.memberUnit.text.toString();
                    value.selectedID = selection.memberId;
                    // value.requestMemberAssembly=selection.assembly;
                    // value.requestMemberDistrict=selection.district;
                    // value.requestMemberState=selection.state;
                  },
                  optionsViewBuilder: (BuildContext context,
                      AutocompleteOnSelected<CounsilorNomineeModel> onSelected,
                      Iterable<CounsilorNomineeModel> options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        child: Container(
                          width:  200,
                          height: 300,
                          color: Colors.white,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(10.0),
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              final CounsilorNomineeModel option = options.elementAt(index);

                              return GestureDetector(
                                onTap: () {
                                  onSelected(option);
                                },
                                child: Container(
                                  color: Colors.white,
                                  height: 50,
                                  width: 200,
                                  child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(option.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 10)
                                      ]),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
          )
      ),
      actions: [
        InkWell(
          onTap: () {
            if(oldID==""){
              mainProvider.addCommittee(memberId, from, designation,oldID,"NEW");
              mainProvider.getUnitCommitees(state, district, assembly, unit,from);
            }else{
            mainProvider.addCommittee(memberId, from, designation, oldID,"EDIT");
            mainProvider.getUnitCommitees(state, district, assembly, unit,from);
            }
            finish(context);
          },
          child: Container(
            height: 30,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: myDarkGreen,
            ),
            child: const Center(
              child: Text("ok",style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontSize: 12
              )),
            ),
          ),
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
