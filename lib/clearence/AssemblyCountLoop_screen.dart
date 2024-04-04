import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/my_functions.dart';
import '../Models/panchayath_model.dart';
import '../Screens/Add_New_Member.dart';
import '../constants/my_colors.dart';
import '../providers/Main_Provider.dart';

class AssemblyCountLoopScreen extends StatelessWidget {
   AssemblyCountLoopScreen({super.key});

   final  _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    MainProvider mainProvider = Provider.of<MainProvider>(context);


    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(onTap: (){
          finish(context);
        },
          child: Icon(
            Icons.arrow_back_ios_new,color: Colors.black,size: 50,
          ),
        ),
      ),
      backgroundColor: Colors.green.withOpacity(0.7),
      body: Center(
        child: Container(

          height: height*0.8,
          width: width*0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Form(
            key: _formKey,
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width*0.8,
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
                                fieldTextEditingController.text = value.selectLoopStateCT.text;
                              });

                              return SizedBox(
                                child: TextFormField(
                                  validator: (text){
                                    if(text!.isEmpty&& !value.stateList.contains(text)){
                                      return 'Invalid state';
                                    }else{
                                      return null;
                                    }
                                  },
                                  textAlign: TextAlign.left,
                                  onChanged: (item){
                                    if(item==''){
                                      value.selectLoopStateCT.text='';
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
                              value.selectLoopStateCT.text=selection;
                              if(selection!=''){
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
                ),
                SizedBox(height: 30,),
                Container(
                  // height: 50,
                  width: width*0.8,
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
                                fieldTextEditingController.text = value.selectLoopDistrictCT.text;
                              });

                              return SizedBox(
                                child: TextFormField(
                                  validator: (text){
                                    if(text!.isEmpty&& !value.stateList.contains(text)){
                                      return 'Invalid District';
                                    }else{
                                      return null;
                                    }
                                  },
                                  onChanged: (item){
                                    if(item==''){
                                      value.selectLoopDistrictCT.text='';
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
                              value.selectLoopDistrictCT.text=selection;
                              if(selection!=''){
                                mainProvider.getAllAssembly(value.selectLoopStateCT.text, value.selectLoopDistrictCT.text);
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
                ),
                SizedBox(height: 20,),
                Container(
                  // height: 50,
                  width: width*0.8,
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
                                fieldTextEditingController.text = value.selectLoopAssemblyCT.text;
                              });

                              return SizedBox(
                                child: TextFormField(
                                  validator: (text){
                                    if(text!.isEmpty&& !value.stateList.contains(text)){
                                      return 'Invalid Assembly';
                                    }else{
                                      return null;
                                    }
                                  },
                                  onChanged: (item){
                                    if(item==''){
                                      value.selectLoopAssemblyCT.text='';
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
                              value.selectLoopAssemblyCT.text=selection;
                              if(selection!=''){

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
                ),
                Consumer<MainProvider>(
                    builder: (context,value,child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: ()  async {
                              final FormState? form = _formKey.currentState;
                              if(form!.validate() ) {

                                mainProvider.clearAssemblyCounts();
                              }

                            },
                            child: value.coordinatorLoader?
                            CircularProgressIndicator(color: myDarkGreen,):Container(
                              width: width*0.4,
                              height: 50,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.green,width: 2)
                              ),
                              child:const Center(
                                child: Text(
                                  "Click here to Clear Assembly Data First",
                                  style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: ()  async {
                              final FormState? form = _formKey.currentState;
                              if(form!.validate() ) {

                                alertConfirmation(context);
                              }

                            },
                            child: value.coordinatorLoader?
                            CircularProgressIndicator(color: myDarkGreen,):Container(
                              width: width*0.1,
                              height: 50,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: myGreen,borderRadius: BorderRadius.circular(15)
                              ),
                              child:const Center(
                                child: Text(
                                  "start Loop",
                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                ),
                SizedBox(height: 20,),
                Consumer<MainProvider>(
                    builder: (context,value,child) {
                      return SizedBox(
                        child:
                        value.clearDistrictBool?
                        CircularProgressIndicator(color: myDarkGreen,)
                            :SizedBox(),
                      );
                    }
                )
              ],

            ),
          ),
        ),
      ),
    );
  }

   alertConfirmation(BuildContext context) {
     // MainProvider mainProvider =
     // Provider.of<MainProvider>(context, listen: false);
     AlertDialog alert = AlertDialog(
       backgroundColor: Colors.white,
       scrollable: true,
       title: const Text(
         "Ensure to clear the District data First,Then start Loop?",
         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
       ),
       content: Consumer<MainProvider>(
           builder: (context,value,child) {
             return Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Column(
                   children: [
                     Text('Are you sure to start Loop',style: TextStyle(color: Colors.redAccent,fontSize: 20,fontWeight: FontWeight.bold),),
                     SizedBox(height: 20,),
                     Icon(Icons.warning_amber,color: Colors.redAccent,),
                     SizedBox(height: 10,),
                     InkWell(onTap: (){
                       MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
                       mainProvider.assemblyWiseLoopppp();
                       finish(context);

                     },
                       child: Container(
                         width: 150,
                         height: 50,
                         margin: const EdgeInsets.symmetric(horizontal: 10),
                         decoration: BoxDecoration(
                             color: myGreen,borderRadius: BorderRadius.circular(30)
                         ),
                         child:const Center(
                           child: Text(
                             // providerValue.indextab == 1?"Register" :"Next" ,
                             "Sure",
                             style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                         ),
                       ),
                     ),
                   ],
                 )
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
