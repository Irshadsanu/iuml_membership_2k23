import 'dart:io';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iuml_membership/Models/panchayath_model.dart';
import 'package:iuml_membership/Screens/bottom_navigation.dart';
import 'package:iuml_membership/Screens/payment_gateway.dart';
import 'package:iuml_membership/providers/Main_Provider.dart';
import 'package:provider/provider.dart';
import '../Constants/my_functions.dart';
import '../constants/my_colors.dart';
import '../constants/my_text.dart';
import '../providers/donation_provider.dart';
import '../state_model.dart';
import 'home_screen.dart';
import 'newPaymentGatewayScreen.dart';

class AddNewMember extends StatefulWidget {
  String from;
  String state;
  String district;
  String assembly;
  String unit;
  String uid;
  String idStatus;
  String proffetion;
  String photo;
  String address;
  String type;
  String MemberId;
  String userName;
  String paymentStatus;
  String loginLevel;
   AddNewMember({super.key,required this.from,required this.state,required this.district,
     required this.assembly,required this.unit,required this.uid,
     required this.idStatus,required this.proffetion,required this.photo,required this.address,
     required this.type,required this.MemberId,required this.userName,required this.paymentStatus,required this.loginLevel});

  @override
  State<AddNewMember> createState() => _AddNewMemberState();
}

class _AddNewMemberState extends State<AddNewMember> with TickerProviderStateMixin{
  late TabController _tabController;
  final  _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    MainProvider providerValue = Provider.of<MainProvider>(context,listen: false);
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
      backgroundColor: widget.from=="Request"?clFDFDFD:myWhite,
      body: Consumer<MainProvider>(
        builder: (context2,providerValue,child) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [

                  widget.from=="Request"? Center(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: hieght/75),
                      child:  Text("Please fill the request form ",
                          style: TextStyle(
                              color: myDarkGreen,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            letterSpacing: 0.33
                          )),
                    ),
                  ):
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

