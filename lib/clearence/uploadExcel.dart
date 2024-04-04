import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iuml_membership/clearence/AssemblyCountLoop_screen.dart';
import 'package:iuml_membership/clearence/webProvider.dart';
import 'package:iuml_membership/providers/Main_Provider.dart';
import 'package:provider/provider.dart';

import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../providers/donation_provider.dart';

import 'DistrctCountSettingScreen.dart';
import 'issueClearencePage.dart';
import 'member_count_screen.dart';

class UploadExcel extends StatefulWidget {
  @override
  _UploadExcel createState() => _UploadExcel();
}

class _UploadExcel extends State<UploadExcel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    WebProvider webProvider = Provider.of<WebProvider>(context, listen: false);
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Issue Clearance",),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child:const Text("Click here to Clear the issue"),
                    onPressed: () {
                      callNext(const IssueClearance(), context);
                    },
                  ),
                ),

                SizedBox(height: 30,),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Click here to Fetch Member Excel",),
                    onPressed: () {
                      webProvider.dateRangePickerFlutter(context);

                    },
                  ),
                ),
                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Click here to Download Member Excel",),
                    onPressed: () {
                      webProvider.createExcel(webProvider.memberDetailsList);

                    },
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Click here to Fetch Coordinator Excel",),
                    onPressed: () {
                      webProvider.fetchCoordinators(context);

                    },
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Click here to Download Coordinator Excel",),
                    onPressed: () {
                      webProvider.createExcelCoordinators(webProvider.coordinatorDetailsList);

                    },
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: ElevatedButton(
                //     child: const Text("Click here to Members Count",),
                //     onPressed: () {
                //       mainProvider.getAllState();
                //       callNext(MemberCountScreen(), context);
                //
                //     },
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("District Count setting",),
                    onPressed: () {
                      mainProvider.getAllState();
                      mainProvider.regReportStateCT.clear();
                      mainProvider.regReportdistNameCT.clear();
                      callNext(DistrictCountSettingPortal(), context);

                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Assembly Count setting",),
                    onPressed: () {
                      // mainProvider.getAddedUnit(state, district, assembly);
                      mainProvider.getAllState();
                      mainProvider.selectLoopStateCT.clear();
                      mainProvider.selectLoopDistrictCT.clear();
                      mainProvider.selectLoopAssemblyCT.clear();
                      callNext(AssemblyCountLoopScreen(), context);

                    },
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