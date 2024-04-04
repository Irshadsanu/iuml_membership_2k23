// import 'package:flutter/material.dart';
// import 'package:iuml_membership/Screens/add_member_methods_screen.dart';
// import 'package:iuml_membership/Screens/home_screen.dart';
// import 'package:iuml_membership/constants/my_colors.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
//
// class BottomNavigationScreen extends StatefulWidget {
//   String from,uid,userName;
//   String? state, district, assembly, panchayath,unit;
//     BottomNavigationScreen({super.key,
//      required this.from,
//      required this.uid,
//      required this.userName,
//      required this.state,
//      required this.district,
//      required this.assembly,
//
//      required this.panchayath,
//      required this.unit,});
//
//   @override
//   State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
//
// }
//
// class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
//
//
//   final controller = PersistentTabController(initialIndex: 0);
//   List <Widget> _buildScreen(){
//   return [
//     HomeScreen(uId: ''),
//     HomeScreen(uId: ''),
//     AddMemberMethodsScreen(),
//     HomeScreen(uId: ''),
//     HomeScreen(uId: ''),
//   ];
// }
//
//   List<PersistentBottomNavBarItem> _navBarItem(){
//     return [
//       PersistentBottomNavBarItem(iconSize: 25,contentPadding: 0,
//         icon: Image.asset("assets/Home.png",),
//         title: "Home",
//         textStyle: const TextStyle(fontSize: 12,color: Colors.black,fontFamily: "Poppins"),
//       ),
//       PersistentBottomNavBarItem(
//         icon: Image.asset("assets/committe.png",),contentPadding: 0,iconSize: 25,
//         title: "Committee",
//         textStyle: const TextStyle(fontSize: 5,color: Colors.black,fontFamily: "Poppins"),
//       ),
//       PersistentBottomNavBarItem(
//           icon: const Icon(Icons.add,size: 50,color: Colors.white,),
//           inactiveColorPrimary:myDarkGreen,inactiveColorSecondary: myDarkGreen
//       ),
//       PersistentBottomNavBarItem(
//         icon: Image.asset("assets/councilors.png"),
//         title: "Counselors",
//         textStyle: const TextStyle(fontSize: 12,color: Colors.black,fontFamily: "Poppins"),
//       ),
//       PersistentBottomNavBarItem(
//         icon: Image.asset("assets/profile.png"),
//         title: "Profile",
//         textStyle: const TextStyle(fontSize: 12,color: Colors.black,fontFamily: "Poppins"),
//       ),
//     ];
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       controller: controller,
//       screens: _buildScreen(),
//         items: _navBarItem(),
//
//       navBarHeight: 60,
//       backgroundColor: Colors.white,
//       decoration: NavBarDecoration(borderRadius: BorderRadius.circular(1),colorBehindNavBar: Colors.white),
//       navBarStyle: widget.from == "UNIT_LEVEL"?NavBarStyle.style15:NavBarStyle.style15,
//     );
//   }
// }

////

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iuml_membership/Constants/my_functions.dart';
import 'package:iuml_membership/Screens/Add_New_Member.dart';
import 'package:iuml_membership/Screens/add_coordinator_scren.dart';
import 'package:iuml_membership/Screens/add_member_methods_screen.dart';
import 'package:iuml_membership/Screens/committee_screen.dart';
import 'package:iuml_membership/Screens/coordinator_screen.dart';
import 'package:iuml_membership/Screens/cordinators_state_Report.dart';
import 'package:iuml_membership/Screens/counsilors_screen.dart';
import 'package:iuml_membership/Screens/home_screen.dart';
import 'package:iuml_membership/Screens/membership_requests_screen.dart';
import 'package:iuml_membership/Screens/registrationReportScreen.dart';
import 'package:iuml_membership/Screens/request_Pending_Page.dart';
import 'package:iuml_membership/constants/my_colors.dart';
import 'package:iuml_membership/providers/Main_Provider.dart';
import 'package:provider/provider.dart';

import 'DetailedReportScreen.dart';
import 'coordinator_DistrictLevel.dart';
import 'coordinator_UnitLevel.dart';
import 'cordinator_assemblyReport.dart';

