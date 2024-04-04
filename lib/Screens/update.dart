import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/my_colors.dart';
import '../constants/my_text.dart';

class Update extends StatelessWidget {
  String text;
  String button;
  String ADDRESS;
  Update({Key? key,required this.text,required this.button,required this.ADDRESS}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration:   BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                    myWhite,myGreen,
                  ]
              )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(text,style: whitePoppinsBoldM18,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: (){
                    _launchURL(ADDRESS);
                  },
                  child: Container(
                    height: 40,
                    width: 150,

                    decoration: BoxDecoration(
                        gradient:  LinearGradient(
                            colors: [
                              myGreen,myGreen
                            ]
                        ),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,),
                            child: Text(button,style:  TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              color: cWhite,
                            ),),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png",scale:3),
            ],
          ),
        ),


      ),
    );

  }
  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
