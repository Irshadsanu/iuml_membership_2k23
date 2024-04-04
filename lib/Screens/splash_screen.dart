import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iuml_membership/Screens/home_screen.dart';
import 'package:iuml_membership/Screens/login_screen.dart';
import 'package:iuml_membership/providers/Main_Provider.dart';
import 'package:provider/provider.dart';

import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';
import '../providers/login_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer? _timer;

    FirebaseAuth auth = FirebaseAuth.instance;
    var LoginUser = auth.currentUser;
    super.initState();

    LoginProvider loginProvider =
    Provider.of<LoginProvider>(context, listen: false);
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);

    mainProvider.getAllStateDetailsFromJson();

    mainProvider.lockApp();
    donationProvider.getMembershipAmount();



    Timer(const Duration(seconds: 3), () {

      mainProvider.fetchDetails();
      if (LoginUser == null) {
        callNextReplacement( const LoginScreen(), context);
      }else{
        loginProvider.userAuthorized(LoginUser.phoneNumber,context);
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/Splash.jpg",),fit: BoxFit.fill)),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width/5),
                  child: Column(
                    children: [
                      SizedBox(height:height/4.5),
                      // Align(
                      //     alignment:Alignment.topLeft,
                      //
                      //     child: Image.asset("assets/ladder.png",scale: 7,
                      //     )),
                      SizedBox(height: height/2.5,),
                      const Text("IUML",style: TextStyle(fontFamily: "Coolvetica",
                          fontWeight:FontWeight.w400,fontSize: 72,color: Colors.white),),
                      SizedBox(height: height/7),
                      Image.asset("assets/Spine_Logo.png",scale: 2.5,)
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
