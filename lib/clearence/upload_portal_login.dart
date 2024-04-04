import 'package:flutter/material.dart';
import 'package:iuml_membership/clearence/uploadExcel.dart';
import 'package:iuml_membership/clearence/webProvider.dart';
import 'package:provider/provider.dart';
import '../constants/my_colors.dart';
import '../constants/my_functions.dart';

class UploadLogIn extends StatelessWidget {
  UploadLogIn({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(

          width: 300,
          child: Form(

            key: _formKey ,

            child: Column(

              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<WebProvider>(

                    builder: (context,value,child) {
                      return TextFormField(
                        validator: (txt){
                          if(txt!.isEmpty||txt!=value.password){
                            return 'Please Enter Valid Password';
                          }else{
                            return null;
                          }
                        },
                      );
                    }
                ),

                Padding(

                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(

                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(myWhite),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(myGreen),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(

                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side:  BorderSide(
                            color: myGreen,
                            width: 2.0,
                          ),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(

                              vertical: 15, horizontal: 30)),
                    ),
                    onPressed: () async {

                      final FormState? form = _formKey.currentState;
                      if (form!.validate()) {
                        callNext(UploadExcel(), context);
                      }
                    },
                    child: Text(
                      'Log in',

                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