                  // TabBar(
                  //   controller: _tabController,
                  //     padding: EdgeInsets.symmetric(horizontal: width/45),
                  //  labelPadding: EdgeInsets.zero,
                  //  labelColor: myGreen,
                  //  unselectedLabelColor: Colors.black,
                  //  indicatorColor: myGreen,
                  //     onTap: (value) {
                  //      providerValue.tabIndex(value);
                  //     },
                  //     tabs: [
                  //   Tab(
                  //     child: Container(
                  //     color: providerValue.indextab == 0 ? Colors.white:Colors.transparent,
                  //     width: width/2,
                  //     height: hieght/20,
                  //     child: const Center(child: Text("Personal Details",)),
                  //   ),),
                  //   Tab(child: Container(
                  //     color:providerValue.indextab == 1 ? Colors.white:Colors.transparent,
                  //     width: width/2,
                  //     height: hieght/20,
                  //     child: const Center(child: Text("Other Details",)),
                  //   ),)
                  // ]),

                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: hieght/45),
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
                                Text("Photo",style: TextStyle(color: Colors.grey,fontSize: 14))
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
                              child:  Icon(Icons.add,color: myWhite,),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),



                  // widget.idStatus=="WITH ID"?
                  Consumer<MainProvider>(
                    builder: (context,val,child) {
                      return widget.idStatus=="WITH ID"?
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                            child: TextFormField(
                              maxLines: 1,
                              // controller: providerValue.memberVoterId,
                              controller: providerValue.TypeIdCt,
                              textAlign: TextAlign.center,
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
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            width: width,
                            // height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: cl4D4D4D,width: 0.2),
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
                                        providerValue.showBottomSheet1(context);
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
                        ],
                      )
                          :SizedBox();
                    }
                  ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                child: TextFormField(
                maxLines: null,
                  controller: providerValue.memberName,
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.characters,
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



                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  //   child: TextFormField(
                  //     maxLines: null,
                  //     controller: providerValue.TypeIdCt,
                  //     decoration: InputDecoration(
                  //       contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
                  //       fillColor: Colors.white,
                  //       filled: true,
                  //       hintStyle: const TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(30),
                  //          borderSide: const BorderSide(
                  //           color: Colors.black38,width: 0.5,
                  //     ), ),
                  //       focusedBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(30),
                  //           borderSide:  BorderSide(
                  //             color: myGreen,width: 1,)),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(30),
                  //         borderSide: const BorderSide(
                  //           color: Colors.black38,
                  //           width: 0.5,
                  //         ),
                  //       ),
                  //       hintText: "ID",
                  //
                  //     ),
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return "This Field is Required";
                  //       }
                  //
                  //       return null;
                  //     },
                  //   ),
                  // ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  controller: providerValue.memberPhoneNumber,
                  decoration: InputDecoration(
                    enabled: widget.type=="Edit"||widget.idStatus=="WITH PHONE"?false:true,
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
                      hintText: "Phone  ",

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
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    UpperCaseTextFormatter()
                  ],
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
                      textCapitalization: TextCapitalization.characters,
                      controller: providerValue.memberPincode,
                      keyboardType: TextInputType.number,
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
                      // validator: (value) {
                      //   if (value!.trim().isEmpty) {
                      //     return "This Field is Required";
                      //   }
                      //
                      //   return null;
                      // },
                    ),
                  ),
                  Consumer<MainProvider>(
                      builder: (context, values, child) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                          child: Container(
                            width: width * 0.9,
                            child: DropdownDatePicker(
                              inputDecoration: InputDecoration(
                                enabled: widget.type=="Edit"?false:true,
                                contentPadding:const EdgeInsets.symmetric(vertical: 14),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:  BorderSide(
                                      color: cl4D4D4D,width: 0.2
                                  ), ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:  BorderSide(
                                      color: myGreen,width: 1,)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:  BorderSide(
                                      color: cl4D4D4D,width: 0.2
                                  ),
                                ),),
                              // monthFlex: 1,
                              // yearFlex: 1,
                              hintTextStyle:  const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14,fontFamily: "Poppins"),
                              hintDay: values.day,
                              hintMonth: values.month,
                              hintYear: values.year,
                              isExpanded: true,
                              isDropdownHideUnderline: true,
                              isFormValidator: false,
                              startYear: 1900,
                              endYear: 2020,
                              width: 2,
                              textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 13,fontFamily: "Poppins"),
                              onChangedDay: (value) => values.day = value!,
                              onChangedMonth: (value) => values.month = value!,
                              onChangedYear: (value) => values.year = value!,

                            ),
                          ),
                        );
                      }),
               // Row(
               //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               //   children: [
               //     Padding(
               //       padding: const EdgeInsets.symmetric(vertical: 8),
               //       child: InkWell(
               //         onTap: (){
               //           providerValue.selectDOB(context);
               //         },
               //         child: Container(
               //           width: width/2.2,
               //           height: 50,
               //           decoration: BoxDecoration(
               //               color: Colors.white,
               //               border: Border.all(color: Colors.grey,),
               //               borderRadius: BorderRadius.circular(25)
               //           ),
               //           child: Center(child: Text(providerValue.memberAge != 0 ?"AGE : " +providerValue.memberAge.toString():"Date of Birth",
               //           style: TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w400,fontSize: 13,fontFamily: "Poppins"),)),
               //         ),
               //       ),
               //     ),
               //     Text('${providerValue.day}/${providerValue.month}/${providerValue.year}',style: TextStyle(color: myBlack)),
               //     InkWell(
               //         onTap: (){
               //           providerValue.selectDOB(context);
               //         },
               //         child: Icon(Icons.calendar_month_outlined,color: myDarkGreen,size: 28,))
               //   ],
               // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      // InkWell(
                      //   onTap: () {
                      //     providerValue.selectDOB(context);
                      //   },
                      //   child: Container(
                      //     width: width/2.2,
                      //     height: 50,
                      //
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //     border: Border.all(color: Colors.grey,),
                      //     borderRadius: BorderRadius.circular(25)
                      //   ),
                      //   child: Padding(
                      //     padding:  EdgeInsets.symmetric(horizontal: 15),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //       children: [
                      //          Text(providerValue.day,style: TextStyle(color: myBlack)),
                      //         Container(height: 22,width: 1,color: myGreen,),
                      //          Text(providerValue.month,style: TextStyle(color: myBlack)),
                      //         Container(height: 22,width: 1,color: myGreen,),
                      //          Text(providerValue.year,style: TextStyle(color: myBlack)),
                      //       ],
                      //     ),
                      //   ),
                      //   ),
                      // ),
                    Container(
                      width: width/2.2,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: cl4D4D4D,width: 0.2),
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
                              providerValue.gender = "Male";
                              providerValue.notifyListeners();
                            },
                            child: Text("Male",style:  TextStyle(fontSize: 13),)
                        ),

                        Transform.scale(
                          scale: 1.2,
                          child: Radio(
                            splashRadius: 2,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: const VisualDensity(horizontal: -2, vertical: 2),
                            // activeColor: cl_493058,
                            value: "Male",
                            activeColor: myGreen,
                            groupValue: providerValue.gender,
                            onChanged: (value){
                              providerValue.gender = value.toString();
                              providerValue.notifyListeners();
                            },
                          ),
                        ),

                        InkWell(
                            onTap: (){
                              providerValue.gender = "Female";
                              providerValue.notifyListeners();
                            },
                            child: const Text("Female",style:  TextStyle(fontSize:13))
                        ),
                        Transform.scale(
                           scale: 1.2,
                          child: Radio(
                            splashRadius: 8,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            // activeColor: cl_493058,
                            value: "Female",
                            activeColor: myGreen,
                            groupValue:providerValue.gender,
                            visualDensity:  VisualDensity(horizontal: -2, vertical: 2),
                            onChanged: (value){
                              providerValue.gender = value.toString();
                              providerValue.notifyListeners();
                            },
                          ),
                        ),



                      ],
                    ),
                  ],
                ),
              ),

              //     Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              //   child: TextFormField(
              //   maxLines: null,
              //     controller: providerValue.memberProfession,
              //     decoration: InputDecoration(
              //       fillColor: Colors.white,
              //       filled: true,
              //           hintStyle: const TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(30),
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(30),
              //               borderSide:  BorderSide(
              //                   color: myGreen,)),
              //           enabledBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(30),
              //             borderSide: const BorderSide(
              //               color: Colors.black38,
              //             ),
              //           ),
              //         hintText: "Profession",
              //
              //          ),
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return "This Field is Required";
              //       }
              //
              //       return null;
              //     },
              //   ),
              // ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                      child: Consumer<MainProvider>(
                          builder: (context,value,child) {
                            return autocomplete(context,value.professionList,value.memberProfession,"Profession","Select Profession");
                          }
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                      child: Consumer<MainProvider>(
                          builder: (context,value,child) {
                            return autocomplete(context,value.educationList,value.memberEducation,"Education","Select Education");
                          }
                      )
                  ),


                 widget.from=="Request"?
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 15),
                          child: Text("Which unit you need to register ",
                          style: TextStyle(
                            color: cl303030,
                            fontFamily: "Poppins",
                            fontSize: 14
                          ),),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                          child: Consumer<MainProvider>(
                              builder: (context,value,child) {
                                return Autocomplete<StateModel>(
                                  optionsBuilder: (TextEditingValue textEditingValue) {
                                    return value.allStateDistrictAssemblyList
                                        .where((StateModel item) => item.assembly
                                        .toLowerCase()
                                        .contains(textEditingValue.text.toLowerCase()))
                                        .toList();
                                  },
                                  displayStringForOption: (StateModel option) => option.assembly,
                                  fieldViewBuilder: (BuildContext context,
                                      TextEditingController fieldTextEditingController,
                                      FocusNode fieldFocusNode,
                                      VoidCallback onFieldSubmitted) {
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      fieldTextEditingController.text = value.memberAssembly.text;
                                    });

                                    return SizedBox(
                                      child: TextFormField(
                                        maxLines: null,
                                        inputFormatters: [
                                          UpperCaseTextFormatter()
                                        ],
                                        decoration: InputDecoration(
                                          contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
                                          hintStyle:  TextStyle(color: myBlack.withOpacity(0.6),fontFamily: "PoppinsMedium",fontSize: 13,fontWeight: FontWeight.bold),
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
                                          enabledBorder: UnderlineInputBorder(
                                            // borderRadius: BorderRadius.circular(30),
                                            borderSide: BorderSide(width:2, color: clDDDDDD,
                                            ),
                                          ),
                                          hintText: "Assembly",
                                          suffixIcon: const Icon(
                                            Icons.keyboard_arrow_down_sharp,
                                            size: 25,
                                            color: Colors.black38,
                                          ),
                                        ),
                                        validator: (value2) {
                                          if (value2!.trim().isEmpty || !value.allStateDistrictAssemblyList.map((item) => item.assembly).contains(value2)) {
                                            return "Please Select Your Assembly";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (txt) {

                                        },
                                        controller: fieldTextEditingController,
                                        focusNode: fieldFocusNode,
                                      ),
                                    );
                                  },

                                  onSelected: (StateModel selection) {
                                    value.memberAssembly.text=selection.assembly;
                                    value.requestMemberAssembly=selection.assembly;
                                    value.requestMemberDistrict=selection.district;
                                    value.requestMemberState=selection.state;
                                    // value.getAddedPanchayath(value.requestMemberState,value.requestMemberDistrict,value.requestMemberAssembly);
                                    value.getAddedUnit(value.requestMemberState,value.requestMemberDistrict,value.requestMemberAssembly);
                                  },
                                  optionsViewBuilder: (BuildContext context,
                                      AutocompleteOnSelected<StateModel> onSelected,
                                      Iterable<StateModel> options) {
                                    return Align(
                                      alignment: Alignment.topLeft,
                                      child: Material(
                                        child: Container(
                                          width:  MediaQuery.of(context).size.width*0.86,
                                          height: MediaQuery.of(context).size.height*0.3,
                                          color: Colors.white,
                                          child: ListView.builder(
                                            padding: const EdgeInsets.all(10.0),
                                            itemCount: options.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              final StateModel option = options.elementAt(index);

                                              return GestureDetector(
                                                onTap: () {
                                                  onSelected(option);
                                                },
                                                child: Container(
                                                  color: Colors.white,
                                                  height: 50,
                                                  width: MediaQuery.of(context).size.width*0.86,
                                                  child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(option.assembly,
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
                      // Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                      //     child: Consumer<MainProvider>(
                      //         builder: (context,value,child) {
                      //           return Autocomplete<PanchayathModel>(
                      //             optionsBuilder: (TextEditingValue textEditingValue) {
                      //               return value.selectPanchayathList
                      //                   .where((PanchayathModel item) => item.panchayath
                      //                   .toLowerCase()
                      //                   .contains(textEditingValue.text.toLowerCase()))
                      //                   .toList();
                      //             },
                      //             displayStringForOption: (PanchayathModel option) => option.panchayath,
                      //             fieldViewBuilder: (BuildContext context,
                      //                 TextEditingController fieldTextEditingController,
                      //                 FocusNode fieldFocusNode,
                      //                 VoidCallback onFieldSubmitted) {
                      //               WidgetsBinding.instance.addPostFrameCallback((_) {
                      //                 fieldTextEditingController.text = value.memberPanchayath.text;
                      //               });
                      //
                      //               return SizedBox(
                      //                 child: TextFormField(
                      //                   maxLines: null,
                      //                   decoration: InputDecoration(
                      //                     contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
                      //                     hintStyle:  TextStyle(color: myBlack.withOpacity(0.6),fontFamily: "PoppinsMedium",fontSize: 13,fontWeight: FontWeight.bold),
                      //                     fillColor: Colors.white,
                      //                     filled: true,
                      //                     border: UnderlineInputBorder(
                      //                       // borderRadius: BorderRadius.circular(30),
                      //                       borderSide: BorderSide(width: 2, color: clDDDDDD),
                      //                     ),
                      //                     focusedBorder: UnderlineInputBorder(
                      //                         borderRadius: BorderRadius.circular(30),
                      //                         borderSide:  BorderSide(
                      //                             color: myGreen,width: 2)),
                      //                     enabledBorder:  UnderlineInputBorder(
                      //                       // borderRadius: BorderRadius.circular(30),
                      //                       borderSide: BorderSide(width: 2, color: clDDDDDD),
                      //                     ),
                      //                     hintText: "Panchayath",
                      //                     suffixIcon: const Icon(
                      //                       Icons.keyboard_arrow_down_sharp,
                      //                       size: 25,
                      //                       color: Colors.black38,
                      //                     ),
                      //                   ),
                      //                   validator: (value2) {
                      //                     if (value2!.trim().isEmpty) {
                      //                       return "Field is required";
                      //                     } else {
                      //                       return null;
                      //                     }
                      //                   },
                      //                   onChanged: (txt) {
                      //                     value.memberPanchayath.text = txt;
                      //                   },
                      //                   controller: fieldTextEditingController,
                      //                   focusNode: fieldFocusNode,
                      //                 ),
                      //               );
                      //             },
                      //
                      //             onSelected: (PanchayathModel selection) {
                      //               value.memberPanchayath.text= selection.panchayath;
                      //               print( value.memberPanchayath.text.toString()+"yyyyyyy");
                      //               print(selection.panchayath+"e8eeue");
                      //               value.requestMemberPanchayath= value.memberPanchayath.text.toString();
                      //               // value.requestMemberAssembly=selection.assembly;
                      //               // value.requestMemberDistrict=selection.district;
                      //               // value.requestMemberState=selection.state;
                      //               value.getAddedUnit(value.requestMemberState,value.requestMemberDistrict,value.requestMemberAssembly,value.requestMemberPanchayath);
                      //             },
                      //             optionsViewBuilder: (BuildContext context,
                      //                 AutocompleteOnSelected<PanchayathModel> onSelected,
                      //                 Iterable<PanchayathModel> options) {
                      //               return Align(
                      //                 alignment: Alignment.topLeft,
                      //                 child: Material(
                      //                   child: Container(
                      //                     width:  MediaQuery.of(context).size.width*0.86,
                      //                     height: MediaQuery.of(context).size.height*0.3,
                      //                     color: Colors.white,
                      //                     child: ListView.builder(
                      //                       padding: const EdgeInsets.all(10.0),
                      //                       itemCount: options.length,
                      //                       itemBuilder: (BuildContext context, int index) {
                      //                         final PanchayathModel option = options.elementAt(index);
                      //
                      //                         return GestureDetector(
                      //                           onTap: () {
                      //                             onSelected(option);
                      //                           },
                      //                           child: Container(
                      //                             color: Colors.white,
                      //                             height: 50,
                      //                             width: MediaQuery.of(context).size.width*0.86,
                      //                             child: Column(
                      //                                 crossAxisAlignment:
                      //                                 CrossAxisAlignment.start,
                      //                                 children: [
                      //                                   Text(option.panchayath,
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
                      //           );
                      //         }
                      //     )
                      // ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                          child: Consumer<MainProvider>(
                              builder: (context,value,child) {
                                return Autocomplete<UnitModel>(
                                  optionsBuilder: (TextEditingValue textEditingValue) {
                                    return value.selectUnitList
                                        .where((UnitModel item) => item.unit
                                        .toLowerCase()
                                        .contains(textEditingValue.text.toLowerCase()))
                                        .toList();
                                  },
                                  displayStringForOption: (UnitModel option) => option.unit,
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
                                        inputFormatters: [
                                          UpperCaseTextFormatter()
                                        ],
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
                                          hintText: "Unit",
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

                                  onSelected: (UnitModel selection) {

                                    value.memberUnit.text= selection.unit;
                                    value.requestMemberUnit= value.memberUnit.text.toString();
                                    // value.requestMemberAssembly=selection.assembly;
                                    // value.requestMemberDistrict=selection.district;
                                    // value.requestMemberState=selection.state;
                                  },
                                  optionsViewBuilder: (BuildContext context,
                                      AutocompleteOnSelected<UnitModel> onSelected,
                                      Iterable<UnitModel> options) {
                                    return Align(
                                      alignment: Alignment.topLeft,
                                      child: Material(
                                        child: Container(
                                          width:  MediaQuery.of(context).size.width*0.86,
                                          height: MediaQuery.of(context).size.height*0.3,
                                          color: Colors.white,
                                          child: ListView.builder(
                                            padding: const EdgeInsets.all(10.0),
                                            itemCount: options.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              final UnitModel option = options.elementAt(index);

                                              return GestureDetector(
                                                onTap: () {
                                                  onSelected(option);
                                                },
                                                child: Container(
                                                  color: Colors.white,
                                                  height: 50,
                                                  width: MediaQuery.of(context).size.width*0.86,
                                                  child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(option.unit,
                                                            style: const TextStyle(
                                                                fontWeight: FontWeight.bold)),
                                                        const SizedBox(height: 10)
                                                      ]
                                                  ),
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
                    ],
                  ):SizedBox(),




                  // Expanded(
                  //   child:  TabBarView(
                  //     controller: _tabController,
                  //       children: [
                  //  //        SingleChildScrollView(
                  //  //          // physics: const NeverScrollableScrollPhysics(),
                  //  //          child: Column(
                  //  //            children: [
                  //  // widget.idStatus=="WITH ID"? Padding(
                  //  //    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  //  //    child: TextFormField(
                  //  //    maxLines: null,
                  //  //      controller: providerValue.memberVoterId,
                  //  //      decoration: InputDecoration(
                  //  //          fillColor: Colors.white,
                  //  //            filled: true,
                  //  //            hintStyle: const TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),
                  //  //            border: OutlineInputBorder(
                  //  //              borderRadius: BorderRadius.circular(30),
                  //  //            ),
                  //  //            focusedBorder: OutlineInputBorder(
                  //  //                borderRadius: BorderRadius.circular(30),
                  //  //                borderSide:  BorderSide(
                  //  //                    color: myGreen,)),
                  //  //            enabledBorder: OutlineInputBorder(
                  //  //              borderRadius: BorderRadius.circular(30),
                  //  //              borderSide: const BorderSide(
                  //  //                color: Colors.black38,
                  //  //              ),
                  //  //            ),
                  //  //          hintText: "Enter Voter ID number",
                  //  //           ),
                  //  //      validator: (value) {
                  //  //        if (value!.isEmpty) {
                  //  //          return "This Field is Required";
                  //  //        }
                  //  //
                  //  //        return null;
                  //  //      },
                  //  //    ),
                  //  //  ):SizedBox(),
                  //  //  Padding(
                  //  //    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  //  //    child: TextFormField(
                  //  //    maxLines: null,
                  //  //      controller: providerValue.memberName,
                  //  //      decoration: InputDecoration(
                  //  //          fillColor: Colors.white,
                  //  //          filled: true,
                  //  //            hintStyle: const TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),
                  //  //            border: OutlineInputBorder(
                  //  //              borderRadius: BorderRadius.circular(30),
                  //  //            ),
                  //  //            focusedBorder: OutlineInputBorder(
                  //  //                borderRadius: BorderRadius.circular(30),
                  //  //                borderSide:  BorderSide(
                  //  //                    color: myGreen,)),
                  //  //            enabledBorder: OutlineInputBorder(
                  //  //              borderRadius: BorderRadius.circular(30),
                  //  //              borderSide: const BorderSide(
                  //  //                color: Colors.black38,
                  //  //              ),
                  //  //            ),
                  //  //          hintText: "Enter Name",
                  //  //
                  //  //           ),
                  //  //      validator: (value) {
                  //  //        if (value!.isEmpty) {
                  //  //          return "This Field is Required";
                  //  //        }
                  //  //
                  //  //        return null;
                  //  //      },
                  //  //    ),
                  //  //  ),
                  //  //  Padding(
                  //  //    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  //  //    child: TextFormField(
                  //  //    maxLines: null,
                  //  //      controller: providerValue.memberHouseName,
                  //  //      decoration: InputDecoration(
                  //  //          fillColor: Colors.white,
                  //  //          filled: true,
                  //  //            hintStyle: const TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),
                  //  //            border: OutlineInputBorder(
                  //  //              borderRadius: BorderRadius.circular(30),
                  //  //            ),
                  //  //            focusedBorder: OutlineInputBorder(
                  //  //                borderRadius: BorderRadius.circular(30),
                  //  //                borderSide:  BorderSide(
                  //  //                    color: myGreen,)),
                  //  //            enabledBorder: OutlineInputBorder(
                  //  //              borderRadius: BorderRadius.circular(30),
                  //  //              borderSide: const BorderSide(
                  //  //                color: Colors.black38,
                  //  //              ),
                  //  //            ),
                  //  //          hintText: "House Name",
                  //  //
                  //  //           ),
                  //  //      validator: (value) {
                  //  //        if (value!.isEmpty) {
                  //  //          return "This Field is Required";
                  //  //        }
                  //  //
                  //  //        return null;
                  //  //      },
                  //  //    ),
                  //  //  ),
                  //  //  Padding(
                  //  //    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  //  //    child: TextFormField(
                  //  //      keyboardType: TextInputType.number,
                  //  //      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  //  //      controller: providerValue.memberPhoneNumber,
                  //  //      decoration: InputDecoration(
                  //  //          fillColor: Colors.white,
                  //  //          filled: true,
                  //  //            hintStyle: const TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),
                  //  //            border: OutlineInputBorder(
                  //  //              borderRadius: BorderRadius.circular(30),
                  //  //            ),
                  //  //            focusedBorder: OutlineInputBorder(
                  //  //                borderRadius: BorderRadius.circular(30),
                  //  //                borderSide:  BorderSide(
                  //  //                    color: myGreen,)),
                  //  //            enabledBorder: OutlineInputBorder(
                  //  //              borderRadius: BorderRadius.circular(30),
                  //  //              borderSide: const BorderSide(
                  //  //                color: Colors.black38,
                  //  //              ),
                  //  //            ),
                  //  //          hintText: "Phone Number",
                  //  //
                  //  //           ),
                  //  //      validator: (value) {
                  //  //        if (value!.isEmpty) {
                  //  //          return "This Field is Required";
                  //  //        }
                  //  //
                  //  //        return null;
                  //  //      },
                  //  //    ),
                  //  //  ),
                  //  //  Padding(
                  //  //    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  //  //    child: TextFormField(
                  //  //
                  //  //    maxLines: null,
                  //  //      controller: providerValue.memberAddress,
                  //  //      decoration: InputDecoration(
                  //  //          fillColor: Colors.white,
                  //  //          filled: true,
                  //  //            hintStyle: const TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),
                  //  //            border: OutlineInputBorder(
                  //  //              borderRadius: BorderRadius.circular(30),
                  //  //            ),
                  //  //            focusedBorder: OutlineInputBorder(
                  //  //                borderRadius: BorderRadius.circular(30),
                  //  //                borderSide:  BorderSide(
                  //  //                    color: myGreen,)),
                  //  //            enabledBorder: OutlineInputBorder(
                  //  //              borderRadius: BorderRadius.circular(30),
                  //  //              borderSide: const BorderSide(
                  //  //                color: Colors.black38,
                  //  //              ),
                  //  //            ),
                  //  //          hintText: "Address",
                  //  //
                  //  //           ),
                  //  //      validator: (value) {
                  //  //        if (value!.isEmpty) {
                  //  //          return "This Field is Required";
                  //  //        }
                  //  //
                  //  //        return null;
                  //  //      },
                  //  //    ),
                  //  //  ),
                  //  //
                  //  //  const Align(
                  //  //    alignment: Alignment.topLeft,
                  //  //      child: Padding(
                  //  //          padding: EdgeInsets.only(left: 10),
                  //  //          child: Text("Date of birth"),
                  //  //      )),
                  //  //  Padding(
                  //  //    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  //  //    child: Row(
                  //  //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //  //      children: [
                  //  //          InkWell(
                  //  //            onTap: () {
                  //  //              providerValue.selectDOB(context);
                  //  //            },
                  //  //            child: Container(
                  //  //              width: width/2.2,
                  //  //              height: 50,
                  //  //
                  //  //            decoration: BoxDecoration(
                  //  //                color: Colors.white,
                  //  //              border: Border.all(color: Colors.grey,),
                  //  //              borderRadius: BorderRadius.circular(25)
                  //  //            ),
                  //  //            child: Padding(
                  //  //              padding:  EdgeInsets.symmetric(horizontal: 15),
                  //  //              child: Row(
                  //  //                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //  //                children: [
                  //  //                   Text(providerValue.day,style: TextStyle(color: Colors.grey)),
                  //  //                  Container(height: 22,width: 1,color: myGreen,),
                  //  //                   Text(providerValue.month,style: TextStyle(color: Colors.grey)),
                  //  //                  Container(height: 22,width: 1,color: myGreen,),
                  //  //                   Text(providerValue.year,style: TextStyle(color: Colors.grey)),
                  //  //                ],
                  //  //              ),
                  //  //            ),
                  //  //            ),
                  //  //          ),
                  //  //          Container(
                  //  //            width: width/2.2,
                  //  //            height: 50,
                  //  //
                  //  //          decoration: BoxDecoration(
                  //  //              color: Colors.white,
                  //  //            border: Border.all(color: Colors.grey,),
                  //  //            borderRadius: BorderRadius.circular(25)
                  //  //          ),
                  //  //          child: Row(
                  //  //            mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //  //            children: [
                  //  //              const Text("Gender",style: TextStyle(fontWeight: FontWeight.bold)),
                  //  //              Container(height: 22,width: 1,color: myGreen,),
                  //  //              Radio(
                  //  //                splashRadius: 2,
                  //  //                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //  //                // activeColor: cl_493058,
                  //  //                value: "Female",
                  //  //                activeColor: myGreen,
                  //  //                groupValue:providerValue.gender,
                  //  //                visualDensity: const VisualDensity(horizontal: -4, vertical: 4),
                  //  //                onChanged: (value){
                  //  //                  providerValue.gender = value.toString();
                  //  //                  providerValue.notifyListeners();
                  //  //                },
                  //  //              ),
                  //  //
                  //  //              InkWell(
                  //  //                  onTap: (){
                  //  //                    providerValue.gender = "Female";
                  //  //                    providerValue.notifyListeners();
                  //  //                  },
                  //  //                  child: Text("Female",style:  TextStyle(fontSize:width*0.024))
                  //  //              ),
                  //  //
                  //  //
                  //  //              Radio(
                  //  //                splashRadius: 2,
                  //  //                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //  //                visualDensity: const VisualDensity(horizontal: -4, vertical: 4),
                  //  //                // activeColor: cl_493058,
                  //  //                value: "Male",
                  //  //                activeColor: myGreen,
                  //  //                groupValue: providerValue.gender,
                  //  //                onChanged: (value){
                  //  //                  providerValue.gender = value.toString();
                  //  //                  providerValue.notifyListeners();
                  //  //                },
                  //  //              ),
                  //  //
                  //  //
                  //  //              InkWell(
                  //  //                  onTap: (){
                  //  //                    providerValue.gender = "Male";
                  //  //                    providerValue.notifyListeners();
                  //  //                  },
                  //  //                  child: Text("Male",style:  TextStyle(fontSize: width*0.024),)
                  //  //              ),
                  //  //
                  //  //            ],
                  //  //          ),
                  //  //          ),
                  //  //      ],
                  //  //    ),
                  //  //  ),
                  //  //
                  //  //  Padding(
                  //  //    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  //  //    child: TextFormField(
                  //  //    maxLines: null,
                  //  //      controller: providerValue.memberProfession,
                  //  //      decoration: InputDecoration(
                  //  //        fillColor: Colors.white,
                  //  //        filled: true,
                  //  //            hintStyle: const TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),
                  //  //            border: OutlineInputBorder(
                  //  //              borderRadius: BorderRadius.circular(30),
                  //  //            ),
                  //  //            focusedBorder: OutlineInputBorder(
                  //  //                borderRadius: BorderRadius.circular(30),
                  //  //                borderSide:  BorderSide(
                  //  //                    color: myGreen,)),
                  //  //            enabledBorder: OutlineInputBorder(
                  //  //              borderRadius: BorderRadius.circular(30),
                  //  //              borderSide: const BorderSide(
                  //  //                color: Colors.black38,
                  //  //              ),
                  //  //            ),
                  //  //          hintText: "Profession",
                  //  //
                  //  //           ),
                  //  //      validator: (value) {
                  //  //        if (value!.isEmpty) {
                  //  //          return "This Field is Required";
                  //  //        }
                  //  //
                  //  //        return null;
                  //  //      },
                  //  //    ),
                  //  //  ),
                  //  //              const SizedBox(height: 100,)
                  //  //            ],
                  //  //          ),
                  //  //        ),
                  //         // SingleChildScrollView(
                  //         //   child: Column(
                  //         //     children: [
                  //         //       const Align(
                  //         //         alignment: Alignment.topLeft,
                  //         //           child: Padding(
                  //         //             padding: EdgeInsets.only(left: 10),
                  //         //             child: Text("Other Details",style: TextStyle(fontWeight: FontWeight.bold),),
                  //         //           )),
                  //         //       Consumer<MainProvider>(
                  //         //         builder: (context,val,child) {
                  //         //           val.memberState.text =widget.state;
                  //         //           val.memberDistrict.text =widget.district;
                  //         //           val.memberAssembly.text = widget.assembly;
                  //         //           val.memberPanchayath.text = widget.panchayath;
                  //         //           val.memberUnit.text = widget.unit;
                  //         //           return Column(
                  //         //             children: [
                  //         //
                  //         //               Padding(
                  //         //                 padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  //         //                  child: textFormField2("State",providerValue.memberState)),
                  //         //               Padding(
                  //         //                   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  //         //                   child: textFormField2("District",providerValue.memberDistrict)),
                  //         //               Padding(
                  //         //                   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  //         //                   child: textFormField2("Assembly",providerValue.memberAssembly)),
                  //         //               Padding(
                  //         //                   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  //         //                   child: textFormField2("Panchayath",providerValue.memberPanchayath)),
                  //         //               Padding(
                  //         //                   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  //         //                   child: textFormField2("Unit",providerValue.memberUnit)),
                  //         //
                  //         //             ],
                  //         //           );
                  //         //         }
                  //         //       ),
                  //         //      SizedBox(height: 100,)
                  //         //
                  //         //     ],
                  //         //   ),
                  //         // )
                  //       ]
                  //   ),
                  // ),

                  const SizedBox(height: 50,),
                  widget.from=="Request"?
                  Center(
                    child: Consumer<MainProvider>(
                      builder: (context,value,child) {

                        return Consumer<DonationProvider>(
                          builder: (context,value3,child) {
                            return InkWell(
                              onTap: () async {
                                final FormState? form = _formKey.currentState;
                                if(form!.validate() ) {
                                  if(value.day!='Day'&&value.month!='Month'&&value.year!='Year'){
                                  if (widget.from == "Request") {

                                     // await value.alreadyExistNumber(value.memberPhoneNumber.text);
                                     await value.alreadyExistVoterId(value.TypeIdCt.text,widget.idStatus);
                                     providerValue.addProfessions();
                                     providerValue.addEducation();
                                     providerValue.getRequestConditions();
                                     // !value.checkNumber&&
                                    if(!value.checkVoterId){

                                      requestSaveAlert(context);

                                    }else{
                                      print("hsndasbnvsbda");
                                      const snackBar = SnackBar(
                                        content: Text('Number Already Exist'),
                                      );

                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                    }

                                  }
                                  } else{
                                    const snackBar = SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text('Please select Date of birth'),
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                }
                              },
                              child: Container(
                                width: width,
                                height: 50,
                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    color: myGreen,borderRadius: BorderRadius.circular(30)
                                ),
                                child:const Center(
                                  child: Text(
                                    // providerValue.indextab == 1?"Register" :"Next" ,
                                    "Pay & Register",
                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                ),
                              ),
                            );
                          }
                        );
                      }
                    ),
                  ):
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Consumer<MainProvider>(
                        builder: (context56,value,child) {
                          return InkWell(
                            onTap: () async {
                              print(value.day + "/" + value.month + "/" +value.year+"eyeyeyeyey");
                              // print(_tabController.index.toString()+"dasdasdad");
                              //
                              //  final FormState? form = _formKey.currentState;
                              // if(form!.validate() && providerValue.indextab==1){
                              //   print("fvbjbf");
                              //   providerValue.addMember(widget.from,"new",widget.uid,widget.idStatus);
                              //   providerValue.clearAddMember();
                              //   providerValue.getMembers();
                              //   callNext(BottomNavigationScreen(from: widget.from, uid: widget.uid, userName: "", state: widget.state, district: widget.district, assembly:widget. assembly, panchayath: widget.panchayath, unit:widget. unit), context);
                              //  }else{
                              //   _tabController.animateTo(_tabController.index + 1,);
                              //   providerValue.tabIndex(_tabController.index);
                              // providerValue.tabController.animateTo((providerValue.tabController.index + 1) % 2);
                              final FormState? form = _formKey.currentState;
                              if(form!.validate()) {
                                if(value.day!='Day'&&value.month!='Month'&&value.year!='Year'){
                                  print("fvbjbf");

                                  // await value.alreadyExistNumber(value.memberPhoneNumber.text);
                                  await value.alreadyExistVoterId(value.TypeIdCt.text,widget.idStatus);
                                  providerValue.addProfessions();
                                  providerValue.addEducation();
                                  if (widget.type == "New") {
                                    // !value.checkNumber &&
                                    if (!value.checkVoterId) {

                                      print("fmmfm"+value.checkNumber.toString()+"fkkfk"+value.checkVoterId.toString());
                                      saveConfirmationAlert(context);

                                      // DateTime now = DateTime.now();
                                      // String id = now.millisecondsSinceEpoch
                                      //     .toString();
                                      // value.addMember(
                                      //     context,
                                      //     widget.from,
                                      //     "New",
                                      //     widget.uid,
                                      //     widget.idStatus,
                                      //     widget.unit,
                                      //     widget.assembly,
                                      //     widget.district,
                                      //     widget.state,
                                      //     id,
                                      //     '');
                                      //
                                      // callNextReplacement(
                                      //     BottomNavigationScreen(
                                      //         from: widget.from,
                                      //         uid: widget.uid,
                                      //         userName: "",
                                      //         state: widget.state,
                                      //         district: widget.district,
                                      //         assembly: widget.assembly,
                                      //         unit: widget.unit,
                                      //         phoneNumber: widget.proffetion,
                                      //         photo: widget.photo,
                                      //         address: widget.address,loginLevel: widget.loginLevel ),
                                      //     context);
                                    } else {
                                      const snackBar = SnackBar(
                                        content: Text(
                                            'Number Already Exist'),
                                      );

                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  } else if (widget.type == "Edit") {
                                    providerValue.addMember(
                                        context,
                                        widget.from,
                                        "Edit",
                                        widget.uid,
                                        widget.idStatus,
                                        widget.unit,
                                        widget.assembly,
                                        widget.district,
                                        widget.state,
                                        widget.MemberId,
                                        '');
                                    callNextReplacement(BottomNavigationScreen(
                                        from: widget.from,
                                        uid: widget.uid,
                                        userName: "",
                                        state: widget.state,
                                        district: widget.district,
                                        assembly: widget.assembly,
                                        unit: widget.unit,
                                        phoneNumber: widget.proffetion,
                                        photo: widget.photo,
                                        address: widget.address,
                                    loginLevel: widget.loginLevel), context);
                                  }
                                  // providerValue.clearAddMember();

                                  providerValue.getMembers(
                                      widget.state, widget.district,
                                      widget.assembly, widget.unit);
                                  providerValue.getUnpaidMembers(
                                      widget.state, widget.district,
                                      widget.assembly, widget.unit);

                                  providerValue.getMembersCount(
                                      widget.state, widget.district,
                                      widget.assembly, widget.unit,
                                      '');
                                  providerValue.getUnPaidMembersCount(
                                      widget.state, widget.district,
                                      widget.assembly, widget.unit,
                                      '');
                                }
                                else{
                                  const snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('Please select Date of birth'),
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              }
                            },
                            child: Consumer<MainProvider>(
                              builder: (context,val2,child) {
                                return val2.memberLoader==true?
                                const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                                    ),
                                  ),
                                ):Container(
                                      width: width/2.5,
                                      height: 50,
                                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: myGreen,
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Save",
                                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                      ),
                                    );
                              }
                            )
                          );
                        }
                      ),
                      Consumer<MainProvider>(
                        builder: (context3,value,child) {
                          return widget.paymentStatus != "PAID"
                              ?Consumer<DonationProvider>(
                            builder: (ctxt,value22,child) {
                              return InkWell(
                                onTap: () async {
                                  final FormState? form = _formKey.currentState;
                                  if(form!.validate() ) {
                                    print(value.day.toString()+"sfjnskj"+value.month+"swfdew"+value.year);
                                    if(value.day!='Day'&&value.month!='Month'&&value.year!='Year'){
                                      print("fvbjbf" + widget.assembly + ' ' +
                                          widget.district + ' ' + widget.state);
                                      // await value.alreadyExistNumber(value.memberPhoneNumber.text);
                                      await value.alreadyExistVoterId(value.TypeIdCt.text,widget.idStatus);
                                      providerValue.addProfessions();
                                      providerValue.addEducation();

                                      DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                      donationProvider.transactionID.text = DateTime.now().microsecondsSinceEpoch.toString() + generateRandomString(2);
                                      DateTime now = DateTime.now();
                                      String id = now.millisecondsSinceEpoch.toString();
                                      print(value.attemptMap.toString() + "iiiriir");


                                      if (widget.type == "New") {
                                        // !value.checkNumber &&
                                  if (!value.checkVoterId) {

                                          providerValue.addMember(context, widget.from, "New", widget.uid, widget.idStatus,
                                              widget.unit, widget.assembly, widget.district, widget.state, id, '');

                                          Future.delayed(
                                              Duration(seconds: 1), () async {
                                            donationProvider.attempt(
                                              donationProvider.membershipAmount.toString(),
                                              id.toString(),
                                              value.memberName.text,
                                              value.memberPhoneNumber.text,
                                              donationProvider.transactionID.text,
                                              widget.state,
                                              widget.district,
                                              widget.assembly,
                                              widget.unit,
                                              donationProvider.appVersion.toString(),
                                              value.attemptMap,);
                                          });


                                          if(Platform.isIOS){
                                            callNextReplacement(NewPaymentGatewayScreen(id: "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=mb%20${donationProvider.transactionID.text}&am=${donationProvider.membershipAmount.toString()}&cu=INR", state:widget.state, district: widget.district, assembly: widget.assembly, unit: widget.unit, from: widget.from, username:widget.userName, userID: widget.uid, photo: widget.photo, profession:widget.proffetion, address:  widget.address, loginLevel: widget.loginLevel, amount:donationProvider.membershipAmount.toString(),), context);

                                          }else if(Platform.isAndroid){
                                            if(value22.lockMindGateOption=="ON"&&value22.intentPaymentOption=="OFF"){

                                              callNextReplacement(NewPaymentGatewayScreen(id: "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=mb%20${donationProvider.transactionID.text}&am=${donationProvider.membershipAmount.toString()}&cu=INR", state:widget.state, district: widget.district, assembly: widget.assembly, unit: widget.unit, from: widget.from, username:widget.userName, userID: widget.uid, photo: widget.photo, profession:widget.proffetion, address:  widget.address, loginLevel: widget.loginLevel, amount:donationProvider.membershipAmount.toString(),), context);

                                            }
                                            else{
                                              callNextReplacement(PaymentGateway(
                                                amount: donationProvider.membershipAmount.toString(),
                                                isFromRequest: 'New',
                                                profession: widget.proffetion,
                                                photo: widget.photo,
                                                address: widget.address,
                                                userID: widget.uid,
                                                username: widget.userName,
                                                unit: widget.unit,
                                                name: value.memberName.text,
                                                phone: value.memberPhoneNumber.text,
                                                loginLevel: widget.loginLevel, from: widget.from, memberId: id.toString(),
                                                state: widget.state,district: widget.district, assembly: widget.assembly,),
                                                  context);

                                            }



                                        }
                                      }
                                        else {
                                          const snackBar = SnackBar(
                                            content: Text('Number Already Exist'),
                                          );

                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        }
                                      }
                                      else if (widget.type == "Edit") {

                                        providerValue.addMember(context, widget.from, "Edit", widget.uid, widget.idStatus,
                                            widget.unit, widget.assembly, widget.district, widget.state, widget.MemberId, '');

                                        Future.delayed(
                                            Duration(seconds: 1), () async {
                                          donationProvider.attempt(
                                            donationProvider.membershipAmount.toString(),
                                              widget.MemberId,
                                            value.memberName.text,
                                            value.memberPhoneNumber.text,
                                            donationProvider.transactionID.text,
                                            widget.state,
                                            widget.district,
                                            widget.assembly,
                                            widget.unit,
                                            donationProvider.appVersion.toString(),
                                            value.attemptMap,);
                                        });


                                        if(Platform.isIOS){
                                          callNextReplacement(NewPaymentGatewayScreen(id: "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=mb%20${donationProvider.transactionID.text}&am=${donationProvider.membershipAmount.toString()}&cu=INR", state:widget.state, district: widget.district, assembly: widget.assembly, unit: widget.unit, from: widget.from, username:widget.userName, userID: widget.uid, photo: widget.photo, profession:widget.proffetion, address:  widget.address, loginLevel: widget.loginLevel, amount:donationProvider.membershipAmount.toString(),), context);

                                        }else if(Platform.isAndroid){
                                          if(value22.lockMindGateOption=="ON"&&value22.intentPaymentOption=="OFF"){

                                            callNextReplacement(NewPaymentGatewayScreen(id: "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=mb%20${donationProvider.transactionID.text}&am=${donationProvider.membershipAmount.toString()}&cu=INR", state:widget.state, district: widget.district, assembly: widget.assembly, unit: widget.unit, from: widget.from, username:widget.userName, userID: widget.uid, photo: widget.photo, profession:widget.proffetion, address:  widget.address, loginLevel: widget.loginLevel, amount:donationProvider.membershipAmount.toString(),), context);

                                          }
                                          else{
                                            callNextReplacement(PaymentGateway(
                                              amount: donationProvider.membershipAmount.toString(),
                                              isFromRequest: 'New',
                                              profession: widget.proffetion,
                                              photo: widget.photo,
                                              address: widget.address,
                                              userID: widget.uid,
                                              username: widget.userName,
                                              unit: widget.unit,
                                              name: value.memberName.text,
                                              phone: value.memberPhoneNumber.text,
                                              loginLevel: widget.loginLevel, from: widget.from, memberId: widget.MemberId,
                                              state: widget.state,district: widget.district, assembly: widget.assembly,),
                                                context);

                                          }



                                        }

                                      }



                                    }
                                    else{
                                      const snackBar = SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text('Please select Date of birth'),
                                      );

                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  }
                                },
                                child: Container(
                                  width: width/2.5,
                                  height: 50,
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: myGreen,borderRadius: BorderRadius.circular(30)
                                  ),
                                  child:const Center(
                                    child: Text(
                                      // providerValue.indextab == 1?"Register" :"Next" ,
                                      "Pay Now",
                                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              );
                            }
                          ):SizedBox();
                        }
                      ),
                    ],
                  ),
                  const SizedBox(height: 80,),
                ],
              ),
            ),
          );
        }
      ),
    );
  }


  requestSaveAlert(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      scrollable: true,
      title:  Consumer<MainProvider>(
        builder: (context,val,child) {
          return Column(
            children: [
               Text(
                val.requestAlertContent,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 25,),
              Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return Container(
                      height: 35,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: myDarkGreen),
                        color: myDarkGreen,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Consumer<DonationProvider>(
                          builder: (context,value3,child) {
                            return TextButton(
                                child: Text(
                                  'Pay & Register',
                                  style: TextStyle(color: myWhite),
                                ),
                                onPressed: () async {

                                  DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
                                  await value.addMembershipRequest();
                                  donationProvider.transactionID.text =  DateTime.now().microsecondsSinceEpoch.toString()+generateRandomString(2);
                                  value.memberIdCt.text=DateTime.now().millisecondsSinceEpoch.toString();

                                  Future.delayed(Duration(seconds: 1), () async {
                                    donationProvider.attempt(donationProvider.membershipAmount.toString(),value.memberIdCt.text,
                                      value.memberName.text, value.memberPhoneNumber.text,
                                      donationProvider.transactionID.text, value.requestMemberState,
                                      value.requestMemberDistrict
                                      ,value.requestMemberAssembly, value.memberUnit.text, donationProvider.appVersion.toString(),value.requestMap,);
                                  });

                                  if(Platform.isIOS){
                                    callNextReplacement(NewPaymentGatewayScreen(id: "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=mb%20${donationProvider.transactionID.text}&am=${donationProvider.membershipAmount.toString()}&cu=INR",
                                      state:widget.state, district: widget.district, assembly: widget.assembly, unit: widget.unit, from: widget.from, username:widget.userName, userID: widget.uid, photo: widget.photo, profession:widget.proffetion, address:  widget.address, loginLevel: widget.loginLevel, amount:donationProvider.membershipAmount.toString(),), context);

                                  }else if(Platform.isAndroid){
                                    if(value3.lockMindGateOption=="ON"&&value3.intentPaymentOption=="OFF"){


                                      callNextReplacement(NewPaymentGatewayScreen(id: "upi://pay?pa=iumlkerala10@hdfcbank&pn=INDIAN%20UNION%20MUSLIM%20LEAGUE&mc=8699&tr=${donationProvider.transactionID.text}&mode=04&tn=mb%20${donationProvider.transactionID.text}&am=${donationProvider.membershipAmount.toString()}&cu=INR",
                                        state:widget.state, district: widget.district, assembly: widget.assembly, unit: widget.unit, from: widget.from, username:widget.userName, userID: widget.uid, photo: widget.photo, profession:widget.proffetion, address:  widget.address, loginLevel: widget.loginLevel, amount:donationProvider.membershipAmount.toString(),), context);

                                    }else{
                                      callNextReplacement(PaymentGateway(amount: donationProvider.membershipAmount.toString(),isFromRequest: 'Request',
                                        profession: widget.proffetion,photo: widget.photo,address: widget.address,
                                        userID: widget.uid,username: widget.userName,unit: value.memberUnit.text,name:value.memberName.text,phone:value.memberPhoneNumber.text,
                                        loginLevel: widget.loginLevel, from: widget.from, memberId:value.memberIdCt.text, state:  value.requestMemberState, district: value.requestMemberDistrict,assembly: value.requestMemberAssembly,),
                                          context);

                                    }

                                  }

                                  // finish(context);
                                });
                          }
                      ),
                    );
                  }
              ),
              const SizedBox(height: 8,),
              Container(
                height: 35,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: myDarkGreen),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: TextButton(
                    child: Text('Cancel', style: TextStyle(color: myBlack)),
                    onPressed: () {
                      finish(context);

                    }),
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


  saveConfirmationAlert(BuildContext context) {
    // MainProvider mainProvider =
    // Provider.of<MainProvider>(context, listen: false);
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      scrollable: true,
      title: const Text(
        "Do you want to Save?",
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
                   value.memberLoader?CircularProgressIndicator(color: myDarkGreen,):
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
                          child: Text('Yes', style: TextStyle(color: myWhite)),
                          onPressed: () {

                            DateTime now = DateTime.now();
                            String id = now.millisecondsSinceEpoch
                                .toString();
                            value.addMember(
                                context,
                                widget.from,
                                "New",
                                widget.uid,
                                widget.idStatus,
                                widget.unit,
                                widget.assembly,
                                widget.district,
                                widget.state,
                                id,
                                '');
                            finish(context);
                            callNextReplacement(
                                BottomNavigationScreen(
                                    from: widget.from,
                                    uid: widget.uid,
                                    userName: "",
                                    state: widget.state,
                                    district: widget.district,
                                    assembly: widget.assembly,
                                    unit: widget.unit,
                                    phoneNumber: widget.proffetion,
                                    photo: widget.photo,
                                    address: widget.address,
                                    loginLevel: widget.loginLevel ),
                                context);
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
                          child: Text(
                            'No',
                            style: TextStyle(color: myBlack),
                          ),
                          onPressed: () {
                            finish(context);

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


class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}