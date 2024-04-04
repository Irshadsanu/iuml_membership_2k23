import 'package:flutter/material.dart';
import 'package:iuml_membership/Models/committee_model.dart';
import 'package:provider/provider.dart';

import '../Constants/my_functions.dart';
import '../constants/my_colors.dart';
import '../constants/my_text.dart';
import '../providers/Main_Provider.dart';

class AddCounsilorsScreen extends StatelessWidget {
  String uId;
  String from;
  String state, district, assembly,unit;

  AddCounsilorsScreen({super.key,required this.uId,required this.from,required this.state,required this.district,required this.assembly,required this.unit});

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
        title: Text(from=="NATIONAL_LEVEL"?"NATIONAL LEVEL":
        from=="STATE_LEVEL"?"STATE LEVEL":
        from=="DISTRICT_LEVEL"?"DISTRICT LEVEL":from=="ASSEMBLY_LEVEL"?"ASSEMBLY LEVEL":"UNIT LEVEL",
          style:TextStyle(color: myBlack,fontSize: 14,fontWeight: FontWeight.bold,fontFamily: "Poppins"),),
        leadingWidth: 100,
        leading:InkWell(
          onTap: (){
            finish(context);
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios_new,color: myDarkGreen,),
              Text("IUML",
                style:TextStyle(color: myGreen2,fontSize: 16,fontWeight: FontWeight.bold,fontFamily: "Poppins"),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 25,),
            Consumer<MainProvider>(
              builder: (context,value,child) {
                print(value.paidMemberModelList.length.toString()+' INRIFJNRF');
                return from == "UNIT_LEVEL"?Container(
                  child: value.paidMemberModelList.isNotEmpty?
                  ListView.builder(
                      itemCount: value.paidMemberModelList.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var item= value.paidMemberModelList[index];
                        return Container(
                          // height: 50,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  mainProvider.selectionForNomineeUnitLevel(index,item.memberId);
                                },
                                child: Container(
                                  margin:const EdgeInsets.symmetric(horizontal: 12,vertical: 7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: Colors.white,
                                      border: Border.all(color: myGrey2,width: 0.5,)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0,right: 5),
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
                                          subtitle: Text("Membership ID : ${item.memberId}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Poppins",
                                                fontSize: 13,
                                                color: myBlack),),
                                          trailing: Container(
                                                 child: item.isSelected?
                                                 Image.asset("assets/memberSelect.png",scale: 3,) :
                                                Image.asset("assets/memberUnselect.png",scale: 3,),
                                          )
                                        ),
                                        Container(
                                            width: 70,
                                            height: 34,
                                            decoration: BoxDecoration(color: mainColor,borderRadius: BorderRadius.circular(81)),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image.asset("assets/whatsapp.png",scale: 2.8,),
                                                Image.asset("assets/Contact.png",scale: 2,),
                                              ],
                                            )),
                                        SizedBox(height: 5,)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5,)
                            ],
                          ),
                        );
                      }):Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 250,),
                          Text("There is no members",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "Poppins"),),
                        ],
                      ),
                ):
                value.getCounsilors(from).isNotEmpty?Container(
                  child:
                  ListView.builder(
                      itemCount: value.getCounsilors(from).length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        print(value.getCounsilors(from).length.toString()+"uiuiioio");

                        var item= value.getCounsilors(from)[index];
                        return Container(
                          // height: 50,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  mainProvider.selectionForNominee(index,item.memberId,from);
                                },
                                child: Container(
                                  margin:const EdgeInsets.symmetric(horizontal: 12,vertical: 7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: Colors.white,
                                      border: Border.all(color: myGrey2,width: 0.5,)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0,right: 5),
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
                                            subtitle: Text("Membership ID : ${item.memberId}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Poppins",
                                                  fontSize: 13,
                                                  color: myBlack),),
                                            trailing: Container(
                                              child: item.isSelected?
                                              Image.asset("assets/memberSelect.png",scale: 3,) :
                                              Image.asset("assets/memberUnselect.png",scale: 3,),
                                            )
                                        ),
                                        Container(
                                            width: 70,
                                            height: 34,
                                            decoration: BoxDecoration(color: mainColor,borderRadius: BorderRadius.circular(81)),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Image.asset("assets/whatsapp.png",scale: 2.8,),
                                                Image.asset("assets/Contact.png",scale: 2,),
                                              ],
                                            )),
                                        SizedBox(height: 5,)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5,)
                            ],
                          ),
                        );
                      })
                )
                    :Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       SizedBox(height: 250,),
                       Text("There is no Nominees",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "Poppins"),),
                  ],
                );
              }
            ),
            const SizedBox(height: 50),
            Consumer<MainProvider>(
              builder: (context,val,child) {
                return InkWell(
                  onTap: (){
                    mainProvider.addNominee(state,district,assembly,unit,from);
                    finish(context);
                  },
                  child:val.paidMemberModelList.isNotEmpty||val.getCounsilors(from).isNotEmpty? Container(
                    height: 45,
                    margin: const EdgeInsets.symmetric(horizontal: 60),
                    decoration: BoxDecoration(
                      color: myDarkGreen,
                      borderRadius: BorderRadius.circular(52),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Add",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: "PoppinsMedium"
                          ),),
                      ],
                    ),
                  ):SizedBox(),
                );
              }
            ),

            //
            // SizedBox(height: 30,),
            // Center(
            //   child: Consumer<MainProvider>(
            //       builder: (context1, value2, child) {
            //         return Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 7),
            //           child: DropdownButtonFormField<String>(
            //             dropdownColor: Colors.white,
            //             decoration:  InputDecoration(
            //               contentPadding:const EdgeInsets.symmetric(vertical: 15,horizontal: 8),
            //               filled: true,
            //               fillColor: Colors.white,
            //               border: OutlineInputBorder(
            //                 borderSide: BorderSide(width: 0.5, color: myGrey2),
            //                 borderRadius: const BorderRadius.all(Radius.circular(73.0)),
            //               ),
            //               focusedBorder:  OutlineInputBorder(
            //                 borderSide: BorderSide(width:1, color: myGreen),
            //                 borderRadius: const BorderRadius.all(Radius.circular(73.0)),
            //               ),
            //               enabledBorder: OutlineInputBorder(
            //                 borderSide: BorderSide(width: 0.5, color: myGrey2),
            //                 borderRadius: const BorderRadius.all(Radius.circular(73.0)),
            //               ),
            //             ),
            //             value: value2.dropdownValue,
            //             isExpanded: true,
            //             icon: const Padding(
            //               padding: EdgeInsets.only(right: 18.0),
            //               child: Icon(
            //                 Icons.keyboard_arrow_down_outlined,
            //                 size: 30,
            //               ),
            //             ),
            //             iconSize: 24,
            //             elevation: 16,
            //             style:  TextStyle(
            //               fontWeight: FontWeight.bold,
            //               color:myBlack.withOpacity(0.6),
            //               fontFamily: "PoppinsMedium",
            //               fontSize: 13,
            //             ),
            //             onChanged: (changeValue) {
            //               value2.committeeDesignationSelect(changeValue);
            //               print("${value2.dropdownValue}vhrfgry");
            //
            //             },
            //             items:value2.committeeList.map<DropdownMenuItem<String>>((String values) {
            //               return DropdownMenuItem<String>(
            //                 value: values,
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(left: 12.0, right: 15),
            //                   child: Text(values),
            //                 ),
            //               );
            //             }).toList(),
            //           ),
            //         );
            //       }),
            // ),
            // Center(
            //   child: Consumer<MainProvider>(
            //       builder: (context1, value2, child) {
            //         return Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 7),
            //           child:Autocomplete<CommitteeModel>(
            //             optionsBuilder: (TextEditingValue textEditingValue) {
            //
            //               return (value2.memberNameList)
            //
            //                   .where((CommitteeModel member) => member.name
            //                   .contains(textEditingValue.text.toLowerCase()))
            //                   .toList();
            //             },
            //             displayStringForOption: (CommitteeModel option) => option.name,
            //             fieldViewBuilder: (
            //                 BuildContext context,
            //                 TextEditingController fieldTextEditingController,
            //                 FocusNode fieldFocusNode,
            //                 VoidCallback onFieldSubmitted
            //                 ) {
            //
            //               return TextFormField(
            //                 scrollPadding: const EdgeInsets.only(bottom: 500),
            //                 decoration:  InputDecoration(
            //                   filled: true,
            //                   fillColor: Colors.white,
            //                   contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            //                   border: OutlineInputBorder(
            //                     borderSide: BorderSide(width: 0.5, color: myGrey2),
            //                     borderRadius: const BorderRadius.all(Radius.circular(73.0)),
            //                   ),
            //                   enabledBorder: OutlineInputBorder(
            //                     borderSide: BorderSide(width: 0.5, color: myGrey2),
            //                     borderRadius: const BorderRadius.all(Radius.circular(73.0)),
            //                   ),
            //                   focusedBorder: OutlineInputBorder(
            //                     borderSide: BorderSide(width:1, color: myGreen),
            //                     borderRadius: const BorderRadius.all(Radius.circular(73.0)),
            //                   ),
            //                   suffixIcon:  Padding(
            //                     padding: const EdgeInsets.only(right: 25.0),
            //                     child: Icon(
            //                       Icons.keyboard_arrow_down_sharp,
            //                       size: 30,
            //                       color: myBlack.withOpacity(0.6),
            //                     ),
            //                   ),
            //                   hintText: "Select Member",
            //                   hintStyle: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                     color:myBlack.withOpacity(0.6),
            //                     fontFamily: "PoppinsMedium",
            //                     fontSize: 13,
            //                   ),
            //                 ),
            //                 controller: fieldTextEditingController,
            //                 focusNode: fieldFocusNode,
            //                 style:  TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   color:myBlack.withOpacity(0.6),
            //                   fontFamily: "PoppinsMedium",
            //                   fontSize: 14,
            //                 ),
            //                 validator: (value2) {
            //                   if (value2!.trim().isEmpty) {
            //                     return "Please Select Name";
            //                   } else {
            //                     return null;
            //                   }
            //                 },
            //                 onChanged: (text){
            //
            //                 },
            //               );
            //
            //             },
            //             onSelected: (CommitteeModel selection) {
            //               MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
            //               print(selection.name.toString()+"wwwwiefjmf");
            //               print(selection.id.toString()+"wwwwiefjmf");
            //               mainProvider.selectMemberName(selection);
            //
            //
            //             },
            //             optionsViewBuilder: (
            //                 BuildContext context,
            //                 AutocompleteOnSelected<CommitteeModel> onSelected,
            //                 Iterable<CommitteeModel> options
            //                 ) {
            //               return Align(
            //                 alignment: Alignment.topLeft,
            //                 child: Material(
            //                   child: Container(
            //                     width: width-30,
            //                     height: 400,
            //                     color: Colors.white,
            //                     child: ListView.builder(
            //                       padding: const EdgeInsets.all(10.0),
            //                       itemCount: options.length,
            //                       itemBuilder: (BuildContext context, int index) {
            //                         final CommitteeModel option = options.elementAt(index);
            //
            //                         return GestureDetector(
            //                           onTap: () {
            //                             onSelected(option);
            //                           },
            //                           child:  Container(
            //                             color: Colors.white,
            //                             height: 50,
            //                             width: width-30,
            //                             child: Column(
            //                                 crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                                 children: [
            //                                   Text(option.name,
            //                                       style: const TextStyle(
            //                                           fontWeight: FontWeight.bold)),
            //                                   const SizedBox(height: 10)
            //                                 ]),
            //                           ),
            //                         );
            //                       },
            //                     ),
            //                   ),
            //                 ),
            //               );
            //             },
            //           ),
            //         );
            //       }),
            // ),
            // // Consumer<MainProvider>(
            // //   builder: (context,val,child) {
            // //     return Padding(
            // //         padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 7),
            // //         child: textFormField("Name",val.committeeNameCT)
            // //     );
            // //   }
            // // ),
            // // Consumer<MainProvider>(
            // //     builder: (context,val2,child) {
            // //     return Padding(
            // //         padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 7),
            // //         child: textFormField("House Name",val2.committeeHouseNameCT),
            // //     );
            // //   }
            // // ),
            // // Consumer<MainProvider>(
            // //     builder: (context,val3,child) {
            // //     return Padding(
            // //       padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 7),
            // //       child: textFormField("Phone Number",val3.committeePhoneCT),
            // //     );
            // //   }
            // // ),
            // // Consumer<MainProvider>(
            // //     builder: (context,val4,child) {
            // //     return Padding(
            // //       padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 7),
            // //       child: textFormField("Address",val4.committeeAddressCT),
            // //     );
            // //   }
            // // ),
            // Padding(
            //   padding: const EdgeInsets.all(13.0),
            //   child: InkWell(
            //     onTap: (){
            //       mainProvider.addCommittee(uId,from);
            //       mainProvider.getCommittee(state,district,assembly,panchayath,unit);
            //       finish(context);
            //     },
            //     child: Container(
            //       height: 50,
            //       width: 341,
            //       decoration: BoxDecoration(
            //         color: myDarkGreen,
            //         borderRadius: BorderRadius.circular(54),
            //       ),
            //       child: const Center(
            //         child: Text("Next",
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 14,
            //               fontWeight: FontWeight.w700,
            //               fontFamily: "PoppinsMedium"
            //           ),),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 25,),
          ],
        ),
      ),
    );
  }
}
