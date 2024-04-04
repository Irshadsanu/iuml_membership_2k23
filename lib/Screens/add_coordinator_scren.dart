import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iuml_membership/Screens/Add_New_Member.dart';
import 'package:provider/provider.dart';
import '../constants/my_colors.dart';
import '../providers/Main_Provider.dart';

class AddCoordinatorScreen extends StatelessWidget {
String uId;
String from;
String state;
String district;
String assembly;
String unit;
String type;
String coordId;
 AddCoordinatorScreen({super.key,required this.uId,required this.from,required this.state,required this.district,
   required this.assembly,required this.unit,required this.type,required this.coordId});

final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MainProvider providerValue = Provider.of<MainProvider>(context,listen: false);
    var width=MediaQuery.of(context).size.width;
    var hieght=MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        centerTitle: true,
        title: Text("Add Coordinators",style:TextStyle(color: myBlack,fontSize: 18,fontWeight: FontWeight.bold,fontFamily: "Poppins"),),
        leadingWidth: 100,
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
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: hieght/46),
                child: Consumer<MainProvider>(
                  builder: (context,val,child) {
                    return Stack(
                      children: [
                        CircleAvatar(
                          radius: 61,
                          backgroundColor: Colors.grey.shade300,

                        ),
                        Positioned(
                          top: 1,
                          left: 1,
                          child:val.coordinatorImage != null ?
                          CircleAvatar(
                            radius: 60,
                            backgroundImage:
                            FileImage(val.coordinatorImage!),
                          ):val.coordinatorImageUrl != '' ?
                          CircleAvatar(
                            radius: 60,
                            backgroundImage:
                            NetworkImage(val.coordinatorImageUrl),
                          ):CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.person,color: Colors.black54,size: 55),
                                Text("Photo",style: TextStyle(color: Colors.grey,fontSize: 14),)
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          height: hieght/4.3,
                          left: width/4.7,
                          child: InkWell(
                            hoverColor : Colors.transparent,
                            splashColor:Colors.transparent ,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              providerValue.showBottomSheet(context);
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: myGreen,
                              child: const Icon(Icons.add),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                child: TextFormField(
                  maxLines: null,
                  controller: providerValue.coordinatorName,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    UpperCaseTextFormatter()
                  ],
                  decoration: InputDecoration(
                    contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w400,fontSize: 13,fontFamily: "Poppins"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.black38,width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:  BorderSide(
                          color: myGreen,)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.black38,width: 0.5,
                      ),
                    ),
                    hintText: "Enter Name",

                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This Field is Required";
                    }

                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  enabled: type==""?true:false,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  controller: providerValue.coordinatorPhone,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
                    hintStyle:TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w400,fontSize: 13,fontFamily: "Poppins"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.black38,width: 0.5,
                      ), ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:  BorderSide(
                          color: myGreen,width: 1,)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.black38,
                        width: 0.5,
                      ),
                    ),
                    hintText: "Phone Number",

                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please Enter Mobile Number";
                    } else if (!RegExp(r'^[0-9]+$')
                        .hasMatch(value) ||
                        value.length != 10) {
                      return "Enter Correct Mobile Number";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  maxLines: null,
                  controller: providerValue.coordinatorAddress,
                  inputFormatters: [
                    UpperCaseTextFormatter()
                  ],
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle:  TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w400,fontSize: 13,fontFamily: "Poppins"),
                    contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.black38,width: 0.5,
                      ), ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:  BorderSide(
                          color: myGreen,width: 1,)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.black38,
                        width: 0.5,
                      ),
                    ),
                    hintText: "Address",

                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This Field is Required";
                    }

                    return null;
                  },
                ),
              ),
              // Column(
              //   children: [
              //     // from=="PANCHAYATH_LEVEL"?
              //     // Padding(
              //     //     padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
              //     //     child: Consumer<MainProvider>(
              //     //         builder: (context,value,child) {
              //     //           return Autocomplete<UnitModel>(
              //     //             optionsBuilder: (TextEditingValue textEditingValue) {
              //     //               return value.selectUnitList
              //     //                   .where((UnitModel item) => item.unit
              //     //                   .toLowerCase()
              //     //                   .contains(textEditingValue.text.toLowerCase()))
              //     //                   .toList();
              //     //             },
              //     //             displayStringForOption: (UnitModel option) => option.unit,
              //     //             fieldViewBuilder: (BuildContext context,
              //     //                 TextEditingController fieldTextEditingController,
              //     //                 FocusNode fieldFocusNode,
              //     //                 VoidCallback onFieldSubmitted) {
              //     //               WidgetsBinding.instance.addPostFrameCallback((_) {
              //     //                 fieldTextEditingController.text = value.coordinatorUnit.text;
              //     //               });
              //     //
              //     //               return SizedBox(
              //     //                 child: TextFormField(
              //     //                   maxLines: null,
              //     //                   textAlign: TextAlign.center,
              //     //                   decoration: InputDecoration(
              //     //                     contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
              //     //                     hintStyle:  TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w400,fontSize: 13,fontFamily: "Poppins"),
              //     //                     fillColor: Colors.white,
              //     //                     filled: true,
              //     //                     border: OutlineInputBorder(
              //     //                       borderRadius: BorderRadius.circular(30),
              //     //                       borderSide: const BorderSide(
              //     //                         color: Colors.black38,width: 0.5,
              //     //                       ), ),
              //     //                     focusedBorder: OutlineInputBorder(
              //     //                         borderRadius: BorderRadius.circular(30),
              //     //                         borderSide:  BorderSide(
              //     //                           color: myGreen,width: 1,)),
              //     //                     enabledBorder: OutlineInputBorder(
              //     //                       borderRadius: BorderRadius.circular(30),
              //     //                       borderSide: const BorderSide(
              //     //                         color: Colors.black38,
              //     //                         width: 0.5,
              //     //                       ),
              //     //                     ),
              //     //                     hintText: "Unit",
              //     //                     // suffixIcon: const Icon(
              //     //                     //   Icons.keyboard_arrow_down_sharp,
              //     //                     //   size: 25,
              //     //                     //   color: Colors.black38,
              //     //                     // ),
              //     //                   ),
              //     //                   validator: (value2) {
              //     //                     if (value2!.trim().isEmpty) {
              //     //                       return "Field is required";
              //     //                     } else {
              //     //                       return null;
              //     //                     }
              //     //                   },
              //     //                   onChanged: (txt) {
              //     //                     // value.memberUnit.text= txt;
              //     //                   },
              //     //                   controller: fieldTextEditingController,
              //     //                   focusNode: fieldFocusNode,
              //     //                 ),
              //     //               );
              //     //             },
              //     //
              //     //             onSelected: (UnitModel selection) {
              //     //
              //     //               value.coordinatorUnit.text= selection.unit;
              //     //             },
              //     //             optionsViewBuilder: (BuildContext context,
              //     //                 AutocompleteOnSelected<UnitModel> onSelected,
              //     //                 Iterable<UnitModel> options) {
              //     //               return Align(
              //     //                 alignment: Alignment.topLeft,
              //     //                 child: Material(
              //     //                   child: Container(
              //     //                     width:  MediaQuery.of(context).size.width*0.86,
              //     //                     height: MediaQuery.of(context).size.height*0.3,
              //     //                     color: Colors.white,
              //     //                     child: ListView.builder(
              //     //                       padding: const EdgeInsets.all(10.0),
              //     //                       itemCount: options.length,
              //     //                       itemBuilder: (BuildContext context, int index) {
              //     //                         final UnitModel option = options.elementAt(index);
              //     //
              //     //                         return GestureDetector(
              //     //                           onTap: () {
              //     //                             onSelected(option);
              //     //                           },
              //     //                           child: Container(
              //     //                             color: Colors.white,
              //     //                             height: 50,
              //     //                             width: MediaQuery.of(context).size.width*0.86,
              //     //                             child: Column(
              //     //                                 crossAxisAlignment:
              //     //                                 CrossAxisAlignment.start,
              //     //                                 children: [
              //     //                                   Text(option.unit,
              //     //                                       style: const TextStyle(
              //     //                                           fontWeight: FontWeight.bold)),
              //     //                                   const SizedBox(height: 10)
              //     //                                 ]),
              //     //                           ),
              //     //                         );
              //     //                       },
              //     //                     ),
              //     //                   ),
              //     //                 ),
              //     //               );
              //     //             },
              //     //           );
              //     //         }
              //     //     )
              //     // ):
              //     from=="ASSEMBLY_LEVEL"?
              //     Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
              //         child: Consumer<MainProvider>(
              //             builder: (context,value,child) {
              //               return Autocomplete<UnitModel>(
              //                 optionsBuilder: (TextEditingValue textEditingValue) {
              //                   return value.selectUnitList
              //                       .where((UnitModel item) => item.unit
              //                       .toLowerCase()
              //                       .contains(textEditingValue.text.toLowerCase()))
              //                       .toList();
              //                 },
              //                 displayStringForOption: (UnitModel option) => option.unit,
              //                 fieldViewBuilder: (BuildContext context,
              //                     TextEditingController fieldTextEditingController,
              //                     FocusNode fieldFocusNode,
              //                     VoidCallback onFieldSubmitted) {
              //                   WidgetsBinding.instance.addPostFrameCallback((_) {
              //                     fieldTextEditingController.text = value.coordinatorUnit.text;
              //                   });
              //
              //                   return SizedBox(
              //                     child: TextFormField(
              //                       maxLines: null,
              //                       textAlign: TextAlign.center,
              //                       decoration: InputDecoration(
              //                         contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
              //                         hintStyle:  TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w400,fontSize: 13,fontFamily: "Poppins"),
              //                         fillColor: Colors.white,
              //                         filled: true,
              //                         border: OutlineInputBorder(
              //                           borderRadius: BorderRadius.circular(30),
              //                           borderSide: const BorderSide(
              //                             color: Colors.black38,width: 0.5,
              //                           ), ),
              //                         focusedBorder: OutlineInputBorder(
              //                             borderRadius: BorderRadius.circular(30),
              //                             borderSide:  BorderSide(
              //                               color: myGreen,width: 1,)),
              //                         enabledBorder: OutlineInputBorder(
              //                           borderRadius: BorderRadius.circular(30),
              //                           borderSide: const BorderSide(
              //                             color: Colors.black38,
              //                             width: 0.5,
              //                           ),
              //                         ),
              //                         hintText: "Unit",
              //                         // suffixIcon: const Icon(
              //                         //   Icons.keyboard_arrow_down_sharp,
              //                         //   size: 25,
              //                         //   color: Colors.black38,
              //                         // ),
              //                       ),
              //                       validator: (value2) {
              //                         if (value2!.trim().isEmpty) {
              //                           return "Field is required";
              //                         } else {
              //                           return null;
              //                         }
              //                       },
              //                       onChanged: (txt) {
              //                         // value.memberUnit.text= txt;
              //                       },
              //                       controller: fieldTextEditingController,
              //                       focusNode: fieldFocusNode,
              //                     ),
              //                   );
              //                 },
              //
              //                 onSelected: (UnitModel selection) {
              //
              //                   value.coordinatorUnit.text= selection.unit;
              //                 },
              //                 optionsViewBuilder: (BuildContext context,
              //                     AutocompleteOnSelected<UnitModel> onSelected,
              //                     Iterable<UnitModel> options) {
              //                   return Align(
              //                     alignment: Alignment.topLeft,
              //                     child: Material(
              //                       child: Container(
              //                         width:  MediaQuery.of(context).size.width*0.86,
              //                         height: MediaQuery.of(context).size.height*0.3,
              //                         color: Colors.white,
              //                         child: ListView.builder(
              //                           padding: const EdgeInsets.all(10.0),
              //                           itemCount: options.length,
              //                           itemBuilder: (BuildContext context, int index) {
              //                             final UnitModel option = options.elementAt(index);
              //
              //                             return GestureDetector(
              //                               onTap: () {
              //                                 onSelected(option);
              //                               },
              //                               child: Container(
              //                                 color: Colors.white,
              //                                 height: 50,
              //                                 width: MediaQuery.of(context).size.width*0.86,
              //                                 child: Column(
              //                                     crossAxisAlignment:
              //                                     CrossAxisAlignment.start,
              //                                     children: [
              //                                       Text(option.unit,
              //                                           style: const TextStyle(
              //                                               fontWeight: FontWeight.bold)),
              //                                       const SizedBox(height: 10)
              //                                     ]),
              //                               ),
              //                             );
              //                           },
              //                         ),
              //                       ),
              //                     ),
              //                   );
              //                 },
              //               );
              //             }
              //         )
              //     ):
              //     // Padding(
              //     //     padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
              //     //     child: Consumer<MainProvider>(
              //     //         builder: (context,value,child) {
              //     //           return Autocomplete<String>(
              //     //             optionsBuilder: (TextEditingValue textEditingValue) {
              //     //               return value.panchayathList
              //     //                   .where((String item) => item
              //     //                   .toLowerCase()
              //     //                   .contains(textEditingValue.text.toLowerCase()))
              //     //                   .toList();
              //     //             },
              //     //             displayStringForOption: (String option) => option,
              //     //             fieldViewBuilder: (BuildContext context,
              //     //                 TextEditingController fieldTextEditingController,
              //     //                 FocusNode fieldFocusNode,
              //     //                 VoidCallback onFieldSubmitted) {
              //     //               WidgetsBinding.instance.addPostFrameCallback((_) {
              //     //                 fieldTextEditingController.text = value.coordinatorPanchayath.text;
              //     //               });
              //     //
              //     //               return SizedBox(
              //     //                 child: TextFormField(
              //     //                   maxLines: null,
              //     //                   textAlign: TextAlign.center,
              //     //                   decoration: InputDecoration(
              //     //                     contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
              //     //                     hintStyle:  TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w400,fontSize: 13,fontFamily: "Poppins"),
              //     //                     fillColor: Colors.white,
              //     //                     filled: true,
              //     //                     border: OutlineInputBorder(
              //     //                       borderRadius: BorderRadius.circular(30),
              //     //                       borderSide: const BorderSide(
              //     //                         color: Colors.black38,width: 0.5,
              //     //                       ), ),
              //     //                     focusedBorder: OutlineInputBorder(
              //     //                         borderRadius: BorderRadius.circular(30),
              //     //                         borderSide:  BorderSide(
              //     //                           color: myGreen,width: 1,)),
              //     //                     enabledBorder: OutlineInputBorder(
              //     //                       borderRadius: BorderRadius.circular(30),
              //     //                       borderSide: const BorderSide(
              //     //                         color: Colors.black38,
              //     //                         width: 0.5,
              //     //                       ),
              //     //                     ),
              //     //                     hintText: "Panchayath",
              //     //                     // suffixIcon: const Icon(
              //     //                     //   Icons.keyboard_arrow_down_sharp,
              //     //                     //   size: 25,
              //     //                     //   color: Colors.black38,
              //     //                     // ),
              //     //                   ),
              //     //                   validator: (value2) {
              //     //                     if (value2!.trim().isEmpty) {
              //     //                       return "Field is required";
              //     //                     } else {
              //     //                       return null;
              //     //                     }
              //     //                   },
              //     //                   onChanged: (txt) {
              //     //                     // value.memberUnit.text= txt;
              //     //                   },
              //     //                   controller: fieldTextEditingController,
              //     //                   focusNode: fieldFocusNode,
              //     //                 ),
              //     //               );
              //     //             },
              //     //
              //     //             onSelected: (String selection) {
              //     //               value.coordinatorPanchayath.text= selection;
              //     //
              //     //             },
              //     //             optionsViewBuilder: (BuildContext context,
              //     //                 AutocompleteOnSelected<String> onSelected,
              //     //                 Iterable<String> options) {
              //     //               return Align(
              //     //                 alignment: Alignment.topLeft,
              //     //                 child: Material(
              //     //                   child: Container(
              //     //                     width:  MediaQuery.of(context).size.width*0.86,
              //     //                     height: MediaQuery.of(context).size.height*0.3,
              //     //                     color: Colors.white,
              //     //                     child: ListView.builder(
              //     //                       padding: const EdgeInsets.all(10.0),
              //     //                       itemCount: options.length,
              //     //                       itemBuilder: (BuildContext context, int index) {
              //     //                         final String option = options.elementAt(index);
              //     //
              //     //                         return GestureDetector(
              //     //                           onTap: () {
              //     //                             onSelected(option);
              //     //                           },
              //     //                           child: Container(
              //     //                             color: Colors.white,
              //     //                             height: 50,
              //     //                             width: MediaQuery.of(context).size.width*0.86,
              //     //                             child: Column(
              //     //                                 crossAxisAlignment:
              //     //                                 CrossAxisAlignment.start,
              //     //                                 children: [
              //     //                                   Text(option,
              //     //                                       style: const TextStyle(
              //     //                                           fontWeight: FontWeight.bold)),
              //     //                                   const SizedBox(height: 10)
              //     //                                 ]),
              //     //                           ),
              //     //                         );
              //     //                       },
              //     //                     ),
              //     //                   ),
              //     //                 ),
              //     //               );
              //     //             },
              //     //           );
              //     //         }
              //     //     )
              //     // ):
              //     from=="DISTRICT_LEVEL"?
              //     Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
              //         child: Consumer<MainProvider>(
              //             builder: (context,value,child) {
              //               return Autocomplete<String>(
              //                 optionsBuilder: (TextEditingValue textEditingValue) {
              //                   return (value.assemblyList)
              //                       .where((String item) => item.toLowerCase()
              //                       .contains(textEditingValue.text.toLowerCase())).toList();
              //                 },
              //                 displayStringForOption: (String option) => option,
              //                 fieldViewBuilder: (
              //                     BuildContext context,
              //                     TextEditingController fieldTextEditingController,
              //                     FocusNode fieldFocusNode,
              //                     VoidCallback onFieldSubmitted
              //                     ) {
              //
              //                   return TextFormField(
              //                     maxLines: null,
              //                     textAlign: TextAlign.center,
              //                     decoration: InputDecoration(
              //                       contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
              //                       hintStyle:  TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w400,fontSize: 13,fontFamily: "Poppins"),
              //                       fillColor: Colors.white,
              //                       filled: true,
              //                       border: OutlineInputBorder(
              //                         borderRadius: BorderRadius.circular(30),
              //                         borderSide: const BorderSide(
              //                           color: Colors.black38,width: 0.5,
              //                         ), ),
              //                       focusedBorder: OutlineInputBorder(
              //                           borderRadius: BorderRadius.circular(30),
              //                           borderSide:  BorderSide(
              //                             color: myGreen,width: 1,)),
              //                       enabledBorder: OutlineInputBorder(
              //                         borderRadius: BorderRadius.circular(30),
              //                         borderSide: const BorderSide(
              //                           color: Colors.black38,
              //                           width: 0.5,
              //                         ),
              //                       ),
              //                       hintText: "Assembly",
              //                       // suffixIcon: const Icon(
              //                       //   Icons.keyboard_arrow_down_sharp,
              //                       //   size: 25,
              //                       //   color: Colors.black38,
              //                       // ),
              //                     ),
              //                     validator: (value2) {
              //                       if (value2!.trim().isEmpty) {
              //                         return "Field is required";
              //                       } else {
              //                         return null;
              //                       }
              //                     },
              //                     onChanged: (txt) {
              //                       // value.memberUnit.text= txt;
              //                     },
              //                     controller: fieldTextEditingController,
              //                     focusNode: fieldFocusNode,
              //                   );
              //                 },
              //                 onSelected: (String selection) {
              //                   value.coordinatorAssembly.text= selection;
              //                 },
              //                 optionsViewBuilder: (
              //                     BuildContext context,
              //                     AutocompleteOnSelected<String> onSelected,
              //                     Iterable<String> options
              //                     ) {
              //                   return Align(
              //                     alignment: Alignment.topLeft,
              //                     child: Material(
              //                       child: Container(
              //                         width: MediaQuery.of(context).size.width/1.5,
              //                         height: 200,
              //                         color: Colors.white,
              //                         child: ListView.builder(
              //                           padding: const EdgeInsets.all(10.0),
              //                           itemCount: options.length,
              //                           itemBuilder: (BuildContext context, int index) {
              //                             final String option = options.elementAt(index);
              //
              //                             return GestureDetector(
              //                               onTap: () {
              //                                 onSelected(option);
              //                               },
              //                               child:  SizedBox(
              //                                 height: 50,
              //                                 child: Column(
              //                                     crossAxisAlignment:
              //                                     CrossAxisAlignment.start,
              //                                     children: [
              //                                       Text(option,
              //                                           style: const TextStyle(
              //                                               fontWeight: FontWeight.bold)),
              //
              //                                     ]),
              //                               ),
              //                             );
              //                           },
              //                         ),
              //                       ),
              //                     ),
              //                   );
              //                 },
              //               );
              //             }
              //         )
              //     ):
              //     from=="STATE_LEVEL"?
              //     Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
              //         child: Consumer<MainProvider>(
              //             builder: (context,value,child) {
              //               return Autocomplete<String>(
              //                 optionsBuilder: (TextEditingValue textEditingValue) {
              //                   return (value.districtList)
              //                       .where((String item) => item.toLowerCase()
              //                       .contains(textEditingValue.text.toLowerCase())).toList();
              //                 },
              //                 displayStringForOption: (String option) => option,
              //                 fieldViewBuilder: (
              //                     BuildContext context,
              //                     TextEditingController fieldTextEditingController,
              //                     FocusNode fieldFocusNode,
              //                     VoidCallback onFieldSubmitted
              //                     ) {
              //
              //                   return TextFormField(
              //                     maxLines: null,
              //                     textAlign: TextAlign.center,
              //                     decoration: InputDecoration(
              //                       contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
              //                       hintStyle:  TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w400,fontSize: 13,fontFamily: "Poppins"),
              //                       fillColor: Colors.white,
              //                       filled: true,
              //                       border: OutlineInputBorder(
              //                         borderRadius: BorderRadius.circular(30),
              //                         borderSide: const BorderSide(
              //                           color: Colors.black38,width: 0.5,
              //                         ), ),
              //                       focusedBorder: OutlineInputBorder(
              //                           borderRadius: BorderRadius.circular(30),
              //                           borderSide:  BorderSide(
              //                             color: myGreen,width: 1,)),
              //                       enabledBorder: OutlineInputBorder(
              //                         borderRadius: BorderRadius.circular(30),
              //                         borderSide: const BorderSide(
              //                           color: Colors.black38,
              //                           width: 0.5,
              //                         ),
              //                       ),
              //                       hintText: "District",
              //                       // suffixIcon: const Icon(
              //                       //   Icons.keyboard_arrow_down_sharp,
              //                       //   size: 25,
              //                       //   color: Colors.black38,
              //                       // ),
              //                     ),
              //                     validator: (value2) {
              //                       if (value2!.trim().isEmpty) {
              //                         return "Field is required";
              //                       } else {
              //                         return null;
              //                       }
              //                     },
              //                     onChanged: (txt) {
              //                       // value.memberUnit.text= txt;
              //                     },
              //                     controller: fieldTextEditingController,
              //                     focusNode: fieldFocusNode,
              //                   );
              //                 },
              //                 onSelected: (String selection) {
              //                  value.coordinatorDistrict.text= selection;
              //                 },
              //                 optionsViewBuilder: (
              //                     BuildContext context,
              //                     AutocompleteOnSelected<String> onSelected,
              //                     Iterable<String> options
              //                     ) {
              //                   return Align(
              //                     alignment: Alignment.topLeft,
              //                     child: Material(
              //                       child: Container(
              //                         width: MediaQuery.of(context).size.width/1.2,
              //                         height: 200,
              //                         color: Colors.white,
              //                         child: ListView.builder(
              //                           shrinkWrap: true,
              //                           padding: const EdgeInsets.all(10.0),
              //                           itemCount: options.length,
              //                           itemBuilder: (BuildContext context, int index) {
              //                             final String option = options.elementAt(index);
              //
              //                             return GestureDetector(
              //                               onTap: () {
              //                                 onSelected(option);
              //                               },
              //                               child:  SizedBox(
              //                                 height: 50,
              //                                 child: Column(
              //                                     crossAxisAlignment:
              //                                     CrossAxisAlignment.start,
              //                                     children: [
              //                                       Text(option,
              //                                           style: const TextStyle(
              //                                               fontWeight: FontWeight.bold)),
              //
              //                                     ]),
              //                               ),
              //                             );
              //                           },
              //                         ),
              //                       ),
              //                     ),
              //                   );
              //                 },
              //               );
              //             }
              //         )
              //     ):
              //     Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
              //         child: Consumer<MainProvider>(
              //             builder: (context,value,child) {
              //               return Autocomplete<String>(
              //                 optionsBuilder: (TextEditingValue textEditingValue) {
              //                   return value.stateList
              //                       .where((String item) => item
              //                       .toLowerCase()
              //                       .contains(textEditingValue.text.toLowerCase()))
              //                       .toList();
              //                 },
              //                 displayStringForOption: (String option) => option,
              //                 fieldViewBuilder: (BuildContext context,
              //                     TextEditingController fieldTextEditingController,
              //                     FocusNode fieldFocusNode,
              //                     VoidCallback onFieldSubmitted) {
              //                   WidgetsBinding.instance.addPostFrameCallback((_) {
              //                     fieldTextEditingController.text = value.coordinatorState.text;
              //                   });
              //
              //                   return SizedBox(
              //                     child: TextFormField(
              //                       maxLines: null,
              //                       textAlign: TextAlign.center,
              //                       decoration: InputDecoration(
              //                         contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
              //                         hintStyle:  TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w400,fontSize: 13,fontFamily: "Poppins"),
              //                         fillColor: Colors.white,
              //                         filled: true,
              //                         border: OutlineInputBorder(
              //                           borderRadius: BorderRadius.circular(30),
              //                           borderSide: const BorderSide(
              //                             color: Colors.black38,width: 0.5,
              //                           ), ),
              //                         focusedBorder: OutlineInputBorder(
              //                             borderRadius: BorderRadius.circular(30),
              //                             borderSide:  BorderSide(
              //                               color: myGreen,width: 1,)),
              //                         enabledBorder: OutlineInputBorder(
              //                           borderRadius: BorderRadius.circular(30),
              //                           borderSide: const BorderSide(
              //                             color: Colors.black38,
              //                             width: 0.5,
              //                           ),
              //                         ),
              //                         hintText: "State",
              //                         // suffixIcon: const Icon(
              //                         //   Icons.keyboard_arrow_down_sharp,
              //                         //   size: 25,
              //                         //   color: Colors.black38,
              //                         // ),
              //                       ),
              //                       validator: (value2) {
              //                         if (value2!.trim().isEmpty) {
              //                           return "Field is required";
              //                         } else {
              //                           return null;
              //                         }
              //                       },
              //                       onChanged: (txt) {
              //                         // value.memberUnit.text= txt;
              //                       },
              //                       controller: fieldTextEditingController,
              //                       focusNode: fieldFocusNode,
              //                     ),
              //                   );
              //                 },
              //
              //                 onSelected: (String selection) {
              //                   value.coordinatorState.text= selection;
              //                   print(selection+"rriiiiiiiiii");
              //                   print(value.coordinatorState.text.toString()+"ooooooooooppp");
              //
              //                 },
              //                 optionsViewBuilder: (BuildContext context,
              //                     AutocompleteOnSelected<String> onSelected,
              //                     Iterable<String> options) {
              //                   return Align(
              //                     alignment: Alignment.topLeft,
              //                     child: Material(
              //                       child: Container(
              //                         width:  MediaQuery.of(context).size.width*0.86,
              //                         height: MediaQuery.of(context).size.height*0.3,
              //                         color: Colors.white,
              //                         child: ListView.builder(
              //                           padding: const EdgeInsets.all(10.0),
              //                           itemCount: options.length,
              //                           itemBuilder: (BuildContext context, int index) {
              //                             final String option = options.elementAt(index);
              //
              //                             return GestureDetector(
              //                               onTap: () {
              //                                 onSelected(option);
              //                               },
              //                               child: Container(
              //                                 color: Colors.white,
              //                                 height: 50,
              //                                 width: MediaQuery.of(context).size.width*0.86,
              //                                 child: Column(
              //                                     crossAxisAlignment:
              //                                     CrossAxisAlignment.start,
              //                                     children: [
              //                                       Text(option,
              //                                           style: const TextStyle(
              //                                               fontWeight: FontWeight.bold)),
              //                                       const SizedBox(height: 10)
              //                                     ]),
              //                               ),
              //                             );
              //                           },
              //                         ),
              //                       ),
              //                     ),
              //                   );
              //                 },
              //               );
              //             }
              //         )
              //     )
              //   ],
              // ),

              const SizedBox(height: 50,),

              Consumer<MainProvider>(
                builder: (context,value,child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: ()  async {
                          final FormState? form = formKey.currentState;
                          if(form!.validate() ) {
                            if(type == ''){
                              providerValue.addCoordinator(from,state,district,assembly,unit,context,'','',uId);
                            }else{
                              providerValue.addCoordinator(from,state,district,assembly,unit,context,'Edit',coordId,uId);

                            }

                          }

                        },
                        child: value.coordinatorLoader?
                        CircularProgressIndicator(color: myDarkGreen,):Container(
                          width: width/2.5,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: myGreen,borderRadius: BorderRadius.circular(30)
                          ),
                          child:const Center(
                            child: Text(
                              // providerValue.indextab == 1?"Register" :"Next" ,
                              "Save",
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              ),
              const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
