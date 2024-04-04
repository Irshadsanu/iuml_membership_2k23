import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Models/panchayath_model.dart';
import '../constants/my_colors.dart';
import '../constants/my_text.dart';
import '../providers/Main_Provider.dart';
import '../state_model.dart';

class RequestProfileDataScreen extends StatelessWidget {
  const RequestProfileDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context,listen: false);

    var width=MediaQuery.of(context).size.width;
    var hieght=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: hieght/6.8,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))),
        flexibleSpace:Container(
          height: hieght/5.5,
          width: width,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
              image: DecorationImage(image: AssetImage("assets/Background_Iuml.png"),
                  fit: BoxFit.fill)
          ),
          child: SafeArea(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal:width/13 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Welcome to",style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold)),
                      Text("IUML",style: TextStyle(fontFamily: "Coolvetica",
                          fontSize: 52,color: Colors.white ),),
                    ],
                  ),
                  Image.asset("assets/ladder.png",scale: 8,)
                ],
              ),
            ),
          ),
        ),
      ),
      body: Consumer<MainProvider>(
          builder: (context,providerValue,child) {
            return SingleChildScrollView(
              child: Column(
                children: [


                  Center(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: hieght/90),
                      child:  Text("Add New Member",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: myBlack,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              letterSpacing: 0.33
                          )),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: hieght/46),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 61,
                          backgroundColor: Colors.grey.shade300,

                        ),
                        Positioned(
                          top: 1,
                          left: 1,
                          child:providerValue.fileimage != null ?
                          CircleAvatar(
                            radius: 60,
                            backgroundImage:
                            FileImage(providerValue.fileimage!),
                          )
                              :providerValue.imageUrl!=""?CircleAvatar(
                            radius: 60,
                            backgroundImage:
                            NetworkImage(providerValue.imageUrl),
                          )
                              :CircleAvatar(
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
                              // providerValue.showBottomSheet(context);
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: myGreen,
                              child:  Icon(Icons.add,color: myWhite,),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),





                  // widget.idStatus=="WITH ID"?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                    child: TextFormField(
                      maxLines: 1,
                      // controller: providerValue.memberVoterId,
                      controller: providerValue.TypeIdCt,
                      textAlign: TextAlign.center,
                      enabled: false,
                      decoration: InputDecoration(
                        contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle:  TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w400,fontSize: 13,fontFamily: "Poppins"),
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
                        hintText: "Enter ID Card number",

                      ),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "This Field is Required";
                        }
                        return null;
                      },
                    ),
                  ),
                  // :SizedBox(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    width: width,
                    // height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: providerValue.voterfileImage != null?
                    Padding(padding: EdgeInsets.symmetric(horizontal: width/8),
                        child: Image.file(providerValue.voterfileImage!,)) :
                    providerValue.imageUrl1 != ''?
                    Padding(padding: EdgeInsets.symmetric(horizontal: width/8),
                        child: Image.network(providerValue.imageUrl1,)):
                    Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/IdCard.png",scale: 2,),
                            Text("Upload your ID Proof",
                                style: TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w400,fontSize: 13,fontFamily: "Poppins")),
                            InkWell(
                              onTap: (){
                                // providerValue.showBottomSheet1(context);
                              },
                              child: Container(
                                height: 22,
                                width: 84,
                                margin: const EdgeInsets.symmetric(horizontal: 18,vertical: 30),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(81),
                                    border: Border.all(color:myDarkGreen )
                                ),
                                child:  Center(
                                  child: Text("Click Here",
                                    style: TextStyle(
                                        color: myDarkGreen,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: "PoppinsMedium",
                                        letterSpacing: 0.39
                                    ),),
                                ),
                              ),
                            ),

                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                    child: TextFormField(
                      maxLines: null,
                      controller: providerValue.memberName,
                      textAlign: TextAlign.center,
                      enabled: false,
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
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      controller: providerValue.memberPhoneNumber,
                      decoration: InputDecoration(
                        enabled: false,
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
                      enabled: false,
                      controller: providerValue.memberAddress,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      maxLines: null,
                      controller: providerValue.memberPincode,
                      keyboardType: TextInputType.number,
                      enabled: false,
                      inputFormatters: [LengthLimitingTextInputFormatter(6),],
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
                        hintText: "Pin code",

                      ),

                    ),
                  ),
                  Consumer<MainProvider>(
                      builder: (context, values, child) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                          child: Container(
                            width: width * 0.9,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              enabled: false,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintStyle:  TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w500,fontSize: 14,fontFamily: "Poppins"),
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
                                hintText: '${values.day}/${values.month}/${values.year}',

                              ),
                            ),
                            // DropdownDatePicker(
                            //   inputDecoration: InputDecoration(
                            //     enabled: false,
                            //     contentPadding:const EdgeInsets.symmetric(vertical: 14),
                            //     fillColor: Colors.white,
                            //     filled: true,
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(20),
                            //       borderSide: const BorderSide(
                            //         color: Colors.black38,width: 0.5,
                            //       ), ),
                            //     focusedBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(20),
                            //         borderSide:  BorderSide(
                            //           color: myGreen,width: 1,)),
                            //     enabledBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(20),
                            //       borderSide: const BorderSide(
                            //         color: Colors.black38,
                            //         width: 0.5,
                            //       ),
                            //     ),),
                            //   // monthFlex: 1,
                            //   // yearFlex: 1,
                            //   hintTextStyle:  const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14,fontFamily: "Poppins"),
                            //   hintDay: values.day,
                            //   hintMonth: values.month,
                            //   hintYear: values.year,
                            //   isExpanded: true,
                            //   isDropdownHideUnderline: true,
                            //   isFormValidator: false,
                            //   startYear: 1900,
                            //   endYear: 2020,
                            //   width: 2,
                            //   textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 13,fontFamily: "Poppins"),
                            //   // onChangedDay: (value) => values.day = value!,
                            //   // onChangedMonth: (value) => values.month = value!,
                            //   // onChangedYear: (value) => values.year = value!,
                            //
                            // ),
                          ),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: width/2.2,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey,),
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Center(child: Text("Gender",
                            style: TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w400,fontSize: 13,fontFamily: "Poppins"),)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: (){
                                  // providerValue.gender = "Male";
                                  // providerValue.notifyListeners();
                                },
                                child: Text("Male",style:  TextStyle(fontSize: 13),)
                            ),

                            Transform.scale(
                              scale: 1.3,
                              child: Radio(
                                splashRadius: 2,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                visualDensity: const VisualDensity(horizontal: -2, vertical: 2),
                                // activeColor: cl_493058,
                                value: "Male",
                                activeColor: myGreen,
                                groupValue: providerValue.gender,
                                onChanged: (value){
                                  // providerValue.gender = value.toString();
                                  // providerValue.notifyListeners();
                                },
                              ),
                            ),

                            InkWell(
                                onTap: (){
                                  // providerValue.gender = "Female";
                                  // providerValue.notifyListeners();
                                },
                                child: const Text("Female",style:  TextStyle(fontSize:13))
                            ),
                            Transform.scale(
                              scale: 1.3,
                              child: Radio(
                                splashRadius: 8,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                // activeColor: cl_493058,
                                value: "Female",
                                activeColor: myGreen,
                                groupValue:providerValue.gender,
                                visualDensity:  VisualDensity(horizontal: -2, vertical: 2),
                                onChanged: (value){
                                  // providerValue.gender = value.toString();
                                  // providerValue.notifyListeners();
                                },
                              ),
                            ),



                          ],
                        ),
                      ],
                    ),
                  ),

                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                      child: Consumer<MainProvider>(
                          builder: (context,value,child) {
                            return autocomplete2(context,value.professionList,value.memberProfession,"Profession","Select Profession");
                          }
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                      child: Consumer<MainProvider>(
                          builder: (context,value,child) {
                            return autocomplete2(context,value.educationList,value.memberEducation,"Education","Select Education");
                          }
                      )
                  ),

                  Column(
                    children: [

                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                          child: Consumer<MainProvider>(
                              builder: (context,value,child) {
                                return SizedBox(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: value.memberAssembly,
                                    enabled: false,
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
                                      hintText: "Assembly",

                                    ),
                                    validator: (value2) {
                                      if (value2!.trim().isEmpty || !value.allStateDistrictAssemblyList.map((item) => item.assembly).contains(value2)) {
                                        return "Please Select Your Assembly";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                );
                              }
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                          child: Consumer<MainProvider>(
                              builder: (context,value,child) {
                                return SizedBox(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: value.memberUnit,
                                    maxLines: null,
                                    enabled: false,
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
                                      hintText: "Unit",

                                    ),
                                    validator: (value2) {
                                      if (value2!.trim().isEmpty) {
                                        return "Field is required";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                );
                              }
                          )
                      ),
                    ],
                  ),


                  const SizedBox(height: 50,),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Consumer<MainProvider>(
                  //         builder: (context,value,child) {
                  //           return InkWell(
                  //             onTap: () async {
                  //
                  //             },
                  //             child: Container(
                  //               width: 150,
                  //               height: 50,
                  //               margin: const EdgeInsets.symmetric(horizontal: 20),
                  //               decoration: BoxDecoration(
                  //                   color: clFF7070,borderRadius: BorderRadius.circular(30)
                  //               ),
                  //               child:const Center(
                  //                 child: Text(
                  //                   "Reject",
                  //                   style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  //               ),
                  //             ),
                  //           );
                  //         }
                  //     ),
                  //     Consumer<MainProvider>(
                  //         builder: (context,value,child) {
                  //           return InkWell(
                  //             onTap: () async {
                  //               mainProvider.acceptRequest(,uId,item.name,item.phone,item.state,item.district,item.assembly,item.unit);
                  //
                  //             },
                  //             child: Container(
                  //               width: 150,
                  //               height: 50,
                  //               margin: const EdgeInsets.symmetric(horizontal: 20),
                  //               decoration: BoxDecoration(
                  //                   color: cl02B100,borderRadius: BorderRadius.circular(30)
                  //               ),
                  //               child:const Center(
                  //                 child: Text(
                  //                   "Approve",
                  //                   style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  //               ),
                  //             ),
                  //           );
                  //         }
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 80,),
                ],
              ),
            );
          }
      ),
    );
  }
}
