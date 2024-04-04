import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iuml_membership/constants/my_functions.dart';
import 'package:iuml_membership/providers/Main_Provider.dart';
import 'package:provider/provider.dart';

import '../Models/masterReportModel.dart';
import '../constants/my_colors.dart';
import 'Add_New_Member.dart';

class RegistrationReportScreen extends StatelessWidget {
  String from,state,distrct,assembly;
   RegistrationReportScreen({Key? key,required this.from,required this.distrct
    ,required this.assembly,required this.state,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 100,
        elevation: 0,
        backgroundColor: cWhite,
        leading: Row(
          children: [
            const SizedBox(width:10),
            InkWell(
              onTap: (){
                finish(context);
              },
              child:  Icon(Icons.arrow_back_ios,color:myBlack),
            ),
            const SizedBox(width:5),
            Text(
              'IUML',
              style: TextStyle(
                color: cl197118,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                letterSpacing: 0.48,
              ),
            )
          ],
        ),
        title:Text(
          'Registration Report',
          textAlign: TextAlign.center,
          style: TextStyle(
            color:cl303030,
            fontSize: 15,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.45,
          ),
        ),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10,),
            SizedBox(width: width,
              child: Align(alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: InkWell(onTap: (){
                    mainProvider.clearAllRegReport(from);
                  },
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black.withOpacity(0.2))),
                      height:30,width: 100,
                      child: Center(child: Text('Clear Filter')),),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            from=='NATIONAL_LEVEL'?
            Container(height: 50,width: width,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Consumer<MainProvider>(
                    builder: (context,value,child) {
                      return Center(child: Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          return (value.stateList)
                              .where((String item) => item
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()))
                              .toList();
                        },
                        displayStringForOption: (String option) => option,
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController fieldTextEditingController,
                            FocusNode fieldFocusNode,
                            VoidCallback onFieldSubmitted) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            fieldTextEditingController.text = value.regReportStateCT.text;
                          });

