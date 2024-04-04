
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


var appBarHeight = AppBar().preferredSize.height;

callNext(var className, var context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => className),
  );
}
callNextReplacement(var className, var context){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => className),
  );
}

back(var context) {
  Navigator.pop(context);
}
void finish(context) {
  Navigator.pop(context);
}
void hideKeyboard(context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
Color hexStringToHexInt(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff$hex' : hex;
  int val = int.parse(hex, radix: 16);
  return Color(val);
}
Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

OutlineInputBorder customEnabledBorder=   const OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(5.0)
  ),
  borderSide: BorderSide(color: Colors.grey, width: 1.2),
);

OutlineInputBorder customFocusBorder=   const OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(50.0)),
  borderSide: BorderSide(color: Colors.grey, width: 1.2),
);

TextStyle style1= TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12);
