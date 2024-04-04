import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iuml_membership/constants/my_colors.dart';
import 'package:iuml_membership/loopScreen.dart';
import 'package:iuml_membership/providers/Main_Provider.dart';
import 'package:iuml_membership/providers/donation_provider.dart';
import 'package:iuml_membership/providers/login_provider.dart';
import 'package:iuml_membership/testScreen.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:url_strategy/url_strategy.dart';
import 'Screens/splash_screen.dart';
import 'clearence/upload_portal_login.dart';
import 'clearence/webProvider.dart';
import 'deviceinfo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(!kIsWeb) {
    await Firebase.initializeApp();
  }else {
    await Firebase.initializeApp(

        options:const FirebaseOptions(
            apiKey: "AIzaSyDZWRNF_wJZj7n6Y2iF2Gzhtj2yNART__g",
            authDomain: "iuml-membership.firebaseapp.com",
            databaseURL: "https://iuml-membership-default-rtdb.firebaseio.com",
            projectId: "iuml-membership",
            storageBucket: "iuml-membership.appspot.com",
            messagingSenderId: "692176876117",
            appId: "1:692176876117:web:71dcf6b193a0a7f69a5adc",
            measurementId: "G-93CJEVZVZV"
        )

    );

  }
  if(!kIsWeb){
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    bool weWantFatalErrorRecording = true;
    FlutterError.onError = (errorDetails) {
      if(weWantFatalErrorRecording){
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      } else {
        FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      }
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    String strDeviceID= await DeviceInfo().fun_initPlatformState();
    FirebaseCrashlytics.instance.setUserIdentifier(strDeviceID);
    FirebaseDatabase database;
    database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    runZonedGuarded(() async {
      runApp(const MyApp());

      await SmsAutoFill().getAppSignature;

    }, FirebaseCrashlytics.instance.recordError);
  }else{
    setPathUrlStrategy();
    runApp(const MyApp());
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider(),),
        ChangeNotifierProvider(create: (context) => LoginProvider(),),
        ChangeNotifierProvider(create: (context) => DonationProvider(),),
        ChangeNotifierProvider(create: (context) => WebProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IUML MEMBERSHIP',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          radioTheme: RadioThemeData(
            fillColor: MaterialStateProperty.all<Color>(myGreen), // Change the default border color here
          ),
        ),

        home: LoopScreen(),
        // home: SplashScreen(),
        // home: UploadLogIn(),
        // home: SplashScreen(),
        // home: UploadLogIn(),
        // home: SplashScreen(),
        // home: RequestPendingPage(),
        // home: AddNewMember(from: ""),

      ),
    );
  }
}