                          return SizedBox(
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              onChanged: (item){
                                if(item==''){
                                  value.regReportStateCT.text='';
                                }
                              },
                              maxLines: null,
                              textCapitalization: TextCapitalization.characters,
                              inputFormatters: [
                                UpperCaseTextFormatter()
                              ],
                              decoration: InputDecoration(
                                contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
                                hintStyle:  TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w400,fontSize: 13,fontFamily: "Poppins"),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(width: 0.5, color: myGrey2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:  BorderSide(
                                        color: myGreen,width: 1)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(width: 0.5, color: myGrey2,
                                  ),
                                ),

                                hintText: 'Select State',
                                // suffixIcon: const Icon(
                                //   Icons.keyboard_arrow_down_sharp,
                                //   size: 25,
                                //   color: Colors.black38,
                                // ),
                              ),
                              // validator: (text) =>
                              // text == '' ? validation
                              //     : null,
                              // onChanged: (txt) {
                              //   controller.text = txt;
                              // },
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                            ),
                          );
                        },

                        onSelected: (String selection) {
                          MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
                          value.regReportStateCT.text=selection;
                          if(selection!=''){
                            mainProvider.fetchMasterData('STATE_LEVEL',selection,'','');
                            mainProvider.getAllDistrict(selection);
                          }
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        optionsViewBuilder: (BuildContext context,
                            AutocompleteOnSelected<String> onSelected,
                            Iterable<String> options) {
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
                                    final String option = options.elementAt(index);

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
                                              Text(option,
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
                      ));
                    }
                ),
              ),
            ):SizedBox(),
            const SizedBox(height: 15,),
            from=='NATIONAL_LEVEL'  || from=='STATE_LEVEL'?
            Container(height: 50,width: width,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Consumer<MainProvider>(
                    builder: (context,value,child) {
                      return Center(child: Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          return (value.districtList)
                              .where((String item) => item
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()))
                              .toList();
                        },
                        displayStringForOption: (String option) => option,
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController fieldTextEditingController,
                            FocusNode fieldFocusNode,
                            VoidCallback onFieldSubmitted) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            fieldTextEditingController.text = value.regReportdistNameCT.text;
                          });

                          return SizedBox(
                            child: TextFormField(
                              onChanged: (item){
                                if(item==''){
                                  value.regReportdistNameCT.text='';
                                }
                              },
                              maxLines: null,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.characters,
                              inputFormatters: [
                                UpperCaseTextFormatter()
                              ],
                              decoration: InputDecoration(
                                contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
                                hintStyle:  TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w400,fontSize: 13,fontFamily: "Poppins"),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(width: 0.5, color: myGrey2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:  BorderSide(
                                        color: myGreen,width: 1)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(width: 0.5, color: myGrey2,
                                  ),
                                ),
                                hintText: 'Select District',
                                // suffixIcon: const Icon(
                                //   Icons.keyboard_arrow_down_sharp,
                                //   size: 25,
                                //   color: Colors.black38,
                                // ),
                              ),
                              // validator: (text) =>
                              // text == '' ? validation
                              //     : null,
                              // onChanged: (txt) {
                              //   controller.text = txt;
                              // },
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                            ),
                          );
                        },

                        onSelected: (String selection) {
                          MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
                          value.regReportdistNameCT.text=selection;
                          if(selection!=''){
                            mainProvider.regDistrictFilterFun(selection);
                            mainProvider.getAllAssembly(value.regReportStateCT.text,selection);
                          }else{
                            mainProvider.regstateAllreport();
                          }
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        optionsViewBuilder: (BuildContext context,
                            AutocompleteOnSelected<String> onSelected,
                            Iterable<String> options) {
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
                                    final String option = options.elementAt(index);

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
                                              Text(option,
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
                      ));
                    }
                ),
              ),
            ):SizedBox(),
            const SizedBox(height: 15,),
            from=='NATIONAL_LEVEL'  || from=='STATE_LEVEL' ||
                from=='DISTRICT_LEVEL'?Container(height: 50,width: width,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Consumer<MainProvider>(
                    builder: (context,value,child) {
                      return Center(child: Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          return (value.assemblyList)
                              .where((String item) => item
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()))
                              .toList();
                        },
                        displayStringForOption: (String option) => option,
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController fieldTextEditingController,
                            FocusNode fieldFocusNode,
                            VoidCallback onFieldSubmitted) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            fieldTextEditingController.text = value.regReportassmblyNameCT.text;
                          });

                          return SizedBox(
                            child: TextFormField(
                              onChanged: (item){
                                if(item==''){
                                  value.regReportassmblyNameCT.text='';
                                }
                              },
                              maxLines: null,
                              textAlign: TextAlign.left,
                              textCapitalization: TextCapitalization.characters,
                              inputFormatters: [
                                UpperCaseTextFormatter()
                              ],
                              decoration: InputDecoration(
                                contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
                                hintStyle:  TextStyle(color: cl4D4D4D,fontWeight: FontWeight.w400,fontSize: 13,fontFamily: "Poppins"),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(width: 0.5, color: myGrey2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:  BorderSide(
                                        color: myGreen,width: 1)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(width: 0.5, color: myGrey2,
                                  ),
                                ),
                                hintText: 'Select Assembly',
                                // suffixIcon: const Icon(
                                //   Icons.keyboard_arrow_down_sharp,
                                //   size: 25,
                                //   color: Colors.black38,
                                // ),
                              ),
                              // validator: (text) =>
                              // text == '' ? validation
                              //     : null,
                              // onChanged: (txt) {
                              //   controller.text = txt;
                              // },
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                            ),
                          );
                        },

                        onSelected: (String selection) {
                          MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
                          value.regReportassmblyNameCT.text=selection;
                          if(selection!=''){
                            mainProvider.regAssmblyFilter(value.regReportdistNameCT.text,selection);
                          }
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        optionsViewBuilder: (BuildContext context,
                            AutocompleteOnSelected<String> onSelected,
                            Iterable<String> options) {
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
                                    final String option = options.elementAt(index);

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
                                              Text(option,
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
                      ));
                    }
                ),
              ),
            ):SizedBox(),
            const SizedBox(height: 15,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 40,//MediaQuery.of(context).size.height * .08
                    width: 900,
                    color:cWhite,
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 8),
                          alignment: Alignment.centerLeft,
                          color: clE1FFD8,
                          width: 230,
                          child:Text(
                            'State',
                            style: TextStyle(
                              color: cl303030,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.33,
                            ),
                          )
                        ),

                        const SizedBox(width:2),

                        Consumer<MainProvider>(
                            builder: (context, value, child) {
                              return Container(
                                  padding: const EdgeInsets.only(left: 8),
                                color: clE1FFD8,
                                alignment: Alignment.centerLeft,
                                width: 150,
                                child: Text(
                                  'Total',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: cl303030,
                                    fontSize: 13,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.33,
                                  ),
                                )
                              );
                            }),

                        const SizedBox(width:2),

                        Container(
                          padding: const EdgeInsets.only(left: 8),
                          color: clE1FFD8,
                          alignment: Alignment.centerLeft,
                          width: 150,
                          child:  Text(
                            "Paid",
                            style: TextStyle(
                              color: cl303030,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.33,
                            ),
                          ),
                        ),
                        const SizedBox(width:2),
                        Container(
                          padding: const EdgeInsets.only(left: 8),
                          color: clE1FFD8,
                          alignment: Alignment.centerLeft,
                          width: 150,
                          child:  Text(
                            "UnPaid",
                            style: TextStyle(
                              color: cl303030,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.33,
                            ),
                          ),
                        ), const SizedBox(width:2),
                        Container(
                          padding: const EdgeInsets.only(left: 8),
                          color: clE1FFD8,
                          alignment: Alignment.centerLeft,
                          width: 150,
                          child:  Text(
                            "PENDING REQUESTS",
                            style: TextStyle(
                              color: cl303030,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.33,
                            ),
                          ),
                        ),


                        const SizedBox(width:3),
                      ],
                    ),
                  ),
                ),

                Consumer<MainProvider>(builder: (context, value, child) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                          margin: const EdgeInsets.only(top: 5,left: 8,right: 8),
                          width: 900,color: myWhite,
                          child: ListView.builder(
                              shrinkWrap: true,
                              // scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: value.filterMasterModelList.where((element) => element.mandalam!='')
                                  .map((e) => e.state).toSet().toList().length,
                              itemBuilder: (context, districtindex) {
                                List<String> stateListNew = value
                                    .filterMasterModelList
                                    .where((element) => element.mandalam != "")
                                    .map((e) => e.state)
                                    .toSet()
                                    .toList();

                                List<DistrictFilterModel>stateListt=[];
                                for(var ee in stateListNew){
                                  stateListt.add(DistrictFilterModel(ee, 0));
                                }

                                stateListt.sort((a, b) {
                                  return a.value.compareTo(b.value);
                                });

                                String stateName = stateListt[districtindex].name.toString().trim();//districtindex

                                List<MasterReportModel> stateRegDetails =  mainProvider.stateSettingfunc(stateName);


                                List<MasterReportModel> statePaid1 =
                                stateRegDetails.where((element) => element.mandalam!='').where((element) => element.requestStatus=='APPROVE').where((element) => element.paymentStatus=='PAID')
                                    .toList();

                                List<MasterReportModel> statePaid2 =
                                stateRegDetails.where((element) => element.mandalam!='').where((element) => element.requestStatus=='').where((element) => element.paymentStatus=='PAID')
                                    .toList();
                                List<MasterReportModel> statePaid =statePaid1+statePaid2;

                                List<MasterReportModel> stateReg =
                                stateRegDetails
                                    .where((element) =>  element.paymentStatus=='REGISTERED')
                                    .toList();
                                List<MasterReportModel> requestPending =
                                stateRegDetails
                                    .where((element) =>  element.requestStatus=='PENDING')
                                    .toList();
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      color:Colors.white,
                                      child: Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                            color:Colors.white,
                                            width: 230,
                                            child: Text(
                                              stateName,
                                              style: const TextStyle(
                                                color: Color(0xFF303030),
                                                fontSize: 14,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.bold,
                                                height: 1.03,
                                                letterSpacing: -0.17,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(width: 2,),

                                          Container(
                                            width: 150,
                                            alignment: Alignment.centerLeft,
                                            padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                            color:Colors.white,
                                            child: Text(
                                              stateRegDetails.length.toString(),
                                              style: TextStyle(
                                                color:cl303030,
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.27,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(width: 2,),

                                          Container(
                                            width: 150,
                                            alignment: Alignment.centerLeft,
                                            padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                            color:Colors.white,
                                            child: Text(
                                              statePaid.length.toString(),
                                              style: TextStyle(
                                                color:cl303030,
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.27,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(width: 2,),

                                          Container(
                                            width: 150,
                                            alignment: Alignment.centerLeft,
                                            padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                            color:Colors.white,
                                            child: Text(
                                              stateReg.length.toString(),
                                              style: TextStyle(
                                                color:cl303030,
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.27,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 2,),

                                          Container(
                                            width: 150,
                                            alignment: Alignment.centerLeft,
                                            padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                            color:Colors.white,
                                            child: Text(
                                              requestPending.length.toString(),
                                              style: TextStyle(
                                                color:cl303030,
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.27,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 3,),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: stateRegDetails.map((e) => e.district).toSet().toList().length,
                                        itemBuilder: (context, assemblyindex) {

                                          List<String> districList = stateRegDetails
                                              .map((e) => e.district)
                                              .toSet()
                                              .toList();

                                          String districtName =
                                          districList[assemblyindex];
                                          List<MasterReportModel> assemblyGuards =
                                          stateRegDetails
                                              .where((element) =>
                                          element.district ==
                                              districtName.trim()).where((element) => element.mandalam!='' && element.mandalam!='null')
                                              .toList();
                                          List<MasterReportModel> paidDistrict1 =
                                          assemblyGuards.where((element) => element.paymentStatus=='PAID').where((element) => element.requestStatus=='')
                                              .toList();
                                          List<MasterReportModel> paidDistrict2 =
                                          assemblyGuards.where((element) => element.paymentStatus=='PAID').where((element) => element.requestStatus=='APPROVE')
                                              .toList();
                                          List<MasterReportModel> paidDistrict=paidDistrict1+paidDistrict2;
                                          List<MasterReportModel> regDistrict =
                                          assemblyGuards.where((element) =>  element.paymentStatus=='REGISTERED')
                                              .toList();

                                          List<MasterReportModel> pendingRequests =
                                          assemblyGuards.where((element) =>  element.requestStatus=='PENDING')
                                              .toList();

                                          return Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    color:clD9FFCD,
                                                    alignment: Alignment.centerLeft,
                                                    padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                    width: 230,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 10.0),
                                                      child: Text(
                                                        districtName,
                                                        style: TextStyle(
                                                          color: myBlue,
                                                          fontSize: 12,
                                                          fontFamily: 'Poppins',
                                                          fontWeight: FontWeight.w500,
                                                          letterSpacing: 0.27,
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  const SizedBox(width:2),

                                                  Container(
                                                    color:clD9FFCD,
                                                    alignment: Alignment.centerLeft,
                                                    padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                    width: 150,
                                                    child: Text(
                                                      assemblyGuards.length.toString(),
                                                      style: TextStyle(
                                                        color:cl303030,
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.27,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width:2),

                                                  Container(
                                                    color:clD9FFCD,
                                                    alignment: Alignment.centerLeft,
                                                    padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                    width: 150,
                                                    child: Text(
                                                      paidDistrict.length.toString(),
                                                      style: TextStyle(
                                                        color: cl303030,
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.27,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width:2),
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                    color:clD9FFCD,
                                                    width: 150,
                                                    child: Text(
                                                      regDistrict.length.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: cl303030,
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.27,
                                                      ),
                                                    ),
                                                  ),const SizedBox(width:2),
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                    color:clD9FFCD,
                                                    width: 150,
                                                    child: Text(
                                                      pendingRequests.length.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: cl303030,
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: 0.27,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              const SizedBox(height: 3,),

                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                  const NeverScrollableScrollPhysics(),
                                                  itemCount: assemblyGuards
                                                      .map((e) => e.mandalam).toSet().toList().length,
                                                  itemBuilder:
                                                      (context, panchayathindex) {



                                                    List<String> assemblyListNew =
                                                    assemblyGuards
                                                        .map((e) => e. mandalam)
                                                        .toSet()
                                                        .toList();

                                                    String assemblyName =
                                                    assemblyListNew[
                                                    panchayathindex];


                                                    List<MasterReportModel> unittt =
                                                    stateRegDetails
                                                        .where((element) =>
                                                    element.mandalam ==
                                                        assemblyName.trim()).where((element) => element.unit!='' && element.unit!='null')
                                                        .toList();


                                                    List<MasterReportModel>
                                                    aseemblyLList =
                                                    assemblyGuards
                                                        .where((element) =>
                                                    element.mandalam ==
                                                        assemblyName)
                                                        .toList();

                                                    List<MasterReportModel>
                                                    pandistrictadmins1=
                                                    assemblyGuards
                                                        .where((element) => element.paymentStatus=='PAID').where((element) => element.requestStatus=='APPROVE').where((element) => element.mandalam==assemblyName)
                                                        .toList();
                                                    List<MasterReportModel>
                                                    pandistrictadmins2=
                                                    assemblyGuards
                                                        .where((element) => element.paymentStatus=='PAID').where((element) => element.requestStatus=='').where((element) => element.mandalam==assemblyName)
                                                        .toList();
                                                    List<MasterReportModel>  pandistrictadmins=pandistrictadmins2+pandistrictadmins1;
                                                    List<MasterReportModel>
                                                    panassemblyadmins =
                                                    assemblyGuards
                                                        .where((element) => element.paymentStatus=='REGISTERED').where((element) => element.mandalam==assemblyName)
                                                        .toList();

                                                    List<MasterReportModel>
                                                    pendingRequests =
                                                    assemblyGuards
                                                        .where((element) => element.requestStatus=='PENDING').where((element) => element.mandalam==assemblyName)
                                                        .toList();

                                                    print(aseemblyLList.length.toString()+' KJRKVR');

                                                    return
                                                      Column(
                                                        children: [
                                                          Container(
                                                            color: cWhite,
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  width: 230,
                                                                  alignment: Alignment.centerLeft,
                                                                  padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                                  color: clF6F6F6,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(left: 25.0),
                                                                    child: Text(
                                                                      assemblyName,
                                                                      style: TextStyle(
                                                                        color: cl00B300,
                                                                        fontSize: 12,
                                                                        fontFamily: 'Poppins',
                                                                        fontWeight: FontWeight.w500,
                                                                        letterSpacing: 0.27,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                                const SizedBox(width: 2,),

                                                                Container(
                                                                  color: clF6F6F6,
                                                                  width: 150,
                                                                  alignment: Alignment.centerLeft,
                                                                  padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                                  child: Text(
                                                                    aseemblyLList.length.toString(),
                                                                    style: TextStyle(
                                                                      color: cl303030,
                                                                      fontSize: 12,
                                                                      fontFamily: 'Poppins',
                                                                      fontWeight: FontWeight.w400,
                                                                      letterSpacing: 0.27,
                                                                    ),
                                                                  ),
                                                                ),

                                                                const SizedBox(width: 2,),

                                                                Container(
                                                                  color: clF6F6F6,
                                                                  width: 150,
                                                                  alignment: Alignment.centerLeft,
                                                                  padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                                  child: Text(
                                                                    pandistrictadmins.length.toString(),
                                                                    style: TextStyle(
                                                                      color: cl303030,
                                                                      fontSize: 12,
                                                                      fontFamily: 'Poppins',
                                                                      fontWeight: FontWeight.w400,
                                                                      letterSpacing: 0.27,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  color: clF6F6F6,
                                                                  width: 150,
                                                                  alignment: Alignment.centerLeft,
                                                                  padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                                  child: Text(
                                                                    panassemblyadmins.length.toString(),

                                                                    style: TextStyle(
                                                                      color: cl303030,
                                                                      fontSize: 12,
                                                                      fontFamily: 'Poppins',
                                                                      fontWeight: FontWeight.w400,
                                                                      letterSpacing: 0.27,
                                                                    ),
                                                                  ),
                                                                ),  Container(
                                                                  color: clF6F6F6,
                                                                  width: 150,
                                                                  alignment: Alignment.centerLeft,
                                                                  padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                                  child: Text(
                                                                    pendingRequests.length.toString(),

                                                                    style: TextStyle(
                                                                      color: cl303030,
                                                                      fontSize: 12,
                                                                      fontFamily: 'Poppins',
                                                                      fontWeight: FontWeight.w400,
                                                                      letterSpacing: 0.27,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                          Container(
                                                            child: ListView.builder(
                                                                shrinkWrap: true,
                                                                physics:
                                                                const NeverScrollableScrollPhysics(),
                                                                itemCount: unittt
                                                                    .map((e) => e.unit).toSet().toList().length,
                                                                itemBuilder:
                                                                    (context, panchayathindex) {

                                                                      List<String> unitListNew =
                                                                      unittt
                                                                          .map((e) => e. unit)
                                                                          .toSet()
                                                                          .toList();

                                                                      String unitName =
                                                                      unitListNew[
                                                                      panchayathindex];

                                                                      print(unitName+' MCKRMVKV');

                                                                      List<MasterReportModel>
                                                                      unitssList =
                                                                      unittt
                                                                          .where((element) =>
                                                                      element.unit ==
                                                                          unitName)
                                                                          .toList();


                                                                      List<MasterReportModel>
                                                                      unitadminsPaid1 =
                                                                      unittt
                                                                          .where((element) => element.paymentStatus=='PAID').where((element) => element.requestStatus=='').where((element) => element.unit==unitName)
                                                                          .toList();

                                                                      List<MasterReportModel>
                                                                      unitadminsPaid2 =
                                                                      unittt
                                                                          .where((element) => element.paymentStatus=='PAID').where((element) => element.requestStatus=='').where((element) => element.unit==unitName)
                                                                          .toList();
                                                                      List<MasterReportModel> unitadminsPaid=unitadminsPaid1+unitadminsPaid2;
                                                                      List<MasterReportModel>
                                                                      unPaidUnitMembers =
                                                                      unittt
                                                                          .where((element) => element.paymentStatus=='REGISTERED').where((element) =>  element.unit==unitName)
                                                                          .toList();
                                                                      List<MasterReportModel>
                                                                      pendingRequests =
                                                                      unittt
                                                                          .where((element) => element.requestStatus=='PENDING').where((element) =>  element.unit==unitName)
                                                                          .toList();

                                                                  return
                                                                    Container(
                                                                      color: cWhite,
                                                                      child: Row(
                                                                        children: [
                                                                          Container(
                                                                            width: 230,
                                                                            alignment: Alignment.centerLeft,
                                                                            padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                                            color: clFDFFFC,
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.only(left: 45.0),
                                                                              child: Text(
                                                                                unitName,
                                                                                style: TextStyle(
                                                                                  color: Colors.brown,
                                                                                  fontSize: 12,
                                                                                  fontFamily: 'Poppins',
                                                                                  fontWeight: FontWeight.w500,
                                                                                  letterSpacing: 0.27,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          const SizedBox(width: 2,),

                                                                          Container(
                                                                            color: clFDFFFC,
                                                                            width: 150,
                                                                            alignment: Alignment.centerLeft,
                                                                            padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                                            child: Text(
                                                                              unitssList.length.toString(),
                                                                              style: TextStyle(
                                                                                color: cl303030,
                                                                                fontSize: 12,
                                                                                fontFamily: 'Poppins',
                                                                                fontWeight: FontWeight.w400,
                                                                                letterSpacing: 0.27,
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          const SizedBox(width: 2,),

                                                                          Container(
                                                                            color: clFDFFFC,
                                                                            width: 150,
                                                                            alignment: Alignment.centerLeft,
                                                                            padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                                            child: Text(
                                                                              unitadminsPaid.length.toString(),
                                                                              style: TextStyle(
                                                                                color: cl303030,
                                                                                fontSize: 12,
                                                                                fontFamily: 'Poppins',
                                                                                fontWeight: FontWeight.w400,
                                                                                letterSpacing: 0.27,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            color: clFDFFFC,
                                                                            width: 150,
                                                                            alignment: Alignment.centerLeft,
                                                                            padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                                            child: Text(
                                                                              unPaidUnitMembers.length.toString(),

                                                                              style: TextStyle(
                                                                                color: cl303030,
                                                                                fontSize: 12,
                                                                                fontFamily: 'Poppins',
                                                                                fontWeight: FontWeight.w400,
                                                                                letterSpacing: 0.27,
                                                                              ),
                                                                            ),
                                                                          ),   Container(
                                                                            color: clFDFFFC,
                                                                            width: 150,
                                                                            alignment: Alignment.centerLeft,
                                                                            padding:EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                                            child: Text(
                                                                              pendingRequests.length.toString(),

                                                                              style: TextStyle(
                                                                                color: cl303030,
                                                                                fontSize: 12,
                                                                                fontFamily: 'Poppins',
                                                                                fontWeight: FontWeight.w400,
                                                                                letterSpacing: 0.27,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                }),
                                                          ),
                                                        ],
                                                      );
                                                  }),
                                            ],
                                          );
                                        }),
                                  ],
                                );
                              })),
                    ),
                  );
                }
                ),




          ],
        ),
      ),
    );
  }
}
