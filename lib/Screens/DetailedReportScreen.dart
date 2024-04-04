import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/my_functions.dart';
import '../Models/MasterCoordinatorModel.dart';
import '../Models/masterReportModel.dart';
import '../constants/my_colors.dart';
import '../constants/my_text.dart';
import '../providers/Main_Provider.dart';
import 'Add_New_Member.dart';

class DetailedReportScreen extends StatelessWidget {
  String from;
   DetailedReportScreen({Key? key,required this.from}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(from+' KJKJdc');
    MainProvider mainProvider = Provider.of<MainProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
            ),
            SizedBox(width: width,
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(backgroundColor: reportColor1,radius: 10,),
                      Text(' State',style: style1)
                    ],
                  ),
                  SizedBox(width: 10,),
                  Row(
                    children: [
                      CircleAvatar(backgroundColor: reportColor2,radius: 10,),
                      Text(' District',style: style1)
                    ],
                  ),SizedBox(width: 10,), Row(
                    children: [
                      CircleAvatar(backgroundColor: reportColor3,radius: 10,),
                      Text(' Assembly',style: style1)
                    ],
                  ),SizedBox(width: 10,), Row(
                    children: [
                      CircleAvatar(backgroundColor: reportColor4,radius: 10,),
                      Text(' Unit',style: style1)
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(width: width,
              child: Align(alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: InkWell(onTap: (){
                    mainProvider.clearAll(from);
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
            const SizedBox(
              height: 10,
            ),
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
                            fieldTextEditingController.text = value.stateNameCT.text;
                          });

                          return SizedBox(
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              onChanged: (item){
                                if(item==''){
                                  value.stateNameCT.text='';
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
                          value.stateNameCT.text=selection;
                          if(selection!=''){
                            mainProvider.onReportLoader();
                            mainProvider.fetchMasterCoordinatorsDetails(selection,'','','STATE_LEVEL',);
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

            const SizedBox(
              height: 10,
            ),
            Consumer<MainProvider>(
              builder: (context,value,child) {
                return
                  value.stateNameCT.text!='' ?
                  Column(
                  children: [
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
                                    fieldTextEditingController.text = value.distNameCT.text;
                                  });

                                  return SizedBox(
                                    child: TextFormField(
                                      onChanged: (item){
                                        if(item==''){
                                          value.distNameCT.text='';
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
                                  value.distNameCT.text=selection;
                                  if(selection!=''){
                                    mainProvider.reportDistrictWiseFilter(selection);
                                    mainProvider.getAllAssembly(value.stateNameCT.text,selection);
                                  }else{
                                    mainProvider.stateAllreport();
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
                    const SizedBox(
                      height: 10,
                    ),
                    from=='NATIONAL_LEVEL'  || from=='STATE_LEVEL' ||
                        from=='DISTRICT_LEVEL'?
                    Container(height: 50,width: width,
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
                                    fieldTextEditingController.text = value.assmblyNameCT.text;
                                  });

                                  return SizedBox(
                                    child: TextFormField(
                                      onChanged: (item){
                                        if(item==''){
                                          value.assmblyNameCT.text='';
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
                                  value.assmblyNameCT.text=selection;
                                  if(selection!=''){
                                    mainProvider.reportAssemblyWiseFilter(value.distNameCT.text,selection);
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
                    const SizedBox(
                      height: 10,
                    ),

                  ],
                ):SizedBox();
              }
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 40, //MediaQuery.of(context).size.height * .08
                width: 400,
                color: cWhite,
                child: Row(
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.only(left: 8),
                        alignment: Alignment.centerLeft,
                        color: clE1FFD8,
                        width: 230,
                        child: Text(
                          'State',
                          style: TextStyle(
                            color: cl303030,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.33,
                          ),
                        )),
                    const SizedBox(width: 2),
                    Consumer<MainProvider>(builder: (context, value, child) {
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
                          ));
                    }),
                    const SizedBox(width: 2),

                  ],
                ),
              ),
            ),
            Consumer<MainProvider>(builder: (context, value, child) {
              return value.reportDetailsLoader?
              SizedBox(
                  width: width,
                  height: 200,
                  child: Center(
                      child: const CircularProgressIndicator()))
              :Flexible(
                fit: FlexFit.tight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      margin: const EdgeInsets.only(top: 0, left: 8, right: 8),
                      width: 400,
                      color: myWhite,
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          // scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: value.MasterCoordinatorDetailsList.where(
                                  (element) => element.designation != '')
                              .map((e) => e.state)
                              .toSet()
                              .toList()
                              .length,
                          itemBuilder: (context, districtindex) {
                            List<String> stateListNew =
                                value.MasterCoordinatorDetailsList.where(
                                        (element) => element.designation != "")
                                    .map((e) => e.state)
                                    .toSet()
                                    .toList();

                            List<DistrictFilterModel> stateListt = [];
                            for (var ee in stateListNew) {
                              stateListt.add(DistrictFilterModel(ee, 0));
                            }

                            stateListt.sort((a, b) {
                              return a.value.compareTo(b.value);
                            });

                            String stateName = stateListt[districtindex]
                                .name
                                .toString()
                                .trim(); //districtindex

                            List<MasterCoordinatorDetailsModel>
                                stateRegDetails =
                                mainProvider.stateAllMembersFilter(
                                    stateName, 'STATE COORDINATOR');
                            List<MasterCoordinatorDetailsModel>
                                StateAllCoordinators =
                                mainProvider.stateAllMembersSetting(stateName);
                            print(stateRegDetails.length.toString() +
                                ' JJJNMMMMMMM');

                            return stateName!=''?
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Container(height: 35,
                                        alignment: Alignment.centerLeft,
                                        padding:
                                            EdgeInsets.fromLTRB(8, 10, 0, 10),
                                        color:reportColor1,
                                        width: 230,
                                        child: Text(
                                          stateName,
                                          style:  TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            height: 1.03,
                                            letterSpacing: -0.17,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Container(
                                        width: 150,
                                        height: 35,
                                        alignment: Alignment.centerLeft,
                                        padding:
                                            EdgeInsets.fromLTRB(8, 10, 0, 10),
                                        color: reportColor1,
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                            color: cl303030,
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.27,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),


                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Column(
                                  children: [
                                    ListView.builder(
                                      padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        // scrollDirection: Axis.horizontal,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: stateRegDetails.length,
                                        itemBuilder: (context, stateIndex) {
                                          var stateCoordinators =
                                              stateRegDetails[stateIndex];
                                          return Column(
                                            children: [
                                              Container(
                                                color: Colors.white,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              8, 10, 0, 10),
                                                      color: Colors.white,
                                                      width: 230,
                                                      child: Text(
                                                        stateCoordinators.name,
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF303030),
                                                          fontSize: 14,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          height: 1.03,
                                                          letterSpacing: -0.17,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 2,
                                                    ),
                                                    Container(
                                                      width: 150,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              8, 10, 0, 10),
                                                      color: Colors.white,
                                                      child: Text(
                                                        stateCoordinators.NumberofMembers,
                                                        style: TextStyle(
                                                          color: cl303030,
                                                          fontSize: 12,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: 0.27,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 2,
                                                    ),

                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          );
                                        }),
                                    ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: StateAllCoordinators.map(
                                                (e) => e.district)
                                            .toSet()
                                            .toList()
                                            .length,
                                        itemBuilder: (context, assemblyindex) {
                                          List<String> districList =
                                              StateAllCoordinators.map(
                                                      (e) => e.district)
                                                  .toSet()
                                                  .toList();
                                          String districtName =
                                              districList[assemblyindex];

                                          List<MasterCoordinatorDetailsModel>
                                              districtCoordinators =
                                              mainProvider
                                                  .DistrictAllMembersFilter(
                                                      districtName,
                                                      'DISTRICT COORDINATOR');

                                          List<MasterCoordinatorDetailsModel>
                                              assemblyDetails =
                                              StateAllCoordinators.where(
                                                      (element) =>
                                                          element.district ==
                                                          districtName.trim())
                                                  .toList();

                                          return
                                            districtName!=''?
                                            Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    color: reportColor2,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            8, 10, 0, 10),
                                                    width: 230,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Text(
                                                        districtName,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          letterSpacing: 0.27,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Container(
                                                    color: reportColor2,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            8, 10, 0, 10),
                                                    width: 150,
                                                    child: Text(
                                                      '',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 0.27,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 2),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          districtCoordinators
                                                              .length,
                                                      itemBuilder: (context,
                                                          districtIndex) {
                                                        var districtCoordinator =
                                                            districtCoordinators[
                                                                districtIndex];
                                                        return Container(
                                                          color: cWhite,
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 230,
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            8,
                                                                            10,
                                                                            0,
                                                                            10),
                                                                color: Colors
                                                                    .white,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          45.0),
                                                                  child: Text(
                                                                    districtCoordinator
                                                                        .name,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .brown,
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      letterSpacing:
                                                                          0.27,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 2,
                                                              ),
                                                              Container(
                                                                color: clFDFFFC,
                                                                width: 150,
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            8,
                                                                            10,
                                                                            0,
                                                                            10),
                                                                child: Text(
                                                                  districtCoordinator
                                                                      .NumberofMembers,
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        cl303030,
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    letterSpacing:
                                                                        0.27,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 2,
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                  ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          StateAllCoordinators
                                                                  .map((e) => e
                                                                      .mandalam)
                                                              .toSet()
                                                              .toList()
                                                              .length,
                                                      itemBuilder: (context,
                                                          mandalamindex) {
                                                        List<String>
                                                            mandalamList =
                                                            StateAllCoordinators
                                                                    .map((e) =>
                                                                        e.mandalam)
                                                                .toSet()
                                                                .toList();
                                                        String mandalamName =
                                                            mandalamList[
                                                                mandalamindex];

                                                        print(mandalamName.toString()+' NJIFVN');
                                                        List<MasterCoordinatorDetailsModel>
                                                            assemblyCordinators =
                                                            mainProvider
                                                                .assemblyAllMembersFilter(
                                                                    districtName,
                                                                    mandalamName,
                                                                    'ASSEMBLY COORDINATOR');

                                                        return
                                                          mandalamName!=''?
                                                          Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: 230,
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          8,
                                                                          10,
                                                                          0,
                                                                          10),
                                                                  color: reportColor3,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            45.0),
                                                                    child: Text(
                                                                      mandalamName,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors.black,
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        letterSpacing:
                                                                            0.27,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 2,
                                                                ),
                                                                Container(
                                                                  color:
                                                                  reportColor3,
                                                                  width: 150,
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          8,
                                                                          10,
                                                                          0,
                                                                          10),
                                                                  child: Text(
                                                                    '',
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          Colors.white,
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      letterSpacing:
                                                                          0.27,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 2,
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              children: [
                                                                ListView
                                                                    .builder(
                                                                    padding: EdgeInsets.zero,
                                                                        shrinkWrap:
                                                                            true,
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(),
                                                                        itemCount:
                                                                            assemblyCordinators
                                                                                .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                mandalamMembIndex) {
                                                                          var mandalamCordinatorList =
                                                                              assemblyCordinators[mandalamMembIndex];
                                                                          return Container(
                                                                            color:
                                                                                cWhite,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Container(
                                                                                  width: 230,
                                                                                  alignment: Alignment.centerLeft,
                                                                                  padding: EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                                                  color: Colors.white,
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.only(left: 45.0),
                                                                                    child: Text(
                                                                                      mandalamCordinatorList.name,
                                                                                      style: TextStyle(
                                                                                        color: Colors.black,
                                                                                        fontSize: 12,
                                                                                        fontFamily: 'Poppins',
                                                                                        fontWeight: FontWeight.w500,
                                                                                        letterSpacing: 0.27,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 2,
                                                                                ),
                                                                                Container(
                                                                                  color: Colors.white,
                                                                                  width: 150,
                                                                                  alignment: Alignment.centerLeft,
                                                                                  padding: EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                                                  child: Text(
                                                                                    mandalamCordinatorList.NumberofMembers,
                                                                                    style: TextStyle(
                                                                                      color: Colors.black,
                                                                                      fontSize: 12,
                                                                                      fontFamily: 'Poppins',
                                                                                      fontWeight: FontWeight.w400,
                                                                                      letterSpacing: 0.27,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 2,
                                                                                ),

                                                                              ],
                                                                            ),
                                                                          );
                                                                        }),
                                                                ListView
                                                                    .builder(
                                                                  padding: EdgeInsets.zero,
                                                                        shrinkWrap:
                                                                            true,
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(),
                                                                        itemCount: StateAllCoordinators.map((e) =>
                                                                                e.unit)
                                                                            .toSet()
                                                                            .toList()
                                                                            .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                unitIndex) {
                                                                          List<String>
                                                                              unitList =
                                                                              StateAllCoordinators.map((e) => e.unit).toSet().toList();
                                                                          String
                                                                              unitName =
                                                                              unitList[unitIndex];

                                                                          List<MasterCoordinatorDetailsModel> unitCoordinators = mainProvider.unitAllMembersFilter(
                                                                              districtName,
                                                                              mandalamName,
                                                                              unitName,
                                                                              'UNIT COORDINATOR');

                                                                          return unitName!=''?
                                                                          Column(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Container(
                                                                                    width: 230,
                                                                                    alignment: Alignment.centerLeft,
                                                                                    padding: EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                                                    color: reportColor4,
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(left: 45.0),
                                                                                      child: Text(
                                                                                        unitName,
                                                                                        style: TextStyle(
                                                                                          color: Colors.white,
                                                                                          fontSize: 12,
                                                                                          fontFamily: 'Poppins',
                                                                                          fontWeight: FontWeight.w500,
                                                                                          letterSpacing: 0.27,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 2,
                                                                                  ),
                                                                                  Container(
                                                                                    color: reportColor4,
                                                                                    width: 150,
                                                                                    alignment: Alignment.centerLeft,
                                                                                    padding: EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                                                    child: Text(
                                                                                      '',
                                                                                      style: TextStyle(
                                                                                        color: cl303030,
                                                                                        fontSize: 12,
                                                                                        fontFamily: 'Poppins',
                                                                                        fontWeight: FontWeight.w400,
                                                                                        letterSpacing: 0.27,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 2,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              ListView.builder(
                                                                                  padding: EdgeInsets.zero,
                                                                                  shrinkWrap: true,
                                                                                  physics: const NeverScrollableScrollPhysics(),
                                                                                  itemCount: unitCoordinators.length,
                                                                                  itemBuilder: (context, unitCooIndex) {
                                                                                    var item=unitCoordinators[unitCooIndex];
                                                                                    return    Row(
                                                                                      children: [
                                                                                        Container(
                                                                                          width: 230,
                                                                                          alignment: Alignment.centerLeft,
                                                                                          padding: EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                                                          color: Colors.white,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.only(left: 45.0),
                                                                                            child: Text(
                                                                                              item.name,
                                                                                              style: TextStyle(
                                                                                                color: Colors.black,
                                                                                                fontSize: 12,
                                                                                                fontFamily: 'Poppins',
                                                                                                fontWeight: FontWeight.w500,
                                                                                                letterSpacing: 0.27,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          width: 2,
                                                                                        ),
                                                                                        Container(
                                                                                          color: Colors.white,
                                                                                          width: 150,
                                                                                          alignment: Alignment.centerLeft,
                                                                                          padding: EdgeInsets.fromLTRB(8, 10, 0, 10),
                                                                                          child: Text(
                                                                                            item.NumberofMembers,
                                                                                            style: TextStyle(
                                                                                              color: Colors.black,
                                                                                              fontSize: 12,
                                                                                              fontFamily: 'Poppins',
                                                                                              fontWeight: FontWeight.w400,
                                                                                              letterSpacing: 0.27,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          width: 2,
                                                                                        ),

                                                                                      ],
                                                                                    );
                                                                                  }),
                                                                            ],
                                                                          ):SizedBox();
                                                                        }),
                                                              ],
                                                            )
                                                          ],
                                                        ):SizedBox();
                                                      }),
                                                ],
                                              ),
                                            ],
                                          ):SizedBox();
                                        }),
                                  ],
                                ),
                              ],
                            ):SizedBox();
                          })),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
TextStyle style1= TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12);