class BottomNavigationScreen extends StatefulWidget {
  String from, uid, userName;
  String state, district, assembly, unit;
  String photo, phoneNumber, address,loginLevel;
  BottomNavigationScreen({
    super.key,
    required this.from,
    required this.uid,
    required this.userName,
    required this.state,
    required this.district,
    required this.assembly,
    required this.unit,
    required this.photo,
    required this.phoneNumber,
    required this.address,
    required this.loginLevel,
  });

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int selectedIndex = 0;

  @override
  void _onItemTapped(int index) {
    setState(() {
      MainProvider mainProvider =
          Provider.of<MainProvider>(context, listen: false);
      selectedIndex = index;
      print(index.toString()+' cnfrinjvcrgv  '+widget.from);
      if (index == 1) {
        mainProvider.selectedMembersFetchForCommitee(widget.state, widget.district, widget.assembly,widget.unit,widget.from);
        // mainProvider.getCommittee(
        //     widget.state, widget.district, widget.assembly, widget.unit);
        // mainProvider.getPaidMembers(
        //     widget.state, widget.district, widget.assembly, widget.unit);
        mainProvider.getUnitCommitees(
            widget.state, widget.district, widget.assembly, widget.unit,widget.from);
      } else if (index == 4) {
        _showBottomSheet(context,index);
        // mainProvider.getRequests(
        //     widget.state, widget.district, widget.assembly);
      }

      if (widget.from == "UNIT_LEVEL") {
        if (index == 4) {
          mainProvider.clearAddMember();
        }
        else if (index == 2) {
          print(' ijCNINCIC');
          mainProvider.fetchNominees(widget.from, widget.state, widget.district,
              widget.assembly, widget.unit);
          mainProvider.getPaidMembers( widget.state, widget.district,
              widget.assembly, widget.unit);
        }
      }else {
       if (index == 2) {
        print(' ijCNINCIC');
        mainProvider.fetchNominees(widget.from, widget.state, widget.district,
            widget.assembly, widget.unit);
      }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.state + "sd" + widget.district + "sd" + "sd" + widget.assembly);

    MainProvider mainProvider = Provider.of<MainProvider>(context);

    var screens = [
      HomeScreen(
        uId: widget.uid,
        from: widget.from,
        userName: widget.userName,
        state: widget.state,
        district: widget.district,
        assembly: widget.assembly,
        unit: widget.unit,
        PhoneNumber: widget.phoneNumber,
        photo: widget.photo,
        address: widget.address,
        loginLevel: widget.loginLevel,
      ),
      CommitteeScreen(
          uId: widget.uid,
          from: widget.from,
          state: widget.state,
          district: widget.district,
          assembly: widget.assembly,
          unit: widget.unit),
      CouncilorsScreen(
          from: widget.from,
          uId: widget.uid,
          state: widget.state,
          district: widget.district,
          assembly: widget.assembly,
          unit: widget.unit),
      // AddCoordinatorScreen(from: widget.from,state: widget.state,district: widget.district, assembly: widget.assembly,),
      CoordinatorScreen(
        from: widget.from,
        state: widget.state,
        district: widget.district,
        assembly: widget.assembly,
        unit: widget.unit,
        userName: widget.userName,
        phoneno: widget.phoneNumber,
        uId: widget.uid,photo: widget.photo,
        address: widget.address,
      coordinatorLevel: widget.loginLevel),
      HomeScreen(
        uId: widget.uid,
        from: widget.from,
        userName: widget.userName,
        state: widget.state,
        district: widget.district,
        assembly: widget.assembly,
        unit: widget.unit,
        PhoneNumber: widget.phoneNumber,
        photo: widget.photo,
        address: widget.address,
        loginLevel: widget.loginLevel,
      ),

      // widget.from == "ASSEMBLY_LEVEL"
      //     ? MembershipRequestsScreen(
      //         uId: widget.uid,
      //         state: widget.state,
      //         district: widget.district,
      //         assembly: widget.assembly,
      //       )
      //     : RequestPendingPage(
      //         wantToShow: true,
      //         name: widget.userName,
      //         address: widget.address,
      //         PhoneNumber: widget.phoneNumber,
      //         iD: widget.uid,
      //         photo: widget.photo,
      //   type: "",
      //       ),
    ];
    var unitScreens = [
      HomeScreen(
          uId: widget.uid,
          from: widget.from,
          userName: widget.userName,
          state: widget.state,
          district: widget.district,
          assembly: widget.assembly,
          unit: widget.unit,
          PhoneNumber: widget.phoneNumber,
          photo: widget.photo,
          address: widget.address,
        loginLevel: widget.loginLevel,),
      CommitteeScreen(
          uId: widget.uid,
          from: widget.from,
          state: widget.state,
          district: widget.district,
          assembly: widget.assembly,
          unit: widget.unit),
      CouncilorsScreen(
          from: widget.from,
          uId: widget.uid,
          state: widget.state,
          district: widget.district,
          assembly: widget.assembly,
          unit: widget.unit),
      CoordinatorScreen(
        from: widget.from,
          state: widget.state,
          district: widget.district,
          assembly: widget.assembly,
          unit: widget.unit,
          userName: widget.userName,
          phoneno: widget.phoneNumber,
          uId: widget.uid,photo: widget.photo,address: widget.address,
          coordinatorLevel: widget.loginLevel,)
      ////
      // RequestPendingPage(
      //     wantToShow: true,
      //     name: widget.userName,
      //     address: widget.address,
      //     PhoneNumber: widget.phoneNumber,
      //     iD: widget.uid,
      //     photo: widget.photo,
      //   type: "YES",
      // ),
      ////
      // AddNewMember(
      //   from: widget.from,
      //   state: widget.state,
      //   district: widget.district,
      //   assembly: widget.assembly,
      //   unit: widget.unit,
      //   uid: widget.uid,
      //   idStatus: "Nil",
      //   proffetion: widget.phoneNumber,
      //   photo: widget.photo,
      //   address: widget.address,
      //   type: 'New',
      //   MemberId: "",
      //   userName: widget.userName,
      // )
    ];
    return Scaffold(
      backgroundColor: mainColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      Consumer<MainProvider>(
        builder: (context,val,child) {
          return widget.from=="UNIT_LEVEL"&&val.stateMemberLock?
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3.0,
              ),
            ),
            child: FloatingActionButton(
              onPressed: (){
                mainProvider.clearAddMember();
                mainProvider.getProfessions();
                mainProvider.getEducations();

                callNext(AddMemberMethodsScreen( from: widget.from,
                  state: widget.state,
                  district: widget.district,
                  assembly: widget.assembly,
                  unit: widget.unit,
                  uid: widget.uid,
                  proffetion: widget.phoneNumber,
                  photo: widget.photo,
                  address: widget.address,
                  userName: widget.userName,
                  loginLevel: widget.loginLevel,
                ), context);

                // callNext( AddNewMember(
                //   from: widget.from,
                //   state: widget.state,
                //   district: widget.district,
                //   assembly: widget.assembly,
                //   unit: widget.unit,
                //   uid: widget.uid,
                //   idStatus: "Nil",
                //   proffetion: widget.phoneNumber,
                //   photo: widget.photo,
                //   address: widget.address,
                //   type: 'New',
                //   MemberId: "",
                //   userName: widget.userName,
                //   paymentStatus: '',
                //   loginLevel: widget.loginLevel,
                // ), context);
                },
              backgroundColor: myDarkGreen,
              foregroundColor: Colors.white,
              child: const Icon(Icons.add,size: 35,color: Colors.white,),
            ),
          ):const SizedBox();
        }
      ),
      body: widget.from == "UNIT_LEVEL"
          ? unitScreens[selectedIndex]
          : screens[selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 13, right: 13, bottom: 8),
        child: SizedBox(
          height: 70,
          child: Consumer<MainProvider>(builder: (context, value, child) {
            return ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(23),
                topLeft: Radius.circular(23),
                bottomLeft: Radius.circular(23),
                bottomRight: Radius.circular(23),
              ),
              child: widget.from == "UNIT_LEVEL"
                  // && value.isStateRegLock
                  ? BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      currentIndex: selectedIndex,
                      onTap: _onItemTapped,
                      backgroundColor: myDarkGreen,
                      selectedItemColor: clEB7600,
                      unselectedItemColor: Colors.white,
                      unselectedLabelStyle: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.red),
                      selectedLabelStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: clEB7600),
                      items: [
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            'assets/Home.png',
                            height: 25,
                            width: 25,
                          ),
                          activeIcon: Image.asset(
                            'assets/unitHome.png',
                            height: 25,
                            width: 25,
                          ),
                          label: "Home",
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            'assets/committe.png',
                            height: 25,
                            width: 25,
                          ),
                          activeIcon: Image.asset(
                            'assets/unitCommittee.png',
                            height: 25,
                            width: 25,
                          ),
                          label: "Committee",
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            'assets/councilors.png',
                            height: 25,
                            width: 25,
                          ),
                          activeIcon: Image.asset(
                            'assets/activeCounsilor.png',
                            height: 25,
                            width: 25,
                          ),
                          label: "Councilor\nNominees",
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            'assets/coordinator.png',
                            height: 25,
                            width: 25,
                          ),
                          activeIcon: Image.asset(
                            'assets/activeCooordinator.png',
                            height: 25,
                            width: 25,
                          ),
                          label: "Coordinator",
                        ),
                        // BottomNavigationBarItem(
                        //   icon: Image.asset(
                        //     'assets/addMember.png',
                        //     height: 25,
                        //     width: 25,
                        //   ),
                        //   activeIcon: Image.asset(
                        //     'assets/activeAddMember.png',
                        //     height: 25,
                        //     width: 25,
                        //   ),
                        //   label: "Add Member",
                        // ),
                      ],
              )
                  // : widget.from == "UNIT_LEVEL" &&
                  //         value.isStateRegLock == false
                  //     ? BottomNavigationBar(
                  //         type: BottomNavigationBarType.fixed,
                  //         currentIndex: selectedIndex,
                  //         onTap: _onItemTapped,
                  //         backgroundColor: myDarkGreen,
                  //         selectedItemColor: clEB7600,
                  //         unselectedItemColor: Colors.white,
                  //         unselectedLabelStyle: const TextStyle(
                  //             fontFamily: "Poppins",
                  //             fontSize: 10,
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.red),
                  //         selectedLabelStyle: TextStyle(
                  //             fontFamily: "Poppins",
                  //             fontSize: 10,
                  //             fontWeight: FontWeight.w600,
                  //             color: clEB7600),
                  //         items: [
                  //           BottomNavigationBarItem(
                  //             icon: Image.asset(
                  //               'assets/Home.png',
                  //               height: 25,
                  //               width: 25,
                  //             ),
                  //             activeIcon: Image.asset(
                  //               'assets/unitHome.png',
                  //               height: 25,
                  //               width: 25,
                  //             ),
                  //             label: "Home",
                  //           ),
                  //           BottomNavigationBarItem(
                  //             icon: Image.asset(
                  //               'assets/committe.png',
                  //               height: 25,
                  //               width: 25,
                  //             ),
                  //             activeIcon: Image.asset(
                  //               'assets/unitCommittee.png',
                  //               height: 25,
                  //               width: 25,
                  //             ),
                  //             label: "Committee",
                  //           ),
                  //           BottomNavigationBarItem(
                  //             icon: Image.asset(
                  //               'assets/councilors.png',
                  //               height: 25,
                  //               width: 25,
                  //             ),
                  //             activeIcon: Image.asset(
                  //               'assets/activeCounsilor.png',
                  //               height: 25,
                  //               width: 25,
                  //             ),
                  //             label: "Councilor\nNominees",
                  //           ),
                  //           BottomNavigationBarItem(
                  //             icon: Image.asset(
                  //               'assets/coordinator.png',
                  //               height: 25,
                  //               width: 25,
                  //             ),
                  //             activeIcon: Image.asset(
                  //               'assets/activeCooordinator.png',
                  //               height: 25,
                  //               width: 25,
                  //             ),
                  //             label: "Coordinator",
                  //           ),
                  //         ],
                  //       )
                      : BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          currentIndex: selectedIndex,
                          onTap: _onItemTapped,
                          backgroundColor: myDarkGreen,
                          selectedItemColor: clEB7600,
                          unselectedItemColor: Colors.white,
                          unselectedLabelStyle: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                          selectedLabelStyle: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 10,
                              fontWeight: FontWeight.w700),
                          items: [
                            BottomNavigationBarItem(
                              icon: Image.asset(
                                'assets/Home.png',
                                height: 25,
                                width: 25,
                              ),
                              activeIcon: Image.asset(
                                'assets/unitHome.png',
                                height: 25,
                                width: 25,
                              ),
                              label: "Home",
                            ),
                            BottomNavigationBarItem(
                              icon: Image.asset(
                                'assets/committe.png',
                                height: 25,
                                width: 25,
                              ),
                              activeIcon: Image.asset(
                                'assets/unitCommittee.png',
                                height: 25,
                                width: 25,
                              ),
                              label: "Committee",
                            ),
                            BottomNavigationBarItem(
                              icon: Image.asset(
                                'assets/councilors.png',
                                height: 25,
                                width: 25,
                              ),
                              activeIcon: Image.asset(
                                'assets/activeCounsilor.png',
                                height: 25,
                                width: 25,
                              ),
                              label: "Councilors",
                            ),
                            BottomNavigationBarItem(
                              icon: Image.asset(
                                'assets/coordinator.png',
                                height: 28,
                                width: 28,
                              ),
                              activeIcon: Image.asset(
                                'assets/activeCooordinator.png',
                                height: 30,
                                width: 30,
                              ),
                              label: "Coordinators",
                            ),
                           BottomNavigationBarItem(
                                    icon:
                                    Image.asset(
                                      'assets/menu.png',
                                      height: 25,
                                      width: 25,
                                    ),
                                    activeIcon: Image.asset(
                                      'assets/activeMenu.png',
                                      height: 25,
                                      width: 25,
                                    ),
                                    label: "Menu",
                                  )
                          ],
                        ),
            );
          }),
        ),
      ),
    );
  }
  void _showBottomSheet(BuildContext context,int index) {
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Container(
            height: 350,
            decoration: BoxDecoration(
              // border: Border.all(width: 0.25, color: const Color(0xFFD0D0D0)),
              // borderRadius: BorderRadius.circular(73),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Bottom sheet title
                const Center(
                  child: Text(
                    'Menu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 26),
                // First row: Profile
                InkWell(
                  onTap: (){
                    callNext(RequestPendingPage(
                                wantToShow: true,
                                name: widget.userName,
                                address: widget.address,
                                PhoneNumber: widget.phoneNumber,
                                iD: widget.uid,
                                photo: widget.photo, type: "YES", status: '',state: widget.state,
                              ), context);
                  },
                  child: Row(
                    children: const [
                      SizedBox(width: 12),
                      Text(
                        'Profile',
                        style: TextStyle(fontSize: 16,fontFamily: "Poppins",),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                      SizedBox(width: 12),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                // Divider
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                SizedBox(height: 10),
                Consumer<MainProvider>(
                  builder: (context,value,child) {
                    return InkWell(
                      onTap: (){
                        MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
                        mainProvider. regReportdistNameCT.clear();
                        mainProvider. regReportStateCT.clear();
                        mainProvider.regReportassmblyNameCT.clear();
                        mainProvider.fetchMasterData(widget.from,widget.state,widget.district,widget.assembly);
                          if(widget.from=='STATE_LEVEL'){
                            value.regReportStateCT.text=widget.state;
                          }else if(widget.from=='DISTRICT_LEVEL'){
                            value.regReportStateCT.text=widget.state;
                            value.regReportdistNameCT.text=widget.district;
                          }else if(widget.from=='ASSEMBLY_LEVEL'){
                            value.regReportStateCT.text=widget.state;
                            value.regReportdistNameCT.text=widget.district;
                            value.regReportassmblyNameCT.text=widget.assembly;
                          }
                        callNext(RegistrationReportScreen(
                          state: widget.state,
                          from: widget.from,
                          assembly:widget. assembly,
                          distrct: widget.district,
                        ), context);
                      },
                      child: Row(
                        children: const [
                          SizedBox(width: 12),
                          Text(
                            'Registration Report',
                            style: TextStyle(fontSize: 16, fontFamily: "Poppins",),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                          SizedBox(width: 12),
                        ],
                      ),
                    );
                  }
                ),

                SizedBox(height: 10),

                // Divider
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                SizedBox(height: 10),
                widget.from=="NATIONAL_LEVEL" ||
                    widget.from=='STATE_LEVEL' ||
                    widget.from=='DISTRICT_LEVEL'  ||
                    widget.from=='ASSEMBLY_LEVEL' ?
                Column(
                  children: [
                    InkWell(
                      onTap: (){
                        mainProvider.addMasterCordinatorData(widget.from,widget.state,widget.district,widget.assembly);
                        mainProvider.searchController.text='';
                        if( widget.from=="NATIONAL_LEVEL"){
                          callNext(CoordinatorsStateReportScreen(from: widget.from,state: widget.state,
                              district: widget.district,assembly: widget.assembly), context);
                        }else if(widget.from=='STATE_LEVEL'){
                          mainProvider.getAllDistrict(widget.state);
                          callNext(CoordinatorsDistrictReportScreen(state: widget.state,from: 'DISTRICT_LEVEL'), context);
                        }else if(widget.from=='DISTRICT_LEVEL'){
                          mainProvider.getAllAssemblyForCoordinatorss( widget.state, widget.district);
                          mainProvider.getAllAssembly( widget.state, widget.district);
                          callNext(CoordinatorAssemblyLevelReport(state: widget.state,district: widget.district,from: 'ASSEMBLY_LEVEL'), context);
                        }else if(widget.from=='ASSEMBLY_LEVEL'){
                         mainProvider.getAddedUnit(widget.state,widget.district,widget.assembly);
                          callNext(CoordinatorUnitLevelScreen(district: widget.district,state: widget.state,assembly: widget.assembly,from: 'UNIT_LEVEL'), context);

                        }

                      },
                      child: Row(
                        children: const [
                          SizedBox(width: 12),
                          Text(
                            'Coordinator Report',
                            style: TextStyle(fontSize: 16, fontFamily: "Poppins",),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                          SizedBox(width: 12),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Divider
                    const Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ],
                ):SizedBox(),
                widget.from=="NATIONAL_LEVEL" ||
                    widget.from=='STATE_LEVEL' ||
                    widget.from=='DISTRICT_LEVEL'  ||
                    widget.from=='ASSEMBLY_LEVEL' ?
                Column(
                  children: [
                    InkWell(
                      onTap: (){
                        mainProvider.stateNameCT.clear();
                        mainProvider.distNameCT.clear();
                        mainProvider.assmblyNameCT.clear();
                        mainProvider.onReportLoader();
                        callNext(DetailedReportScreen(from: widget.from), context);
                        if( widget.from=="NATIONAL_LEVEL"){
                          mainProvider.fetchMasterCoordinatorsDetails(widget.state,widget.district,widget.assembly,widget.from);
                        }else if(widget.from=='STATE_LEVEL'){
                          mainProvider.stateNameCT.text=widget.state;
                          mainProvider.fetchMasterCoordinatorsDetails(widget.state,widget.district,widget.assembly,widget.from);
                          mainProvider.getAllDistrict(widget.state);
                        }else if(widget.from=='DISTRICT_LEVEL'){
                          mainProvider.stateNameCT.text=widget.state;
                          mainProvider.distNameCT.text=widget.district;
                          mainProvider.getAllAssembly(widget.state,widget.district);
                          mainProvider.fetchMasterCoordinatorsDetails(widget.state,widget.district,widget.assembly,widget.from);
                        }else if(widget.from=='ASSEMBLY_LEVEL'){
                          mainProvider.stateNameCT.text=widget.state;
                          mainProvider.distNameCT.text=widget.district;
                          mainProvider.assmblyNameCT.text=widget.assembly;
                          mainProvider.fetchMasterCoordinatorsDetails(widget.state,widget.district,widget.assembly,widget.from);
                        }
                      },
                      child: Row(
                        children: const [
                          SizedBox(width: 12),
                          Text(
                            'Coordinator Performance Report',
                            style: TextStyle(fontSize: 16, fontFamily: "Poppins",),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                          SizedBox(width: 12),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Divider
                    const Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ],
                ):SizedBox(),

                // SizedBox(height: 10),


                // SizedBox(height: 26),
                widget.from=="STATE_LEVEL"?
                Column(
                  children: [
                    InkWell(
                      onTap: (){
                        MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

                        mainProvider.getRequests(widget.state);

                        callNext(MembershipRequestsScreen(
                                    uId: widget.uid,
                                    state: widget.state,
                                    district: widget.district,
                                    assembly: widget.assembly,
                                  ), context);
                      },
                      child: Row(
                        children: const [
                          SizedBox(width: 12),
                          Text(
                            'Registration Request',
                            style: TextStyle(fontSize: 16, fontFamily: "Poppins",),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                          SizedBox(width: 12),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    const Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ],
                ):SizedBox(),


                SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
