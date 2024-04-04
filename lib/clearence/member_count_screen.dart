import 'package:flutter/material.dart';
import 'package:iuml_membership/Constants/my_functions.dart';
import 'package:iuml_membership/clearence/webProvider.dart';
import 'package:provider/provider.dart';

import '../constants/my_text.dart';
import '../providers/Main_Provider.dart';

class MemberCountScreen extends StatelessWidget {
  const MemberCountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    WebProvider webProvider = Provider.of<WebProvider>(context, listen: false);

    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Text("StateCount",style: TextStyle(color: Colors.black,fontSize: 20),),
          Consumer<WebProvider>(
            builder: (context,val,child) {
              return Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 5),
                      child: Consumer<MainProvider>(
                          builder: (context,value,child) {
                            return SizedBox(
                                width: width/3,
                                child: autocomplete(context,value.stateList,val.stateCT,"State","Select Profession"));
                          }
                      )
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          child: const Text("Get Paid Members Count",),
                          onPressed: () {
                            webProvider.getStateCount(webProvider.stateCT.text.toString());
                          },
                        ),
                      ),
                      Consumer<WebProvider>(
                        builder: (context,val,child) {
                          return Text(val.statePaidCount.toString(),style: TextStyle(color: Colors.black,fontSize: 15),);
                        }
                      ),
                    ],
                  ),   Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      child: const Text("Get Un Paid Members Count",),
                      onPressed: () {

                      },
                    ),
                  ),
                ],
              );
            }
          ),
        ],
      ),
    );
  }
}
