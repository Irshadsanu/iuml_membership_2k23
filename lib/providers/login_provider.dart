import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iuml_membership/Screens/request_Pending_Page.dart';
import 'package:provider/provider.dart';
import '../Screens/bottom_navigation.dart';
import '../Screens/login_members_list.dart';
import '../constants/my_functions.dart';
import 'Main_Provider.dart';

class LoginProvider extends ChangeNotifier{
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? packageName;

  Future<void> userAuthorized(String? phoneNumber, BuildContext context) async {
    String loginUserLevel='';
    String loginUsername='';
    String userId='';
    String memberId='';
    String phone = "";
    String name = "";
    String photo = "";
    String address = "";
    String coordinatorNumber = "";
    String coordinatorName = "";
    String coordinatorPhoto = "";
    String coordinatorAddress = "";
    String state = "";
    String district = "";
    String assembly = "";
    String unit = "";
    String uid="";

    print("yasar$phoneNumber");
    try {
      var phone = phoneNumber!;
      print("ahhhhhhhhhhhhh$phone");
      MainProvider mainProvider =
      Provider.of<MainProvider>(context, listen: false);

      db.collection("USERS").where("PHONE_NUMBER",isEqualTo:phone).get().then((value) async {
        if (value.docs.isNotEmpty) {

          for (var element in value.docs) {
            Map<dynamic, dynamic> map = element.data();

            if(!map.containsValue("MEMBER_LEVEL")){

              loginUsername = map['NAME'].toString();
              // userId = element.id;
              userId=map["USER_ID"].toString();
              loginUserLevel = map["LEVEL"].toString();
               state = map["STATE"] ?? "NIL";
               district = map["DISTRICT"] ?? "NIL";
               assembly = map["ASSEMBLY"] ?? "NIL";
              // var panchayath = map["PANCHAYATH"] ?? "NIL";
               unit = map["UNIT"] ?? "NIL";


               uid = userId;

              await db.collection("COORDINATORS").where("COORDINATOR_ID",isEqualTo:uid).get().then((value2){
                if(value2.docs.isNotEmpty){
                  for (var e in value2.docs) {
                    Map<dynamic, dynamic> coordinatorMap = e.data();
                    coordinatorNumber= coordinatorMap["PHONE_NUMBER"].toString();
                    coordinatorName = coordinatorMap["NAME"].toString();
                    coordinatorAddress = coordinatorMap["ADDRESS"].toString();
                    coordinatorPhoto = coordinatorMap["PHOTO"].toString();
                  }
                }
              });

              switch (loginUserLevel) {
                case "NATIONAL_LEVEL":
                  mainProvider.getAllMembersCount();
                  // mainProvider.getMembersCount(state, district, assembly, unit,"NATIONAL_LEVEL");
                  // mainProvider.getUnPaidMembersCount(state, district, assembly, unit,"NATIONAL_LEVEL");
                  print("yeee");
                  mainProvider.getAllState();
                  mainProvider.getCoordinators();
                  // mainProvider.checkStateAdditionLock("NATIONAL_LEVEL");
                  callNextReplacement(BottomNavigationScreen(from: 'NATIONAL_LEVEL', uid: userId, userName: loginUsername, state: '', district: '', assembly: '', unit: '', photo: coordinatorPhoto, phoneNumber: coordinatorNumber, address: coordinatorAddress,loginLevel: loginUserLevel), context);
                  break;

                case "STATE_LEVEL":
                  print("yeee1");
                  mainProvider.getPaidMemberCountState(state);
                  // mainProvider.getMembersCount(state, district, assembly, unit,"STATE_LEVEL");
                  // mainProvider.getUnPaidMembersCount(state, district, assembly, unit,"STATE_LEVEL");
                  mainProvider.getAllDistrict(state);
                  // mainProvider.chckStateRegLock(state);
                  mainProvider.getStateCoordinators(state);
                  mainProvider.checkStateAdditionLock(state);
                  mainProvider.getRequests(state,);
                  // mainProvider.fetchNominees("STATE_LEVEL", state, district, assembly, unit);
                  callNextReplacement(BottomNavigationScreen(from: 'STATE_LEVEL', uid: userId, userName: loginUsername, state: state, district: '', assembly: '', unit: '', photo: coordinatorPhoto, phoneNumber: coordinatorNumber, address: coordinatorAddress,loginLevel: loginUserLevel), context);
                  break;

                case "DISTRICT_LEVEL":
                // mainProvider.chckStateRegLock(state);
                  mainProvider.getPaidMemberCountDistrict(district);
                //   mainProvider.getMembersCount(state, district, assembly, unit,"DISTRICT_LEVEL");
                //   mainProvider.getUnPaidMembersCount(state, district, assembly, unit,"DISTRICT_LEVEL");
                  mainProvider.getAllAssembly(state, district);
                  mainProvider.getDistrictCoordinators(state, district);
                  // mainProvider.fetchNominees("DISTRICT_LEVEL", state, district, assembly, unit);
                  mainProvider.checkStateAdditionLock(state);

                  callNextReplacement(BottomNavigationScreen(from: 'DISTRICT_LEVEL', uid: userId, userName: loginUsername, state: state, district: district, assembly: '', unit: '', photo: coordinatorPhoto, phoneNumber: coordinatorNumber, address: coordinatorAddress,loginLevel: loginUserLevel), context);
                  break;

                case "ASSEMBLY_LEVEL":
                // mainProvider.chckStateRegLock(state);
                  mainProvider.getPaidMemberCountAssembly(district,assembly);
                //   mainProvider.getMembersCount(state, district, assembly, unit,"ASSEMBLY_LEVEL");
                //   mainProvider.getUnPaidMembersCount(state, district, assembly, unit,"ASSEMBLY_LEVEL");
                  mainProvider.getAddedUnit(state, district, assembly);
                  mainProvider.getAssemblyCoordinators(state, district, assembly);
                  // mainProvider.fetchNominees("ASSEMBLY_LEVEL", state, district, assembly, unit);
                  // mainProvider.getRequests(state, district, assembly);
                  mainProvider.checkStateAdditionLock(state);

                  callNextReplacement(BottomNavigationScreen(from: 'ASSEMBLY_LEVEL', uid: userId, userName: loginUsername, state: state, district: district, assembly: assembly, unit: '', photo: coordinatorPhoto, phoneNumber: coordinatorNumber, address: coordinatorAddress,loginLevel: loginUserLevel), context);
                  break;

              // case "PANCHAYATH_LEVEL":
              //   mainProvider.getAddedUnit(state, district, assembly, panchayath);
              //   mainProvider.fetchNominees("PANCHAYATH_LEVEL", state, district, assembly, panchayath, unit);
              //   callNextReplacement(BottomNavigationScreen(from: 'PANCHAYATH_LEVEL', uid: userId, userName: loginUsername, state: state, district: district, assembly: assembly, panchayath: panchayath, unit: '', photo: photo, proffetion: proffetion,address: address), context);
              //   break;

                case "UNIT_LEVEL":
                // mainProvider.chckStateRegLock(state);

                  mainProvider.getMembersCount(state, district, assembly, unit,"UNIT_LEVEL");
                  mainProvider.getUnPaidMembersCount(state, district, assembly, unit,"UNIT_LEVEL");
                  mainProvider.getUnitCoordinators(state, district, assembly,unit);
                  mainProvider.getMembers(state, district, assembly, unit);
                  mainProvider.getUnpaidMembers(state, district, assembly, unit);
                  mainProvider.getPaidMembers(state,district,assembly,unit);
                  mainProvider.checkStateAdditionLock(state);

                  // mainProvider.fetchNominees('UNIT_LEVEL', state, district, assembly, unit);
                  callNextReplacement(BottomNavigationScreen(from: 'UNIT_LEVEL', uid: userId, userName: loginUsername, state: state, district: district, assembly: assembly, unit: unit,  photo: coordinatorPhoto, phoneNumber: coordinatorNumber, address: coordinatorAddress,loginLevel: loginUserLevel), context);
                  break;

                case "MEMBER_LEVEL":
                  print(photo + "PJFIFOFOFO");
                  print("jxzjzjjz" + uid);
                  await db.collection("MEMBERS").where("MEMBER_ID", isEqualTo: uid).where("STATUS", isEqualTo: "PAID").get().then((value2) {
                    if (value2.docs.isNotEmpty) {
                      for (var element2 in value2.docs) {
                        Map<dynamic, dynamic> map2 = element2.data();
                        memberId = map2["MEMBER_ID"].toString();
                        phone = map2["PHONE_NUMBER"].toString();
                        photo = map2["PHOTO"].toString();
                        name = map2["NAME"].toString();
                        address = map2["ADDRESS"].toString();
                        if(!map2.containsKey("REQUEST_STATUS")){
                          print("sdfghjkl");
                          callNextReplacement(RequestPendingPage(wantToShow: true, name: name, address: address, PhoneNumber: phone, photo: photo,iD: memberId,type: "YES", status: '', state: state,), context);

                        }else if(map2["REQUEST_STATUS"] == "APPROVE"){
                          print("irshad");

                          callNextReplacement(RequestPendingPage(wantToShow: true, name: name, address: address, PhoneNumber: phone, photo: photo,iD: memberId,type: "YES", status: '',state: state), context);
                        }else {
                          print("hiba");
                          callNextReplacement(RequestPendingPage(wantToShow: false, name: name, address: address, PhoneNumber: phoneNumber, photo: photo,iD: memberId,type: "YES", status: '',state: state), context);
                        }
                        print("member home screen");
                        break;
                      }
                    }else{
                      callNextReplacement(RequestPendingPage(wantToShow: false, name: name, address: address, PhoneNumber: phoneNumber, photo: photo,iD: memberId,type: "YES", status: 'UNPAID',state: state), context);
                    }
                  });
              }

            }
            else{
              callNextReplacement(LoginMembersList(phone: phone), context);

            }







                    
            if (kDebugMode) {
                  print("${uid}YYYYYYYYYYYYYY");
                }
             }
          }
        else {
          const snackBar = SnackBar(
              backgroundColor: Colors.black,
              duration: Duration(milliseconds: 3000),
              content: Text("Sorry , You don't have any access",
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } catch (e) {


      // const snackBar = SnackBar(
      //     backgroundColor: Colors.white,
      //     duration: Duration(milliseconds: 3000),
      //     content: Text("Sorry , Some Error Occurred",
      //       textAlign: TextAlign.center,
      //       softWrap: true,
      //       style: TextStyle(
      //           fontSize: 18,
      //           color: Colors.black,
      //           fontWeight: FontWeight.bold),
      //     ));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}