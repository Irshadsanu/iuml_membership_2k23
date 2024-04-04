import 'package:iuml_membership/Screens/Add_New_Member.dart';
import 'package:iuml_membership/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:iuml_membership/state_model.dart';
import 'package:provider/provider.dart';

import '../providers/Main_Provider.dart';

TextStyle appbarStyle = TextStyle(
    color: myBlack,fontWeight: FontWeight.w600,fontFamily: "Poppins",fontSize: 16);

TextStyle style1 = TextStyle(
  color: myBlack,fontSize: 12,fontWeight: FontWeight.w700,fontFamily: "Poppins"
);
TextStyle style2 = TextStyle(
  color: myBlack,fontSize: 14,fontWeight: FontWeight.w700,fontFamily: "Poppins"
);
TextStyle style3 = TextStyle(
    color: myBlack,fontSize: 15,fontWeight: FontWeight.w700,fontFamily: "PoppinsMedium"
);
TextStyle style11 = TextStyle(
    color: myBlack,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: "Poppins"
);
TextStyle black16= TextStyle(
    fontFamily: 'PoppinsMedium',
    fontSize: 16,
    color:myBlack
);
TextStyle white16= TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    color:myWhite
);
TextStyle rupeeBig7= TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize:28,
    color:myGreen2
);

TextStyle whitePoppinsBoldM18= TextStyle(
    fontFamily: 'PoppinsMedium',
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color:cWhite
);
TextStyle blackPoppinsBoldM20=const TextStyle(
    fontFamily: 'PoppinsMedium',
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color:Colors.black
);


Widget textFormField(String hint,TextEditingController controller){
  return TextFormField(
    maxLines: null,
    controller: controller,
    decoration: InputDecoration(
      contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
      hintStyle:  TextStyle(color: myBlack.withOpacity(0.6),fontFamily: "PoppinsMedium",fontSize: 13,fontWeight: FontWeight.bold),
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
      hintText: hint,

    ),
    validator: (value) {
      if (value!.isEmpty) {
        return "This Field is Required";
      }

      return null;
    },
  );
}

Widget textFormField2(String hint,TextEditingController controller){
  return TextFormField(
    maxLines: null,
    controller: controller,
    enabled: false,
    decoration: InputDecoration(
      contentPadding:const EdgeInsets.symmetric(vertical: 16,horizontal: 14),
      hintStyle:  TextStyle(color: myBlack.withOpacity(0.6),fontFamily: "PoppinsMedium",fontSize: 13,fontWeight: FontWeight.bold),
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
      hintText: hint,

    ),
    validator: (value) {
      if (value!.isEmpty) {
        return "This Field is Required";
      }

      return null;
    },
  );
}

Widget autocomplete(BuildContext context,List<String>list,TextEditingController controller,String hint,String validation){
  return Autocomplete<String>(
    optionsBuilder: (TextEditingValue textEditingValue) {
      return (list)
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
        fieldTextEditingController.text = controller.text;
      });

      return SizedBox(
        child: TextFormField(
          maxLines: null,
          textAlign: TextAlign.center,
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
            hintText: hint,
            // suffixIcon: const Icon(
            //   Icons.keyboard_arrow_down_sharp,
            //   size: 25,
            //   color: Colors.black38,
            // ),
          ),
          validator: (text) =>
          text == '' ? validation
              : null,
          onChanged: (txt) {
            controller.text = txt;
          },
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
        ),
      );
    },

    onSelected: (String selection) {
      MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

      controller.text=selection;
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
  );
}

Widget autocomplete2(BuildContext context,List<String>list,TextEditingController controller,String hint,String validation){
  return Autocomplete<String>(
    optionsBuilder: (TextEditingValue textEditingValue) {
      return (list)
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
        fieldTextEditingController.text = controller.text;
      });

      return SizedBox(
        child: TextFormField(
          maxLines: null,
          textAlign: TextAlign.center,
          enabled: false,
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
            hintText: hint,

          ),
          validator: (text) =>
          text == '' ? validation
              : null,
          onChanged: (txt) {
            // controller.text = txt;
          },
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
        ),
      );
    },

    onSelected: (String selection) {
      MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

      controller.text=selection;
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
  );
}



