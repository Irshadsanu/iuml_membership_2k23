import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iuml_membership/Constants/my_functions.dart';
import 'package:iuml_membership/Models/committee_model.dart';
import 'package:iuml_membership/Screens/howToUse_Screen.dart';
import 'package:iuml_membership/constants/my_colors.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Models/MasterCoordinatorModel.dart';
import '../Models/Member_Model_Class.dart';
import '../Models/committee_designation_model.dart';
import '../Models/coordinator_model.dart';
import '../Models/counsilor_nominee_model.dart';
import '../Models/languageModel.dart';
import '../Models/masterReportModel.dart';
import '../Models/panchayath_model.dart';
import '../Models/committeeList_model.dart';
import '../Models/request_membership_model.dart';
import '../Screens/request_Pending_Page.dart';
import '../Screens/update.dart';
import '../deviceinfo.dart';
import '../state_model.dart';
import 'package:intl/intl.dart';

import '../timeservice.dart';
import '../timestampmodel.dart';
import 'donation_provider.dart';

class MainProvider extends ChangeNotifier{

  final DatabaseReference mRootReference = FirebaseDatabase.instance.ref();
  firebase_storage.Reference ref = FirebaseStorage.instance.ref("ItemImages");
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  int indextab  = 0;
  TextEditingController unpaidSearchController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  bool selected= false;
  int selectedIndex=0;
  int initialIndex = 0;

  int allMembers = 0 ;
  int allUnPaidMembers = 0;
  int unpaidMembers = 0;
  bool isStateRegLock=false;
  List<DistrictFilterModel> assmblyListCounts=[];

  bool memberLoader = false;


////add member
  TextEditingController memberVoterId = TextEditingController();
  TextEditingController memberPhoneNumber = TextEditingController();
  TextEditingController memberName = TextEditingController();
  TextEditingController memberHouseName = TextEditingController();
  TextEditingController memberAddress = TextEditingController();
  TextEditingController memberPincode = TextEditingController();
  TextEditingController memberDob = TextEditingController();
  TextEditingController memberProfession = TextEditingController();
  TextEditingController memberState = TextEditingController();
  TextEditingController memberDistrict = TextEditingController();
  TextEditingController memberAssembly = TextEditingController();
  TextEditingController memberPanchayath = TextEditingController();
  TextEditingController memberUnit = TextEditingController();
  TextEditingController memberEducation = TextEditingController();
  TextEditingController memberIdCt = TextEditingController();
  TextEditingController stateNameCT = TextEditingController();
  TextEditingController distNameCT = TextEditingController();
  TextEditingController assmblyNameCT = TextEditingController();

///add coordinator
  TextEditingController coordinatorName = TextEditingController();
  TextEditingController coordinatorPhone = TextEditingController();
  TextEditingController coordinatorAddress = TextEditingController();
  TextEditingController coordinatorUnit = TextEditingController();
  TextEditingController coordinatorPanchayath = TextEditingController();
  TextEditingController coordinatorAssembly = TextEditingController();
  TextEditingController coordinatorDistrict = TextEditingController();
  TextEditingController coordinatorState = TextEditingController();

  TextEditingController regReportStateCT = TextEditingController();
  TextEditingController regReportdistNameCT = TextEditingController();
  TextEditingController regReportassmblyNameCT = TextEditingController();


  String dropdownValue = 'Committee Position';
  String dropdownValue1 = '';
  List<String>committeeList=["Committee Position","Coordinator","Secretary","President","Vice President"];
  List<CoordinatorModel> coordinatorList = [];
  List<CoordinatorModel> coordinatorStateList = [];
  List<CoordinatorModel> coordinatorDistrictList = [];
  List<CoordinatorModel> coordinatorAssemblyList = [];
  List<CoordinatorModel> coordinatorUnitList = [];
  List<masterCordinatorModel>masterCordinatorList=[];
  List<MasterCoordinatorDetailsModel>MasterCoordinatorDetailsList=[];
  List<MasterCoordinatorDetailsModel>FilterMasterCoordinatorDetailsList=[];

  String nameValue= 'Member Name';

  bool alreadyNumberExist=false;
  bool reportDetailsLoader=false;

  TextEditingController committeeNameCT = TextEditingController();
  TextEditingController committeeHouseNameCT = TextEditingController();
  TextEditingController committeePhoneCT = TextEditingController();
  TextEditingController committeeAddressCT = TextEditingController();


  TextEditingController panchayathCT = TextEditingController();
  TextEditingController unitCT = TextEditingController();

  List<StateModel> allStateDistrictAssemblyList=[];
  List<String> stateList=[];
  List<String> listForSearch=[];
  List<String> districtList=[];
  List<String> assemblyList=[];
  List<DistrictFilterModel> assemblyListForReport=[];
  List<DistrictFilterModel> filterassemblyListForReport=[];
  List<String> listForSearchState=[];
  List<String> listForSearchUnit=[];
  List<String> listForSearchAssembly=[];
  List<String> listForSearchDistrict=[];

  List<String> panchayathList=[];
  List<String> unitList=[];
  List<MemberModel> memberModelList = [];
  List<MemberModel> filterMemberModelList = [];
  List<MemberModel> unPaidMemberModelList = [];
  List<MemberModel> filterUnPaidMemberModelList = [];
  List<MemberModel> selectedUnPaidMemberModelList = [];
  List<MemberModel> unSelectedUnPaidMemberModelList = [];


  List<CounsilorNomineeModel> selectCommiteeList = [];

  List<CounsilorNomineeModel> paidMemberModelList = [];
  List<CounsilorNomineeModel> selectedUnitNomineeModelList = [];
  List<CounsilorNomineeModel> unSelectedUnitNomineeModelList = [];
  List<CounsilorNomineeModel> selectedNomineeModelList = [];
  List<CounsilorNomineeModel> unSelectedNomineeModelList = [];

  List<CounsilorNomineeModel> unitNominees= [];
  List<CounsilorNomineeModel> assemblyNominees= [];
  List<CounsilorNomineeModel> assemblyNomineesNEW= [];
  List<CounsilorNomineeModel> districtNominees= [];
  List<CounsilorNomineeModel> stateNomineesNew= [];
  List<CounsilorNomineeModel> stateNominees= [];
  List<CounsilorNomineeModel> nationalNominees= [];

  List<CounsilorNomineeModel> searchNationalNominees= [];
  List<CounsilorNomineeModel> searchStateNominees= [];
  List<CounsilorNomineeModel> searchDistrictNominees= [];
  List<CounsilorNomineeModel> searchAssemblyNominees= [];
  List<CounsilorNomineeModel> searchUnitNominees= [];


  List<CommitteeModel> memberNameList = [];
  List<CommitteeListModel> committeeMembersList = [];

  // List<PanchayathModel> selectPanchayathList=[];
  List<UnitModel> selectUnitList=[];
  List<MasterReportModel> masterModelList=[];
  List<MasterReportModel> filterMasterModelList=[];
  String requestMemberState='';
  String requestMemberDistrict='';
  String requestMemberAssembly='';
  // String requestMemberPanchayath='';
  String requestMemberUnit='';


  TextEditingController TypeIdCt = TextEditingController();
  List<String> professionList = [];
  List<String> educationList = [];
  List<String> designationList = ["President","Secretary","Vice President","Vice President","Vice President","Vice President","Vice Precident"];


  int memberAge = 0 ;
  var outputDayNode = DateFormat('d/MM/yyy');
  DateTime birthDate = DateTime.now();
  final ImagePicker picker = ImagePicker();
  final ImagePicker picker1 = ImagePicker();
  File? fileimage;
  File? voterfileImage;
  File? coordinatorImage;
  String imageUrl = "";
  String imageUrl1 = "";
  String coordinatorImageUrl = "";

  String month = "MM";
  String day = "dd";
  String year = "YYYY";

  String selectedMemberId="";
  List<CommitteeDesignationModel> committeeDesignationModelList = [];

  List<RequestMembershipModel> requestMembersList=[];
  List<RequestMembershipModel> filterRequestMembersList=[];

  int memberAmount=0;
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  String contactNumber='';

  String mName='';
  String mPhone='';

  ///loop assemblyCount
  TextEditingController selectLoopStateCT = TextEditingController();
  TextEditingController selectLoopDistrictCT = TextEditingController();
  TextEditingController selectLoopAssemblyCT = TextEditingController();



  MainProvider(){
    getAllStateDetailsFromJson();
    getAppVersion();
  }



  late TabController tabController;

  String? gender = '';

    void tabIndex(int value){
      indextab = value;
      notifyListeners();
      print(indextab);
    }



  void showSelectionStatus(BuildContext context,int index,String id) {
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    // selectedUnPaidMemberModelList.clear();
    // unSelectedUnPaidMemberModelList.clear();
    memberAmount=donationProvider.membershipAmount;
print("njksdnfksdfasads"+index.toString()+id);
      unPaidMemberModelList[index].selected = !unPaidMemberModelList[index].selected;
      if (unPaidMemberModelList[index].selected == true) {
        // selectedUnPaidMemberModelList.add(MemberModel('', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', true));
        selectedUnPaidMemberModelList.add(unPaidMemberModelList[index]);
        // memberAmount = memberAmount*selectedUnPaidMemberModelList.length ;
        print(memberAmount.toString()+"Gootto");
        print(selectedUnPaidMemberModelList.length.toString()+"ufufu");
        notifyListeners();
      }else {
        // selectedUnPaidMemberModelList.removeAt(index);
        unSelectedUnPaidMemberModelList.add(unPaidMemberModelList[index]);
        // memberAmount = memberAmount*selectedUnPaidMemberModelList.length ;
        print(unSelectedUnPaidMemberModelList.length.toString()+"e9889ee");
        notifyListeners();
      }
    memberAmount = memberAmount!*unPaidMemberModelList.where((element) => element.selected==true).length ;


    for(var i in unPaidMemberModelList){
        print("unPaidMemberModelList"+i.name+"  "+i.selected.toString());
      }
      for(var j in selectedUnPaidMemberModelList){
        print("selectedUnPaidMemberModelList"+j.name+"  "+j.selected.toString());
      }
notifyListeners();
  }

  bool selectAll=false;
  void selectAllMembers(BuildContext context,int index){
    DonationProvider donationProvider =
    Provider.of<DonationProvider>(context, listen: false);
    // unPaidMemberModelList[index].selected==true;
    selectAll=!selectAll;
    memberAmount=0;
    if(selectAll==true) {
      // selectedUnPaidMemberModelList.clear();
      for (var i in unPaidMemberModelList) {
        i.selected = true;
        // selectedUnPaidMemberModelList.add(i);
        print("bajdbsjf"+memberAmount.toString());
        memberAmount+=donationProvider.membershipAmount!;

      }
      // =memberAmount*selectedUnPaidMemberModelList.length;


    }else {
      // unPaidMemberModelList.clear();
      for (var i in unPaidMemberModelList) {
        i.selected = false;
        // unPaidMemberModelList.add(i);
      }
      memberAmount=0;
      selectedUnPaidMemberModelList.clear();
    }
    notifyListeners();
  }

  void onReportLoader(){
    reportDetailsLoader=true;
    notifyListeners();
  }void oFFReportLoader(){
    reportDetailsLoader=false;
    notifyListeners();
  }

  searchUnpaidMembers(txt){
    print("nmnsdfsd"+txt);
    unPaidMemberModelList = filterUnPaidMemberModelList
        .where((a) => a.houseName.toLowerCase().contains(txt.toLowerCase()) ||
        a.name.toLowerCase().contains(txt.toLowerCase())||
        a.MemberId.toLowerCase().contains(txt.toLowerCase())||
        a.PhoneNumber.toLowerCase().contains(txt.toLowerCase()))
        .toList();
    notifyListeners();
  }

  searchAllMembers(txt){
    print("jasnjdnsd"+txt);
    memberModelList=filterMemberModelList.where((element) =>
        element.name.toLowerCase().contains(txt.toLowerCase())||
        element.MemberId.toLowerCase().contains(txt.toLowerCase())||
        element.PhoneNumber.toLowerCase().contains(txt.toLowerCase())
    ).toList();
    notifyListeners();
  }

  void committeeDesignationSelect(var value){
    dropdownValue = value;
    notifyListeners();
  }
  void selectMemberName(CommitteeModel membername){
    committeeNameCT.text=membername.name;
    selectedMemberId = membername.id;
    notifyListeners();
  }
  HashMap<String, Object> attemptMap = HashMap();


  Future<void> addMember(BuildContext context,String from,String type,String uId,String idStatus,
      String unit,String assembly,String district,String state,String memberId,String newFrom) async {

    memberLoader = true;
    notifyListeners();

    Map<String, Object> memberMap = HashMap();
    Map<String, Object> userMap = HashMap();

    print(memberLoader.toString()+"iririitj");
    userMap["NAME"] = memberName.text.toString();
    userMap["PHONE_NUMBER"] ="+91${memberPhoneNumber.text.toString()}";
    userMap["STATE"] = state;
    userMap["DISTRICT"] = district;
    userMap["ASSEMBLY"] = assembly;
    // userMap["PANCHAYATH"] = panchayath;
    userMap["UNIT"] = unit;
    userMap["LEVEL"] = 'MEMBER_LEVEL';
    userMap["REF"] = "MEMBERS/$memberId";
    userMap["USER_ID"] = memberId;

    if(type =="Edit") {
      memberMap["MEMBER_ID"] = memberId;
      memberMap["EDITED_BY"] = uId;
      memberIdCt.text=memberId;
    }else{
      memberMap["MEMBER_ID"] = memberId;
      memberIdCt.text=memberId;
    }

    memberMap["NAME"] = memberName.text;
    memberMap["PHONE_NUMBER"] = memberPhoneNumber.text;
    memberMap["STATE"] = state;
    memberMap["DISTRICT"] = district;
    memberMap["ASSEMBLY"] = assembly;
    // memberMap["PANCHAYATH"] =panchayath;
    memberMap["UNIT"] = unit;
    memberMap["LEVEL"] = "MEMBER_LEVEL";
    memberMap["EDUCATION"] = memberEducation.text.toString().toUpperCase();
    print(memberLoader.toString()+"kjkk");


    // if(idStatus=="WITH ID"){
    //   memberMap["VOTER_ID"] = memberVoterId.text;
    // }

    DateTime inputDate= DateTime.now();
    String date = day + "/" + month + "/" + year;
    print(date.toString()+"roiroporp");
    try{
      inputDate = DateFormat('dd/MMMM/yyyy','en_US').parse(date);

    }catch(e){
      inputDate = DateFormat('dd/MM/yyyy','en_US').parse(date);
    }

    print(inputDate.toString()+"ppppppppppppp");
    Timestamp timestamp = Timestamp.fromDate(inputDate);
    print(timestamp.toString()+"yeueueu");

    memberAge = DateTime.now().difference(inputDate).inDays~/360;
    print(memberAge.toString()+"dodpdoo");

    memberMap["ADDRESS"] = memberAddress.text.trim();
    memberMap["PIN_CODE"] = memberPincode.text;
    memberMap["DOB"] = timestamp;
    memberMap["AGE"] = memberAge;
    memberMap["GENDER"] = gender.toString();
    memberMap["PROFESSION"] = memberProfession.text.toString().toUpperCase();
    memberMap["REGISTER_TYPE"] = idStatus;

    ////
    attemptMap["EDUCATION"] = memberEducation.text.toString().toUpperCase();
    attemptMap["VOTER_ID"] = TypeIdCt.text;
    attemptMap["ADDRESS"] = memberAddress.text.trim();
    attemptMap["PIN_CODE"] = memberPincode.text;
    attemptMap["DOB"] = timestamp;
    attemptMap["AGE"] = memberAge;
    attemptMap["GENDER"] = gender.toString();
    attemptMap["PROFESSION"] = memberProfession.text.toString().toUpperCase();
    attemptMap["REGISTER_TYPE"] = idStatus;
    attemptMap["ADDED_DATE"] = DateTime.now();
    attemptMap["ADDED_DATE_MILLIS"] = DateTime.now().millisecondsSinceEpoch;
    attemptMap["ADDED_BY"] = uId;
    attemptMap["LEVEL"] = "MEMBER_LEVEL";
    attemptMap["DESIGNATION"] = "";
    attemptMap["DESIGNATION_LEVEL"] = "";
    attemptMap["COUNCILOR_LEVEL"] = "";
    attemptMap["UNIT_NOMINEE"] = "FALSE";
    attemptMap["ASSEMBLY_COUNSELOR"] = "FALSE";
    attemptMap["DISTRICT_COUNSELOR"] = "FALSE";
    attemptMap["STATE_COUNSELOR"] = "FALSE";
    attemptMap["NATIONAL_COUNSELOR"] = "FALSE";
    attemptMap["UNIT_SHOW"] = "TRUE";
    attemptMap["ASSEMBLY_SHOW"] = "TRUE";
    attemptMap["DISTRICT_SHOW"] = "TRUE";
    attemptMap["STATE_SHOW"] = "TRUE";
    attemptMap["NATIONAL_SHOW"] = "TRUE";
    attemptMap["PHOTO"] ='';
    attemptMap["VOTER_ID_CARD"] ='';
////



    String profileImage='';
    if (fileimage != null) {
      print("valuentered");
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child("Profile").child(photoId);
      await ref.putFile(fileimage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          memberMap["PHOTO"] = value;
          memberMap["ID_PHOTO"] = photoId;

          profileImage=value;
          // editMap['IMAGE_URL'] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      memberMap['PHOTO'] = imageUrl;
      print("hchdh");
      // editMap['IMAGE_URL'] = imageUrl;
    }
    memberMap["VOTER_ID"] = TypeIdCt.text;

    if (voterfileImage != null) {
      String cardId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child("VoterCard").child(cardId);
      await ref.putFile(voterfileImage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {

          memberMap["VOTER_ID_CARD"] = value;
          // editMap['IMAGE_URL'] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      memberMap['VOTER_ID_CARD'] = imageUrl1;
      // editMap['IMAGE_URL'] = imageUrl;
    }

    print(attemptMap['VOTER_ID_CARD'].toString()+"vjjnvhh");

    memberMap["ADDED_DATE"] = DateTime.now();
    memberMap["ADDED_DATE_MILLIS"] = DateTime.now().millisecondsSinceEpoch;

    if(type=="New"){
      memberMap["DESIGNATION"] = "";
      memberMap["DESIGNATION_LEVEL"] = "";
      memberMap["COUNCILOR_LEVEL"] = "";
      memberMap["UNIT_NOMINEE"] = "FALSE";
      memberMap["ASSEMBLY_COUNSELOR"] = "FALSE";
      memberMap["DISTRICT_COUNSELOR"] = "FALSE";
      memberMap["STATE_COUNSELOR"] = "FALSE";
      memberMap["NATIONAL_COUNSELOR"] = "FALSE";
      memberMap["UNIT_SHOW"] = "TRUE";
      memberMap["ASSEMBLY_SHOW"] = "TRUE";
      memberMap["DISTRICT_SHOW"] = "TRUE";
      memberMap["STATE_SHOW"] = "TRUE";
      memberMap["NATIONAL_SHOW"] = "TRUE";
    }

    memberMap["ADDED_BY"] = uId;
    if(newFrom == 'REQUEST'){
      memberMap["REQUEST_STATUS"] = "PENDING";
      attemptMap["REQUEST_STATUS"] = "PENDING";
      String? strDeviceID = "";

      if(Platform.isAndroid){
        strDeviceID= await DeviceInfo().fun_initPlatformState();
      }
      memberMap["DEVICE_ID"] = strDeviceID;

    }else{
      memberMap["STATUS"] = "REGISTERED";

    }
    checkUserMemberExist('+91'+memberPhoneNumber.text);
   print(checkLevel.toString()+"oiigi");

      if(type =="New" && newFrom!='REQUEST') {
     await db.collection("MEMBERS").doc(memberId).set(memberMap);
     db.collection("TOTAL_STATES").doc(state).set({"UNPAID_MEMBERS":FieldValue.increment(1)},SetOptions(merge: true));
     db.collection("TOTAL_ASSEMBLY").doc(assembly).set({"UNPAID_MEMBERS_ASSEMBLY":FieldValue.increment(1),"UNPAID_MEMBERS_DISTRICT":FieldValue.increment(1)},SetOptions(merge: true));
     if(checkLevel) {
       print("vvfvk");
       await db.collection("USERS").doc(memberId).set(userMap);
     }
     memberLoader = false;
     notifyListeners();

    }else if(type == "Edit"){
      await db.collection("MEMBERS").doc(memberId).set(memberMap,SetOptions(merge: true));
      if(checkLevel) {
        print("vvfvk");
        await db.collection("USERS").doc(memberId).set(userMap,SetOptions(merge: true));

      }
      memberLoader = false;
      notifyListeners();

    }
    print(memberLoader.toString()+"eooeoeoe");
    if(newFrom=='REQUEST'){
      final mId= memberId;
      final Map<String, Object> mMap = memberMap;
      final BuildContext capturedContext = context;
      await db.collection("MEMBERS").doc(mId).set(mMap,SetOptions(merge: true));
      print("dsfjhdjfsdf"+newFrom+"  "+memberId);
        callNextReplacement(RequestPendingPage(wantToShow: false, name: memberName.text, address: memberAddress.text,
            PhoneNumber: memberPhoneNumber.text, photo: profileImage,iD:"" ,type: "YES", status: '',state: state), capturedContext);


    }
    print("outside new request"+newFrom+"  "+memberId);

  }

  HashMap<String, Object> requestMap = HashMap();

   addMembershipRequest() async {
    requestMap["ADDRESS"] = memberAddress.text;
    requestMap["FROM"] = "REQUEST";
    requestMap["ADDED_DATE"] = DateTime.now();
    requestMap["ADDED_DATE_MILLIS"] = DateTime.now().millisecondsSinceEpoch.toString();
    requestMap["PROFESSION"] = memberProfession.text.toString().toUpperCase();
    requestMap["EDUCATION"] = memberEducation.text.toString().toUpperCase();
    DateTime inputDate= DateTime.now();
    String date = day + "/" + month + "/" + year;
    print(date.toString()+"roiroporp");
    try{
      inputDate = DateFormat('dd/MMMM/yyyy','en_US').parse(date);

    }catch(e){
      inputDate = DateFormat('dd/MM/yyyy','en_US').parse(date);
    }

    print(inputDate.toString()+"ppppppppppppp");
    Timestamp timestamp = Timestamp.fromDate(inputDate);
    print(timestamp.toString()+"yeueueu");

    memberAge = DateTime.now().difference(inputDate).inDays~/360;
    print(memberAge.toString()+"dodpdoo");
    requestMap["DOB"] = timestamp;
    requestMap["AGE"] = memberAge;
    requestMap["GENDER"] = gender.toString();
    requestMap["APPROVED_BY"] = '';
    requestMap["APPROVED_DATE"] ='';
    requestMap["VOTER_ID"] = TypeIdCt.text;
    requestMap["REGISTER_TYPE"] = 'Nil';
    requestMap["PIN_CODE"] = memberPincode.text;

    if (fileimage != null) {
      print("valuentered");
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child("Profile").child(photoId);
      await ref.putFile(fileimage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          requestMap["PHOTO"] = value;
          requestMap["ID_PHOTO"] = photoId;
          // editMap['IMAGE_URL'] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    }  else {
      requestMap['PHOTO'] = imageUrl;
    }

    if (voterfileImage != null) {
      String cardId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child("VoterCard").child(cardId);
      await ref.putFile(voterfileImage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          requestMap["VOTER_ID_CARD"] = value;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    }else {
      requestMap['VOTER_ID_CARD'] = imageUrl1;
    }

      notifyListeners();

  }


  void fetchMasterData(String from,String state,String dis,String assembly){
    masterModelList.clear();
    filterMasterModelList.clear();
    dynamic databasePointer;
    if(from=='NATIONAL_LEVEL'){
      databasePointer=db.collection('MEMBERS').where('STATE',isEqualTo: 'DELHI');
    }else if(from=='STATE_LEVEL'){
      databasePointer=db.collection('MEMBERS').where('STATE',isEqualTo: state);
    }else if(from=='DISTRICT_LEVEL'){
      databasePointer=db.collection('MEMBERS').where('STATE',isEqualTo: state).where('DISTRICT',isEqualTo: dis);
    }else if(from=='ASSEMBLY_LEVEL'){
      databasePointer=db.collection('MEMBERS').where('STATE',isEqualTo: state)
          .where('DISTRICT',isEqualTo: dis).where('ASSEMBLY',isEqualTo: assembly);
    }

    databasePointer.get().then((value){
      if(value.docs.isNotEmpty){
        for(var elements in value.docs) {
          Map<dynamic, dynamic> map = elements.data();
          filterMasterModelList.add(MasterReportModel(
              elements.id,
              map['NAME'].toString(),
              map['LEVEL'].toString(),
              map['STATE'].toString(),
              map['ASSEMBLY'].toString(),
              map['DISTRICT'].toString(),
              0,
              map['PAYMENT_URL'].toString(),
              map['STATUS'].toString(),map['UNIT']??'',map['REQUEST_STATUS']??""));
          if(map['STATE'].toString()=='KARNATAKA' && !map.containsKey('REQUEST_STATUS') && map['STATUS']=='PAID'){
            print(elements.id.toString()+' INIBVUFHVBFV');
          }
          print(map['REQUEST_STATUS'].toString()+' KKKMFKMKMKFVM');
          notifyListeners();
        }
        masterModelList =filterMasterModelList;
      }
    });
  }

  Future<void> getAllStateDetailsFromJson() async {
    allStateDistrictAssemblyList.clear();
    var jsonText = await rootBundle.loadString('assets/IYC_JSON.json');
    var jsonResponse = json.decode(jsonText.toString());

    allStateDistrictAssemblyList.clear();
    Map <dynamic, dynamic> map = jsonResponse as Map;
    map.forEach((key, value) {
      allStateDistrictAssemblyList.add(StateModel(value["State"].toString(), value["District"].toString(), value["Assembly"].toString()));

      notifyListeners();
    });

  }

  List<MasterReportModel> stateSettingfunc(String state){
    List<MasterReportModel> stateRegList=[];
    stateRegList=masterModelList.where((element) => element.state == state)
        .where((element) => element.mandalam!='' && element.mandalam!='null').toSet()
        .toList();
    stateRegList.sort((b, a) =>
        a.count
            .compareTo(b.count));
    return stateRegList;
  }


  List<MasterCoordinatorDetailsModel> stateAllMembersFilter(String state,String designation){
    List<MasterCoordinatorDetailsModel> stateRegList=[];
    stateRegList=MasterCoordinatorDetailsList.where((element) => element.state == state)
        .where((element) => element.designation==designation).toSet()
        .toList();
    //AMEEEEEEEEEEENTEST
    return stateRegList;
  }


  List<MasterCoordinatorDetailsModel> stateAllMembersSetting(String state){
    List<MasterCoordinatorDetailsModel> stateRegList=[];
    stateRegList=MasterCoordinatorDetailsList.where((element) => element.state == state)
        .toSet()
        .toList();
    print(MasterCoordinatorDetailsList.length.toString()+' MVFKMVKFV');
    print(stateRegList.length.toString()+' MVFKMVKFV');
    //AMEEEEEEEEEEENTEST
    return stateRegList;
  }

  List<MasterCoordinatorDetailsModel>DistrictAllMembersFilter(String district,String designation){
    List<MasterCoordinatorDetailsModel> stateRegList=[];
    stateRegList=MasterCoordinatorDetailsList.where((element) => element.district == district)
        .where((element) => element.designation==designation).toSet()
        .toList();
    //AMEEEEEEEEEEENTEST
    return stateRegList;
  }

  List<MasterCoordinatorDetailsModel> assemblyAllMembersFilter(String district,String assembly,String designation){
    List<MasterCoordinatorDetailsModel> stateRegList=[];
    stateRegList=MasterCoordinatorDetailsList
        .where((element) => element.district == district)
        .where((element) => element.mandalam == assembly)
        .where((element) => element.designation==designation).toSet()
        .toList();
    //AMEEEEEEEEEEENTEST

    return stateRegList;
  }

  List<MasterCoordinatorDetailsModel>unitAllMembersFilter(String district,String assembly,String unit,String designation){
    List<MasterCoordinatorDetailsModel> stateRegList=[];
    stateRegList=MasterCoordinatorDetailsList
        .where((element) => element.district == district)
        .where((element) => element.mandalam == assembly)
        .where((element) => element.unit == unit)
        .where((element) => element.designation==designation).toSet()
        .toList();
    //AMEEEEEEEEEEENTEST

    return stateRegList;
  }

  void getAllState()  {
    stateList.clear();
    listForSearchState.clear();
    stateList = allStateDistrictAssemblyList.map((e) =>e.state ).toSet().toList();
    listForSearchState=stateList;
    print(districtList.length.toString()+'chbfhbvf');
    notifyListeners();
  }

  void getAllDistrict(String state) {
    String sta = state;

    districtList.clear();
    listForSearchDistrict.clear();
    districtList = allStateDistrictAssemblyList.where((element) => element.state==sta).map((e) => e.district).toSet().toList();
    listForSearchDistrict=districtList;
    notifyListeners();
  }

  void getAllAssembly(String state,String district) {
    String sta = state;
    String dis = district;

    assemblyList.clear();
    listForSearchAssembly.clear();
    assemblyList = allStateDistrictAssemblyList.where((element) => element.state==sta).where((element) => element.district==dis).map((e) => e.assembly).toSet().toList();
    listForSearchAssembly=assemblyList;
    notifyListeners();
  }

  void setListAfterSearch(String from){
    print(from+' MRCKMFC');
    if (from == 'STATE_LEVEL') {
      stateList=listForSearchState;
    }
    if (from == 'DISTRICT_LEVEL') {
      districtList=listForSearchDistrict;
    }
    if (from == 'ASSEMBLY_LEVEL') {
      assemblyList=listForSearchAssembly;
    }
    if (from == 'UNIT_LEVEL') {
      unitList=listForSearchUnit;
    }
    notifyListeners();
  }

  List<String> getProcess(String from) {

    if (from == 'NATIONAL_LEVEL') {
      return stateList;
    }
    if (from == 'STATE_LEVEL') {
      return districtList;
    }
    if (from == 'DISTRICT_LEVEL') {
      return assemblyList;
    }
    if (from == 'ASSEMBLY_LEVEL') {
      return unitList;
    }
    // if (from == 'PANCHAYATH_LEVEL') {
    //   return unitList;
    // }
    if (from == 'UNIT_LEVEL') {
      return [];
    }
    return [];
  }

  void fetchEvent(String from,String state, String district, String assembly, String unit)  {
    print(from+' JFKVFNJKV');
    if(from=="NATIONAL_LEVEL") {
      getAllState();
    }
    if(from=="STATE_LEVEL") {
      getAllDistrict(state);
    }
    else if(from=="DISTRICT_LEVEL") {
      getAllAssembly(state,district);
    }
    else if(from=="ASSEMBLY_LEVEL") {
      getAddedUnit(state, district, assembly);
    }
    // else if(from=="PANCHAYATH_LEVEL") {
    //   getAddedUnit(state, district, assembly);
    // }
    else if(from=="UNIT_LEVEL") {

    }
  }


  void dateSetting(DateTime birthDate) {
    memberDob.text = outputDayNode.format(birthDate).toString();
  }

  Future<void> selectDOB(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != birthDate) {
      birthDate = pickedDate;
      dateSetting(birthDate);
      memberAge = DateTime.now().difference(birthDate).inDays~/360;
      day = birthDate.day.toString();
      month = birthDate.month.toString();
      year = birthDate.year.toString();
    }
    notifyListeners();



  }



  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      fileimage = File(response.file!.path);

      notifyListeners();
    }
  }

  String newPicekd='';
  imageFromCamera() async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 15);

    if (pickedFile != null) {
      // fileimage = File(pickedFile.path);
      _cropImage(pickedFile.path, '');
      newPicekd=pickedFile.path;
      print(newPicekd+"23232323=========");
    } else {}
    if (pickedFile!.path.isEmpty) retrieveLostData();

    notifyListeners();
  }

  imageFromGallery() async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (pickedFile != null) {
      // fileimage = File(pickedFile.path);
      _cropImage(pickedFile.path, '');

      newPicekd=pickedFile.path ;
      print(newPicekd+"23232323=========");
      notifyListeners();
    } else {}
    if (pickedFile!.path.isEmpty) retrieveLostData();

    notifyListeners();
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            )),
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: Icon(
                    Icons.camera_enhance_sharp,
                    color: myGreen,
                  ),
                  title: const Text(
                    'Camera',
                  ),
                  onTap: () => {imageFromCamera(), Navigator.pop(context)}),
              ListTile(
                  leading: Icon(Icons.photo, color: myGreen),
                  title: const Text(
                    'Gallery',
                  ),
                  onTap: () => {imageFromGallery(), Navigator.pop(context)}),
            ],
          );
        });
    // ImageSource
  }

  Future<void> _cropImage(String path, String from) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      fileimage = File(croppedFile.path);
      coordinatorImage = File(croppedFile.path);
      notifyListeners();
    }
    print("gggggggggggg666" + fileimage.toString());
  }

  // void addPanchayath(String state,String district,String assembly,String uid){
  //   HashMap<String,Object> maps= HashMap();
  //   print(state+"ygsygg");
  //   print(assembly+"ygsygg");
  //   print(district+"ygsygg");
  //   String panchayath= panchayathCT.text.toString().toUpperCase().trim();
  //   maps['PANCHAYATH']=panchayath;
  //   maps['STATE']=state;
  //   maps['DISTRICT']=district;
  //   maps['ASSEMBLY']=assembly;
  //   maps['ADDED_BY']=uid;
  //   maps['ADDED_TIME']=DateTime.now();
  //   db.collection("PANCHAYATHS").doc('${district}_${assembly}_${panchayath}').set(maps);
  //   notifyListeners();
  // }

  // void getAddedPanchayath(String state,String district,String assembly){
  //   // panchayathList.clear();
  //   db.collection("PANCHAYATHS")
  //       .where("STATE",isEqualTo: state)
  //       .where("DISTRICT",isEqualTo: district)
  //       .where("ASSEMBLY",isEqualTo: assembly)
  //       .snapshots()
  //       .listen((event) {
  //     panchayathList.clear();
  //     selectPanchayathList.clear();
  //     if(event.docs.isNotEmpty){
  //       for(var element in event.docs){
  //         panchayathList.add(element.get("PANCHAYATH").toString());
  //         selectPanchayathList.add(PanchayathModel(state, district, assembly, element.get("PANCHAYATH").toString()));
  //         notifyListeners();
  //         print(panchayathList.length.toString()+"dijioedij");
  //       }
  //       notifyListeners();
  //     }
  //
  //   });
  //   notifyListeners();
  // }

  void addUnit(String state,String district,String assembly,String uid){
    HashMap<String,Object> map= HashMap();
    print(state+"ygsygg");
    print(assembly+"ygsygg");
    print(district+"ygsygg");
    // print(panchayath+"ygsygg");
    String unit= unitCT.text.toString().toUpperCase().trim();
    map['UNIT']=unit;
    // map['PANCHAYATH']=panchayath;
    map['STATE']=state;
    map['DISTRICT']=district;
    map['ASSEMBLY']=assembly;
    map['ADDED_BY']=uid;
    map['ADDED_TIME']=DateTime.now();
    map['ADDED_TIME_MILLIS']=DateTime.now().millisecondsSinceEpoch;
    db.collection("UNITS").doc('${district}_${assembly}_$unit').set(map);
    notifyListeners();
  }


  void chckStateRegLock(String state)  {
    print(' RIJFNRJIFNRJIFNIRFJR   '+state);
    isStateRegLock=false;
    mRootReference.child('stateLock').onValue.listen((event) {
      if(event.snapshot.exists){
        Map<dynamic,dynamic> map=event.snapshot.value as Map;
        map.forEach((key, value) {
          if(key==state){
            if(value=='ON'){
              isStateRegLock=true;
              notifyListeners();
            }else{
              isStateRegLock=false;
              notifyListeners();
            }
            print(isStateRegLock.toString()+' VAAAAAAAAAAAAAAAAAAAAAAAAAAA');
          }
        });
      }
    });
    notifyListeners();
  }


  void getAddedUnit(String state,String district,String assembly){
    print(state + district + assembly  + "sdfsffsfsf");
    unitList.clear();
    selectUnitList.clear();
    db.collection("UNITS")
        .where("STATE",isEqualTo: state)
        .where("DISTRICT",isEqualTo: district)
        .where("ASSEMBLY",isEqualTo: assembly)
        .get()
        .then((value) {
      if(value.docs.isNotEmpty){
        unitList.clear();
        selectUnitList.clear();
        for(var element in value.docs){
          unitList.add(element.get("UNIT").toString());
          selectUnitList.add(UnitModel(state, district, assembly,'', element.get("UNIT").toString()));

          notifyListeners();
          print(unitList.length.toString()+"wwoie");
        }
        listForSearchUnit=unitList;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  void clearSearch(){
    searchController.clear();
    notifyListeners();
  }

  void clearAddMember(){
    memberUnit.clear();
    // memberPanchayath.clear();
    memberAssembly.clear();
    memberDistrict.clear();
    memberState.clear();
    memberProfession.clear();
    memberDob.clear();
    memberAddress.clear();
    memberHouseName.clear();
    memberName.clear();
    memberPhoneNumber.clear();
    memberVoterId.clear();
    TypeIdCt.clear();
    gender = "";
    day ="Day";
    month = "Month";
    year = "Year";
    fileimage = null;
    voterfileImage = null;
    memberEducation.clear();
    memberAge = 0;
    memberPincode.clear();
    imageUrl1 ='';
    coordinatorImage = null;
    imageUrl = '';
    memberIdCt.clear();
    notifyListeners();

  }

  void getUnitCount(String state,String district,String assembly){
    assmblyListCounts.clear();
    for(var elemt in assemblyList){
      db.collection("UNITS")
          .where("STATE",isEqualTo: state)
          .where("DISTRICT",isEqualTo: district)
          .where("ASSEMBLY",isEqualTo: elemt)
          .get()
          .then((value) {
        if(value.docs.isNotEmpty){
          assmblyListCounts.add(DistrictFilterModel(assembly, value.docs.length));
          notifyListeners();
        }else{
          assmblyListCounts.add(DistrictFilterModel(assembly, 0));

        }
        notifyListeners();
      });
    }

  }

  void getMembers (String state,String district,String assembly,String unit){
    print("aaaaaaa"+state+"_"+district+"_"+assembly+"_"+unit);
    db.collection("MEMBERS")
        .orderBy("ADDED_DATE",descending: true)
        .where("STATE",isEqualTo:state)
        .where("DISTRICT",isEqualTo:district)
        .where("ASSEMBLY", isEqualTo:assembly)
        .where("UNIT",isEqualTo:unit)
        .where("STATUS",isEqualTo:"PAID")
        .snapshots()
        .listen((value) {
      print("zsfs");
        memberModelList.clear();
      if(value.docs.isNotEmpty){
        print("zsfs111");
        for(var element in value.docs) {
          print("safdsfew${element.id}");
          Map<dynamic, dynamic> map = element.data();
          Timestamp date = map["DOB"];
          DateTime dateTime = date.toDate();

          String formattedDate = DateFormat('dd/MMMM/yyyy').format(map["DOB"].toDate()).toString();
          print(formattedDate.toString()+"djhuuf");

          if (!map.containsKey("REQUEST_STATUS")) {
            memberModelList.add(MemberModel(
                map["MEMBER_ID"].toString(),
                map["VOTER_ID"].toString(),
                map["NAME"].toString(),
                map["HOSUE_NAME"]??"",
                map["PHONE_NUMBER"].toString(),
                map["ADDRESS"].toString(),
                formattedDate,
                map["GENDER"].toString(),
                map["PROFESSION"].toString(),
                map["STATE"].toString(),
                map["DISTRICT"].toString(),
                map["ASSEMBLY"].toString(),
                map["UNIT"].toString(),
                map["PHOTO"].toString(),
                map["ID_PHOTO"].toString(),
                map["ADDED_BY"].toString(),
                '',
                false,
                map["STATUS"].toString(),
                map['REGISTER_TYPE'].toString()
            ));
            filterMemberModelList = memberModelList;
            notifyListeners();
          }else if(map["REQUEST_STATUS"] == "APPROVE"){
            memberModelList.add(MemberModel(
                map["MEMBER_ID"].toString(),
                map["VOTER_ID"].toString(),
                map["NAME"].toString(),
                map["HOSUE_NAME"]??"",
                map["PHONE_NUMBER"].toString(),
                map["ADDRESS"].toString(),
                formattedDate,
                map["GENDER"].toString(),
                map["PROFESSION"].toString(),
                map["STATE"].toString(),
                map["DISTRICT"].toString(),
                map["ASSEMBLY"].toString(),
                map["UNIT"].toString(),
                map["PHOTO"].toString(),
                map["ID_PHOTO"].toString(),
                map["ADDED_BY"].toString(),
                '',
                false,
                map["STATUS"].toString(),
                map['REGISTER_TYPE'].toString()
            ));
            filterMemberModelList = memberModelList;
            print(memberModelList.length.toString() + "sdfs");
            notifyListeners();
          }else{

          }
        }
        notifyListeners();
      }else{
        print("sdfdsfqqq");
      }
    });
  }
  void getUnpaidMembers (String state,String district,String assembly,String unit){
    print("aaaaaaa"+state+"_"+district+"_"+assembly+"_"+unit);
    db.collection("MEMBERS")
        .orderBy("ADDED_DATE",descending: true)
        .where("STATE",isEqualTo:state)
        .where("DISTRICT",isEqualTo:district)
        .where("ASSEMBLY",isEqualTo:assembly)
        .where("UNIT",isEqualTo:unit)
        .where("STATUS",isEqualTo: "REGISTERED")
        .snapshots().listen((value) {
      print("zsfs");
        unPaidMemberModelList.clear();
      if(value.docs.isNotEmpty){
        print("zsfs111");
        for(var element in value.docs){
          print("safdsfew"+element.id.toString());
          Map<dynamic, dynamic> map = element.data();

          Timestamp date = map["DOB"];
          DateTime dateTime = date.toDate();

          String formattedDate = DateFormat('dd/MMMM/yyyy').format(map["DOB"].toDate()).toString();
          print(formattedDate.toString()+"uiuiu");

          unPaidMemberModelList.add(MemberModel(
              map["MEMBER_ID"].toString(),
              map["VOTER_ID"].toString(),
              map["NAME"].toString(),
              map["HOSUE_NAME"]??"",
              map["PHONE_NUMBER"].toString(),
              map["ADDRESS"].toString(),
              formattedDate,
              map["GENDER"].toString(),
              map["PROFESSION"].toString(),
              map["STATE"].toString(),
              map["DISTRICT"].toString(),
              map["ASSEMBLY"].toString(),
              map["UNIT"].toString(),
              map["PHOTO"].toString(),
              map["ID_PHOTO"].toString(),
              map["ADDED_BY"].toString(),
              '',
              false,
              map["STATUS"].toString(),
              map['REGISTER_TYPE']??"NIL"

          ));
          filterUnPaidMemberModelList=unPaidMemberModelList;
          print(unPaidMemberModelList.length.toString()+"sdfs");
          notifyListeners();
        }
        notifyListeners();
      }else{
        print("sdfdsfqqq");
      }
    });
  }

  void getNameOfMember(){
    db.collection("MEMBERS").get().then((value){
      if(value.docs.isNotEmpty){
        memberNameList.clear();
        for(var e in value.docs){
          Map<dynamic, dynamic> map = e.data();
          memberNameList.add(CommitteeModel(map["NAME"], map["MEMBER_ID"]));
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  String selectedID = '';

  void addCommittee(String id,String from,String designation ,String oldID,String type){
    Map<String, Object> map = HashMap();
    map["DESIGNATION"]= designation;
    map["DESIGNATION_LEVEL"]= from;
    map["COMMITTEE_MEMBER_STATUS"]= "YES";
    Map<String, Object> oldMap = HashMap();
    oldMap["DESIGNATION"]= "";
    oldMap["DESIGNATION_LEVEL"]= "";
    oldMap["COMMITTEE_MEMBER_STATUS"]= "NO";
    if(type == "EDIT"){
    db.collection("MEMBERS").doc(id).set(map,SetOptions(merge: true));
    db.collection("MEMBERS").doc(oldID).set(oldMap,SetOptions(merge: true));

    notifyListeners();
    }else{
      db.collection("MEMBERS").doc(id).set(map,SetOptions(merge: true));
      notifyListeners();
    }
    notifyListeners();
   }
  String? appVersion;
  String currentVersion='';
  String buildNumber='';

  void lockApp() {

    mRootReference.child("0").onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        List<String> versions = map[!Platform.isIOS ? 'AppVersion' : 'iOSVersion'].toString().split(',');
        if (!versions.contains(appVersion)) {
          String ADDRESS = map[!Platform.isIOS ?'ADDRESS':'ADDRESS_iOS'].toString();
          String button = map['BUTTON'].toString();
          String text = map['TEXT'].toString();
          runApp(MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Update(
              ADDRESS: ADDRESS,
              button: button,
              text: text,
            ),
          ));
        }
      }
    });
  }
  Future<void> getAppVersion() async {

    PackageInfo.fromPlatform().then((value) {


      currentVersion=value.version;
      buildNumber = value.buildNumber;
      appVersion=buildNumber;

      print(appVersion.toString()+"edfesappversion");


      notifyListeners();
    });

  }


   void getCommittee(String state,String district,String assembly,String unit){
     committeeMembersList.clear();
    db.collection("MEMBERS")
        .where("STATE",isEqualTo: state)
        .where("DISTRICT",isEqualTo: district)
        .where("ASSEMBLY",isEqualTo: assembly)
        .where("UNIT",isEqualTo: unit)
        .where("COMMITTEE_MEMBER_STATUS",isEqualTo: "YES")
        .get()
        .then((value){
      if(value.docs.isNotEmpty){
        committeeMembersList.clear();
        for(var e in value.docs){
          Map<dynamic, dynamic> map = e.data();
          committeeMembersList.add(
              CommitteeListModel(
                  e.id,
                  map["NAME"].toString(),
                  map["PHOTO"].toString(),
                  map["DESIGNATION"].toString(),
                  map["DESIGNATION_LEVEL"].toString(),
              ));
          notifyListeners();
        }
      }
      notifyListeners();
    });
   }



  Future<void> retrieveLostData1() async {
    final LostDataResponse response = await picker1.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      voterfileImage = File(response.file!.path);

      notifyListeners();
    }
  }

  String newPicekd1='';
  imageFromCamera1() async {
    final pickedFile1 =
    await picker1.pickImage(source: ImageSource.camera, imageQuality: 15);

    if (pickedFile1 != null) {
      // fileimage = File(pickedFile.path);
      _cropImage1(pickedFile1.path, '');
      newPicekd1=pickedFile1.path;
      print(newPicekd1+"23232323=========");
    } else {}
    if (pickedFile1!.path.isEmpty) retrieveLostData1();
    notifyListeners();
  }

  imageFromGallery1() async {
    final pickedFile1 =
    await picker1.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (pickedFile1 != null) {
      // fileimage = File(pickedFile.path);
      _cropImage1(pickedFile1.path, '');

      newPicekd1=pickedFile1.path ;
      print(newPicekd1+"23232323=========");
      notifyListeners();
    } else {}
    if (pickedFile1!.path.isEmpty) retrieveLostData1();

    notifyListeners();
  }

  void showBottomSheet1(BuildContext context) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            )),
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: Icon(
                    Icons.camera_enhance_sharp,
                    color: myGreen,
                  ),
                  title: const Text(
                    'Camera',
                  ),
                  onTap: () => {imageFromCamera1(), Navigator.pop(context)}),
              ListTile(
                  leading: Icon(Icons.photo, color: myGreen),
                  title: const Text(
                    'Gallery',
                  ),
                  onTap: () => {imageFromGallery1(), Navigator.pop(context)}),
            ],
          );
        });
    // ImageSource
  }

  Future<void> _cropImage1(String path, String from) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      voterfileImage = File(croppedFile.path);
      notifyListeners();
    }
    print("gggggggggggg666" + voterfileImage.toString());
  }

  void getAllAssemblyForCoordinatorss(String state,String district) {
    String sta = state;
    String dis = district;

    List<String> list= [];
    listForSearchAssembly.clear();
    filterassemblyListForReport.clear();
    assemblyListForReport.clear();
    list = allStateDistrictAssemblyList.where((element) => element.state==sta).where((element) => element.district==dis).map((e) => e.assembly).toSet().toList();
    listForSearchAssembly=list;

    for(var elemts in list){
      assemblyListForReport.add(DistrictFilterModel(elemts, 0));
      db.collection("UNITS")
          .where("STATE",isEqualTo: state)
          .where("DISTRICT",isEqualTo: district)
          .where("ASSEMBLY",isEqualTo: elemts)
          .get()
          .then((value) {
        if(value.docs.isNotEmpty){
          for(var ee in assemblyListForReport){
            if(ee.name==elemts){
              ee.value=value.size;
            }
          }
          notifyListeners();

        }});
      notifyListeners();
    }
    filterassemblyListForReport=assemblyListForReport;
    notifyListeners();
  }

  void searchAssembly(String item){
    filterassemblyListForReport = assemblyListForReport
        .where((a) =>
    a.name.toLowerCase().contains(item.toLowerCase()))
        .toList();
    notifyListeners();
    notifyListeners();
  }


  void search(String item,String from) {
    print(from+' IRNNV');
    if(from=='STATE_LEVEL'){
      print(listForSearch.length.toString()+' IJCNIJCNFC');
      districtList = listForSearchDistrict
            .where((a) =>
        a.toLowerCase().contains(item.toLowerCase()) ||
            a.toLowerCase().contains(item.toLowerCase()))
            .toList();
      notifyListeners();
    }else if(from=='DISTRICT_LEVEL'){
      assemblyList = listForSearchAssembly
          .where((a) =>
      a.toLowerCase().contains(item.toLowerCase()) ||
          a.toLowerCase().contains(item.toLowerCase()))
          .toList();
      notifyListeners();
    }else if(from=='ASSEMBLY_LEVEL'){
      unitList = listForSearchUnit
          .where((a) =>
      a.toLowerCase().contains(item.toLowerCase()) ||
          a.toLowerCase().contains(item.toLowerCase()))
          .toList();
      notifyListeners();
    }else  if(from=='NATIONAL_LEVEL'){
      stateList = listForSearchState
          .where((a) =>
      a.toLowerCase().contains(item.toLowerCase()) ||
          a.toLowerCase().contains(item.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }


    void editMember(String memberId) {
      db.collection("MEMBERS").doc(memberId).get().then((value) {
        if (value.exists) {
          Map<dynamic, dynamic> map = value.data() as Map;

          memberName.text = map["NAME"].toString();
          // memberVoterId.text = map["VOTER_ID"].toString();
          TypeIdCt.text = map["VOTER_ID"].toString();
          memberPhoneNumber.text = map["PHONE_NUMBER"].toString();
          memberHouseName.text = map["HOSUE_NAME"]??"";
          memberAddress.text = map["ADDRESS"].toString();
          day = DateFormat("dd").format(map["DOB"].toDate()).toString();
          month = DateFormat("MMMM").format(map["DOB"].toDate()).toString();
          year = DateFormat("yyyy").format(map["DOB"].toDate()).toString();
          // day = DateFormat('dd').format(date).toString();
          // month = DateFormat("MMMM").format(date).toString();
          // year = DateFormat('yyyy').format(date).toString();

          print(day.toString()+"fojfijf");
          print(month.toString()+"vhhv");
          print(year.toString()+"rjruu");

          memberProfession.text = map["PROFESSION"].toString();
          memberEducation.text = map["EDUCATION"].toString();
          memberPincode.text = map["PIN_CODE"].toString();
          gender = map["GENDER"].toString();
          imageUrl = map["PHOTO"].toString();
          imageUrl1 = map["VOTER_ID_CARD"].toString();
        }
        notifyListeners();
      });
    }

    void editRequest(String memberId) {
      db.collection("MEMBERS").doc(memberId).get().then((value) {
        if (value.exists) {
          Map<dynamic, dynamic> map = value.data() as Map;

          print(map.toString()+"yststtt");
          memberName.text = map["NAME"].toString();
          // memberVoterId.text = map["VOTER_ID"].toString();
          TypeIdCt.text = map["VOTER_ID"].toString();
          memberPhoneNumber.text = map["PHONE_NUMBER"].toString();
          memberHouseName.text = map["HOSUE_NAME"]??"";
          memberAddress.text = map["ADDRESS"].toString();
          day = DateFormat("dd").format(map["DOB"].toDate()).toString();
          month = DateFormat("MMMM").format(map["DOB"].toDate()).toString();
          year = DateFormat("yyyy").format(map["DOB"].toDate()).toString();
          // day = DateFormat('dd').format(date).toString();
          // month = DateFormat("MMMM").format(date).toString();
          // year = DateFormat('yyyy').format(date).toString();

          print(day.toString()+"fojfijf");
          print(month.toString()+"vhhv");
          print(year.toString()+"rjruu");

          memberProfession.text = map["PROFESSION"].toString();
          memberEducation.text = map["EDUCATION"].toString();
          memberPincode.text = map["PIN_CODE"].toString();
          gender = map["GENDER"].toString();
          imageUrl = map["PHOTO"].toString();
          imageUrl1 = map["VOTER_ID_CARD"].toString();
          memberUnit.text = map["UNIT"].toString();
          memberAssembly.text = map["ASSEMBLY"].toString();
          print(map["UNIT"].toString()+"fiji");
        }
        notifyListeners();
      });
    }

    bool deleteMemberLoader = false;
  Future<void>  deleteMember(String memberId,BuildContext ctxt,String uid,String state,String assembly) async{
    deleteMemberLoader =true;
    notifyListeners();

   await db.collection("MEMBERS").doc(memberId).get().then((value) async {
      if(value.exists){
        Map<dynamic, dynamic> map = value.data() as Map;
        print(map.toString()+"dooeo");

        map["DELETED_BY"] = uid;
        map["DELETED_TIME"] = DateTime.now();
        map['DELETED_TYPE'] = "MEMBER";

       await db.collection("DELETED_DATA").doc(memberId).set(map.cast(),SetOptions(merge: true));
       notifyListeners();
        print(map.toString()+"xmmxmx");
      }
    });

     await db.collection("MEMBERS").doc(memberId).delete();
      notifyListeners();

   await db.collection("TOTAL_STATES").doc(state).set({"UNPAID_MEMBERS":FieldValue.increment(-1)},SetOptions(merge: true));
   await db.collection("TOTAL_ASSEMBLY").doc(assembly).set({"UNPAID_MEMBERS_ASSEMBLY":FieldValue.increment(-1),"UNPAID_MEMBERS_DISTRICT":FieldValue.increment(-1)},SetOptions(merge: true));

     await db.collection("USERS").doc(memberId).get().then((value) async {
        if(value.exists){
         if(value.get("LEVEL")=="MEMBER_LEVEL"){
          await db.collection("USERS").doc(memberId).delete();
           notifyListeners();
         }
        }
        notifyListeners();
      });
    deleteMemberLoader = false;
    notifyListeners();
     finish(ctxt);
     const snackBar = SnackBar(
         content: Text('Deleted Successfully'));
     ScaffoldMessenger.of(ctxt).showSnackBar(snackBar);
    }

    void getPaidMembers(String state, String district, String assembly,
        String unit) {
      print("aaaaaaa" + state + "_" + district + "_" + assembly + "_" + unit);
      db.collection("MEMBERS")
          .where("STATE", isEqualTo: state)
          .where("DISTRICT", isEqualTo: district)
          .where("ASSEMBLY", isEqualTo: assembly)
          .where("UNIT", isEqualTo: unit)
          .where("UNIT_SHOW", isEqualTo: 'TRUE')
          .where("STATUS", isEqualTo: "PAID")
          .snapshots().listen((value) {
        print("zsfs");
        paidMemberModelList.clear();
        if (value.docs.isNotEmpty) {
          print("zsfs111");
          for (var element in value.docs) {
            print("safdsfew" + element.id.toString());
            Map<dynamic, dynamic> map = element.data();
            if (!map.containsKey("NOMINEE_STATUS")) {
              paidMemberModelList.add(CounsilorNomineeModel(
                map["NAME"].toString(),
                map["MEMBER_ID"].toString(),
                map["PHONE_NUMBER"].toString(),
                map["PHOTO"].toString(),
                '',
                false,'',''
              ));
              notifyListeners();
            }
          }
        }
      });
    }



    List<CounsilorNomineeModel> getCounsilors(String from) {
    print(from+"POPOPOP");
      if (from == 'NATIONAL_LEVEL') {
        return stateNomineesNew;
      }
      if (from == 'STATE_LEVEL') {
        return districtNominees;
      }
      if (from == 'DISTRICT_LEVEL') {
        return assemblyNomineesNEW;
      }
      if (from == 'ASSEMBLY_LEVEL') {
        return unitNominees;
      }
      if (from == 'UNIT_LEVEL') {
        return [];
      }
      return [];
    }

    void selectionForNomineeUnitLevel(int index, String id,) {
      paidMemberModelList[index].isSelected = !paidMemberModelList[index].isSelected;
      if (paidMemberModelList[index].isSelected == true) {
        selectedNomineeModelList.add(paidMemberModelList[index]);
        notifyListeners();
      } else {
        unSelectedNomineeModelList.add(paidMemberModelList[index]);
        notifyListeners();
      }
      notifyListeners();
    }

    void clearSelection(){
      selectedNomineeModelList.clear();
      notifyListeners();
    }

  void selectionForNominee(int index, String id,String from) {
    getCounsilors(from)[index].isSelected = !getCounsilors(from)[index].isSelected;
    if (getCounsilors(from)[index].isSelected == true) {
      selectedNomineeModelList.add(getCounsilors(from)[index]);
      notifyListeners();
    } else {
      unSelectedNomineeModelList.add(getCounsilors(from)[index]);
      notifyListeners();
    }
    notifyListeners();
  }


  void addNominee(String state, String district, String assembly, String unit,
        String from,) {

      for (var e in selectedNomineeModelList) {
        if(from == "UNIT_LEVEL"){
          db.collection("MEMBERS").doc(e.memberId)
              .set({"UNIT_NOMINEE": "TRUE","NOMINEE_STATUS": "YES","NOMINEE_LEVEL":from,"UNIT_SHOW":'FALSE'}, SetOptions(merge: true));
        }else if(from == "ASSEMBLY_LEVEL"){
          db.collection("MEMBERS").doc(e.memberId)
              .set({"ASSEMBLY_COUNSELOR": "TRUE","NOMINEE_STATUS": "YES",
            "NOMINEE_LEVEL":from,"ASSEMBLY_SHOW":'FALSE'}, SetOptions(merge: true));
        }else if(from == "DISTRICT_LEVEL"){
          db.collection("MEMBERS").doc(e.memberId).set({"DISTRICT_COUNSELOR": "TRUE",
            "NOMINEE_STATUS": "YES","NOMINEE_LEVEL":from,"DISTRICT_SHOW":'FALSE'}, SetOptions(merge: true));
        }else if(from == "STATE_LEVEL"){
          db.collection("MEMBERS").doc(e.memberId)
              .set({"STATE_COUNSELOR": "TRUE","NOMINEE_STATUS": "YES","NOMINEE_LEVEL":from,"STATE_SHOW":'FALSE'}, SetOptions(merge: true));
        }else if(from == "NATIONAL_LEVEL"){
          db.collection("MEMBERS").doc(e.memberId)
              .set({"NATIONAL_COUNSELOR": "TRUE","NOMINEE_STATUS": "YES","NOMINEE_LEVEL":from,"NATIONAL_SHOW":'FALSE'}, SetOptions(merge: true));
        }

        notifyListeners();
      }
      notifyListeners();
    }


  void nomineesUnit(String state, String district, String assembly,
      String unit, String from,) {
    unitNominees.clear();
    db
        .collection("MEMBERS")
        .where("DISTRICT", isEqualTo: district)
        .where("ASSEMBLY", isEqualTo: assembly)
        .where("UNIT_NOMINEE", isEqualTo: "TRUE")
        .where("NOMINEE_STATUS", isEqualTo: "YES")
        .snapshots()
        .listen((value) {
      if (value.docs.isNotEmpty) {
        unitNominees.clear();
        for (var element in value.docs) {
          print(element.id.toString()+' JVKGVRGV');
            unitNominees.add(CounsilorNomineeModel(
                element.get("NAME").toString(),
                element.get("MEMBER_ID").toString(),
                element.get("PHONE_NUMBER").toString(),
                element.get("PHOTO").toString(),'',
                false,'',''
            ));

          notifyListeners();
          searchUnitNominees = unitNominees;
        }
      }
      notifyListeners();
    });
  }
  //
  //
  // void nomineesUnitWise(String state, String district, String assembly,
  //       String unit, String from,) {
  //     // unitNominees.clear();
  //     print("duytrd"+ state+' '+district+' '+assembly+' '+unit);
  //     db
  //         .collection("MEMBERS")
  //         .where("STATE", isEqualTo: state)
  //         .where("DISTRICT", isEqualTo: district)
  //         .where("ASSEMBLY", isEqualTo: assembly)
  //         .where("UNIT", isEqualTo: unit)
  //         .where("UNIT_NOMINEE", isEqualTo: "TRUE")
  //         .where("NOMINEE_STATUS", isEqualTo: "YES")
  //         .snapshots()
  //         .listen((value) {
  //       if (value.docs.isNotEmpty) {
  //         unitNominees.clear();
  //         for (var element in value.docs) {
  //           print(element.get("NAME").toString() + "oiiir");
  //           unitNominees.add(CounsilorNomineeModel(
  //               element.get("NAME").toString(),
  //               element.get("MEMBER_ID").toString(),
  //               element.get("PHONE_NUMBER").toString(),
  //               element.get("PHOTO").toString(),
  //               false
  //           ));
  //           notifyListeners();
  //
  //         }
  //       }
  //       notifyListeners();
  //     });
  //   }

  void assemblyUnitNomineeList(String state, String district, String assembly,
      String unit, String from,) {
    unitNominees.clear();
    db
        .collection("MEMBERS")
        .where("DISTRICT", isEqualTo: district)
        .where("ASSEMBLY", isEqualTo: assembly)
        .where("UNIT_NOMINEE", isEqualTo: "TRUE")
        .where("ASSEMBLY_SHOW", isEqualTo: "TRUE")
        .snapshots()
        .listen((value) {
      if (value.docs.isNotEmpty) {
        unitNominees.clear();
        for (var element in value.docs) {
          print(element.id.toString()+' JVKGVRGV');
          unitNominees.add(CounsilorNomineeModel(
              element.get("NAME").toString(),
              element.get("MEMBER_ID").toString(),
              element.get("PHONE_NUMBER").toString(),
              element.get("PHOTO").toString(),'',
              false,'',''
          ));
          notifyListeners();
          searchUnitNominees = unitNominees;
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  void districtAssmblyNomineeList(String state, String district, String assembly,
      String unit, String from,) {
    assemblyNomineesNEW.clear();
    db
        .collection("MEMBERS")
        .where("STATE", isEqualTo: state)
        .where("DISTRICT", isEqualTo: district)
        .where("ASSEMBLY_COUNSELOR", isEqualTo: "TRUE")
        .where("DISTRICT_SHOW", isEqualTo: "TRUE")
        .snapshots()
        .listen((value) {
      if (value.docs.isNotEmpty) {
        assemblyNomineesNEW.clear();
        for (var element in value.docs) {
          print(element.id.toString()+' JVKGVRGV');
          assemblyNomineesNEW.add(CounsilorNomineeModel(
              element.get("NAME").toString(),
              element.get("MEMBER_ID").toString(),
              element.get("PHONE_NUMBER").toString(),
              element.get("PHOTO").toString(),'',
              false,'',''
          ));

          notifyListeners();

        }
      }
      notifyListeners();
    });
  }

  void nationalStatetNomineeList( String from,) {
    stateNomineesNew.clear();
    db
        .collection("MEMBERS")
        .where("STATE_COUNSELOR", isEqualTo: "TRUE")
        .where("NOMINEE_STATUS", isEqualTo: "YES")
        .where("NATIONAL_SHOW", isEqualTo: "TRUE")
        .snapshots()
        .listen((value) {
      if (value.docs.isNotEmpty) {
        stateNomineesNew.clear();
        for (var element in value.docs) {
          print(element.id.toString()+' JVKGVRGV');
          stateNomineesNew.add(CounsilorNomineeModel(
              element.get("NAME").toString(),
              element.get("MEMBER_ID").toString(),
              element.get("PHONE_NUMBER").toString(),
              element.get("PHOTO").toString(),'',
              false,'',''
          ));

          notifyListeners();

        }
      }
      notifyListeners();
    });
  }

  void stateDistrictNomineeList(String state, String from,) {
    districtNominees.clear();
    db
        .collection("MEMBERS")
        .where("STATE", isEqualTo: state)
        .where("ASSEMBLY_COUNSELOR", isEqualTo: "TRUE")
        .where("STATE_SHOW", isEqualTo: "TRUE")
        .snapshots()
        .listen((value) {
      if (value.docs.isNotEmpty) {
        districtNominees.clear();
        for (var element in value.docs) {
          print(element.id.toString()+' JVKGVRGV');
          districtNominees.add(CounsilorNomineeModel(
              element.get("NAME").toString(),
              element.get("MEMBER_ID").toString(),
              element.get("PHONE_NUMBER").toString(),
              element.get("PHOTO").toString(),'',
              false,'',''
          ));

          notifyListeners();
          searchDistrictNominees= districtNominees;
        }
      }
      notifyListeners();
    });
  }

    // void nomineesPanchayathWise(String state,String district,String assembly,String panchayath){
    //   print("ssssssssss   "+state);
    //   print("dddddddddd "+district);
    //   print("aaaaaaaaaaaaa  "+assembly);
    //   print("pppppppppp  "+panchayath);
    //   db
    //       .collection("NOMINEES")
    //       .where("STATE",isEqualTo:state)
    //       .where("DISTRICT",isEqualTo:district)
    //       .where("ASSEMBLY",isEqualTo:assembly)
    //       .where("PANCHAYATH",isEqualTo:panchayath)
    //       .get()
    //       .then((value){
    //       if(value.docs.isNotEmpty){
    //         panchayathNominees.clear();
    //         for(var element in value.docs){
    //           panchayathNominees.add(CounsilorNomineeModel(
    //               element.get("NAME"),
    //               element.get("MEMBER_ID"),
    //               element.get("PHONE_NUMBER"),
    //               element.get("PHOTO"),
    //               false
    //           ));
    //           notifyListeners();
    //         }
    //       }
    //       notifyListeners();
    //   });
    // }

    void nomineesAssemblyWise(String state, String district, String assembly, String from,) {
    print(' iudsbvufbvuifv'+state+' '+district+' '+assembly);
    assemblyNominees.clear();
      db
          .collection("MEMBERS")
          .where("DISTRICT", isEqualTo: district)
          .where("ASSEMBLY", isEqualTo: assembly)
          .where("ASSEMBLY_COUNSELOR", isEqualTo: "TRUE")
          .where('NOMINEE_STATUS', isEqualTo: "YES")
          .snapshots()
          .listen((value) {
        if (value.docs.isNotEmpty) {
          print("rtyryyr"+value.docs.length.toString());
          assemblyNominees.clear();
          for (var element in value.docs) {
            assemblyNominees.add(CounsilorNomineeModel(
                element.get("NAME").toString(),
                element.get("MEMBER_ID").toString(),
                element.get("PHONE_NUMBER").toString(),
                element.get("PHOTO").toString(),'',
                false,'',''
            ));
            notifyListeners();
            print("suytrts"+assemblyNominees.length.toString());
            searchAssemblyNominees= assemblyNominees;
            notifyListeners();
          }
        }
        notifyListeners();
      });
    }
    // void nomineesAssembly(String state, String district, String assembly, String from,) {
    // print(' iudsbvufbvuifv'+state+' '+district+' '+assembly);
    //   db
    //       .collection("MEMBERS")
    //       .where("STATE", isEqualTo: state)
    //       .where("DISTRICT", isEqualTo: district)
    //       .where("ASSEMBLY_COUNSELOR", isEqualTo: "TRUE")
    //       .where('NOMINEE_STATUS', isEqualTo: "YES")
    //       .get()
    //       .then((value) {
    //     if (value.docs.isNotEmpty) {
    //       print("rtyryyr"+value.docs.length.toString());
    //       assemblyNominees.clear();
    //       for (var element in value.docs) {
    //         print(element.get('DISTRICT_COUNSELOR').toString()+' JRIFJF  '+element.id);
    //         if(element.get('DISTRICT_COUNSELOR').toString()=='FALSE'){
    //           assemblyNominees.add(CounsilorNomineeModel(
    //               element.get("NAME").toString(),
    //               element.get("MEMBER_ID").toString(),
    //               element.get("PHONE_NUMBER").toString(),
    //               element.get("PHOTO").toString(),
    //               false
    //           ));
    //         }
    //
    //         notifyListeners();
    //         print("suytrts"+assemblyNominees.length.toString());
    //
    //       }
    //     }
    //     notifyListeners();
    //   });
    // }

    void nomineesDistrictWise(String state, String district, String from,) {
      districtNominees.clear();
      db
          .collection("MEMBERS")
          .where("STATE", isEqualTo: state)
          .where("DISTRICT", isEqualTo: district)
          .where("DISTRICT_COUNSELOR", isEqualTo: "TRUE")
          .where('NOMINEE_STATUS', isEqualTo: "YES")
          .snapshots().listen((value) {
        if (value.docs.isNotEmpty) {
          districtNominees.clear();
          for (var element in value.docs) {
            districtNominees.add(CounsilorNomineeModel(
                element.get("NAME").toString(),
                element.get("MEMBER_ID").toString(),
                element.get("PHONE_NUMBER").toString(),
                element.get("PHOTO").toString(),'',
                false,'',''
            ));
            notifyListeners();
            print("pospod"+districtNominees.length.toString());

            searchDistrictNominees=districtNominees;
            notifyListeners();
          }
        }
        notifyListeners();
      });
    }

    void nomineesStateWise(String state, String from,) {
      // stateNominees.clear();
      db
          .collection("MEMBERS")
          .where("STATE", isEqualTo: state)
          .where("STATE_COUNSELOR", isEqualTo: "TRUE")
          .where('NOMINEE_STATUS', isEqualTo: "YES")
          .snapshots().listen((value) {
        if (value.docs.isNotEmpty) {
          stateNominees.clear();
          for (var element in value.docs) {
            stateNominees.add(CounsilorNomineeModel(
                element.get("NAME").toString(),
                element.get("MEMBER_ID").toString(),
                element.get("PHONE_NUMBER").toString(),
                element.get("PHOTO").toString(),'',
                false,'',''
            ));
            notifyListeners();
            searchStateNominees = stateNominees;
            notifyListeners();
          }
        }
        notifyListeners();
      });
    }
    void nomineesnationalWise(String state, String from,) {
      nationalNominees.clear();
      db
          .collection("MEMBERS")
          .where("NATIONAL_COUNSELOR", isEqualTo: "TRUE")
          .where('NOMINEE_STATUS', isEqualTo: "YES")
          .snapshots().listen((value) {
        if (value.docs.isNotEmpty) {
          print(' nceunvuev');
          nationalNominees.clear();
          for (var element in value.docs) {
            nationalNominees.add(CounsilorNomineeModel(
                element.get("NAME").toString(),
                element.get("MEMBER_ID").toString(),
                element.get("PHONE_NUMBER").toString(),
                element.get("PHOTO").toString(),'',
                false,'',''
            ));
            notifyListeners();
            searchNationalNominees = nationalNominees;
            notifyListeners();
          }
        }
        notifyListeners();
      });
    }

    void fetchNominees(String from, String state, String district,
        String assembly, String unit) {
      print(from + ' JFKVFNJKV');

      if (from == "STATE_LEVEL") {
        nomineesStateWise(state, from);
        // nomineesDistrictWise(state,district);
      }
      else if (from == "DISTRICT_LEVEL") {
        nomineesDistrictWise(state, district, from);

        // nomineesAssemblyWise(state, district, assembly,from);
      }
      else if (from == "ASSEMBLY_LEVEL") {
        // nomineesUnitWise(state, district, assembly, unit, from);

        nomineesAssemblyWise(state, district, assembly, from);
      }
      else if (from == "UNIT_LEVEL") {
        nomineesUnit(state, district, assembly, unit, from);
      }else if(from=='NATIONAL_LEVEL'){
        nomineesnationalWise(state,from );
      }
    }

    List<CounsilorNomineeModel> getNominees(String from) {
    print(from+' CINFJCVF');
      if (from == 'NATIONAL_LEVEL') {
        return nationalNominees;
      }
      if (from == 'STATE_LEVEL') {
        return stateNominees;
      }
      if (from == 'DISTRICT_LEVEL') {
        return districtNominees;
      }
      if (from == 'ASSEMBLY_LEVEL') {
        return assemblyNominees;
      }
      if (from == 'UNIT_LEVEL') {
        return unitNominees;
      }
      return [];
    }

    bool coordinatorDeleteLoader = false;
    Future<void> deleteCordinator(String id,String from,String state, String district,
        String assembly,String unit,String phone,BuildContext ctxt,String uid) async {

      coordinatorDeleteLoader = true;
      notifyListeners();
     await db.collection("COORDINATORS").doc(id).get().then((value) async {
        if(value.exists){
          Map<dynamic, dynamic> map = value.data() as Map;
          print(map.toString()+"oriri");

          map["DELETED_BY"] = uid;
          map["DELETED_TIME"] = DateTime.now();
          map['DELETED_TYPE'] = "COORDINATOR";

         await db.collection("DELETED_DATA").doc(id).set(map.cast(),SetOptions(merge: true));
         notifyListeners();
          print(map.toString()+"cjjcj");
        }
      });

      await db.collection('COORDINATORS').doc(id).delete();

      await db.collection("USERS").where(id).get().then((value) async {
        print("kjhgtfr");
        if(value.docs.isNotEmpty){
          print("kjhgtfr");
         await  db.collection("MEMBERS").where("PHONE_NUMBER",isEqualTo: phone).get().then((value2) async {
            if(value2.docs.isNotEmpty){
              print("vhhgvghgvgdv");
              Map<dynamic,dynamic> map = HashMap();
              print("vhhgvghgvgdv"+value2.docs.first.get("NAME"));


              map["NAME"] = value2.docs.first.get("NAME").toString();
              map["PHONE_NUMBER"] ="+91${value2.docs.first.get("PHONE_NUMBER").toString()}";
              map["STATE"] = value2.docs.first.get("STATE").toString();
              map["DISTRICT"] = value2.docs.first.get("DISTRICT").toString();
              map["ASSEMBLY"] = value2.docs.first.get("ASSEMBLY").toString();
              map["UNIT"] = value2.docs.first.get("UNIT").toString();
              map["LEVEL"] = 'MEMBER_LEVEL';
              map["REF"] = "MEMBERS/${value2.docs.first.get("MEMBER_ID").toString()}";
              map["USER_ID"] = value2.docs.first.get("MEMBER_ID").toString();

              await db.collection('USERS').doc(id).delete();
              await db.collection("USERS").doc(map["USER_ID"]).set(map.cast(),SetOptions(merge: true));
              notifyListeners();
              print("cmmckjkj"+id);

            }else{
              await db.collection('USERS').doc(id).delete();
            }
          });
        }
        notifyListeners();
      });
      coordinatorDeleteLoader = false;
      notifyListeners();
      finish(ctxt);
      const snackBar = SnackBar(
          content: Text('Deleted Successfully'));
      ScaffoldMessenger.of(ctxt).showSnackBar(snackBar);

    if(from == "NATIONAL_LEVEL"){
      getCoordinators();
      print(' IRNFIRFNIRFN   '+from);
    }else if(from=="STATE_LEVEL"){
      getStateCoordinators(state);
    }
    else if(from=="DISTRICT_LEVEL"){
      getDistrictCoordinators(state,district);
    }
    else if(from=="ASSEMBLY_LEVEL"){
      getAssemblyCoordinators(state,district,assembly);
    } else if(from=="UNIT_LEVEL"){
      getUnitCoordinators(state,district,assembly,unit);
    }


    }


  bool checkMemberExist = false;

    bool coordinatorLoader = false;

    void addCoordinator(String from, String state, String district,
        String assembly,String unit,BuildContext context,String type,String coordId,String uId) async {

      coordinatorLoader = true;
      notifyListeners();

      String coordinatorId = DateTime.now().millisecondsSinceEpoch.toString();

      Map<String, Object> coordinatorMap = HashMap();
      Map<String, Object> userMap = HashMap();
      coordinatorMap["NAME"] = coordinatorName.text.toString();
      coordinatorMap["PHONE_NUMBER"] = coordinatorPhone.text.toString();
      coordinatorMap["ADDRESS"] = coordinatorAddress.text.toString();
      coordinatorMap["ADDED_BY"] = from;
      coordinatorMap["ADDED_DATE"] = DateTime.now();
      coordinatorMap["ADDED_DATE_MILLIS"] = DateTime.now().millisecondsSinceEpoch;
      coordinatorMap["ADDED_BY_ID"] = uId;
      if(type==''){
        coordinatorMap["COORDINATOR_ID"] = coordinatorId;
      }else{
        coordinatorMap["COORDINATOR_ID"] = coordId;

      }
      if (coordinatorImage != null) {
        String id = DateTime.now().millisecondsSinceEpoch.toString();
        ref = FirebaseStorage.instance.ref().child(id);
        await ref.putFile(coordinatorImage!).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            coordinatorMap["PHOTO"] = value;
            notifyListeners();
          });
          notifyListeners();
        });
        notifyListeners();
      } else {
        coordinatorMap["PHOTO"] = coordinatorImageUrl;
        notifyListeners();
      }
      // if(from=="PANCHAYATH_LEVEL"){
      //   coordinatorMap["STATE"] = state;
      //   coordinatorMap["DISTRICT"] = district;
      //   coordinatorMap["ASSEMBLY"] = assembly;
      //   coordinatorMap["PANCHAYATH"] = panchayath;
      //   coordinatorMap["UNIT"] = coordinatorUnit.text.toString();
      //
      //   userMap["STATE"] = state;
      //   userMap["DISTRICT"] = district;
      //   userMap["ASSEMBLY"] = assembly;
      //   userMap["PANCHAYATH"] = panchayath;
      //   userMap["UNIT"] = coordinatorUnit.text.toString();
      //
      // }else

      if (from == "UNIT_LEVEL") {
        coordinatorMap["STATE"] = state;
        coordinatorMap["DISTRICT"] = district;
        coordinatorMap["ASSEMBLY"] = assembly;
        coordinatorMap["UNIT"] = unit;
        coordinatorMap["DESIGNATION"] = "UNIT COORDINATOR";

        userMap["STATE"] = state;
        userMap["DISTRICT"] = district;
        userMap["ASSEMBLY"] = assembly;
        userMap["UNIT"] = unit;

      }
      else if (from == "ASSEMBLY_LEVEL") {
        coordinatorMap["STATE"] = state;
        coordinatorMap["DISTRICT"] = district;
        coordinatorMap["ASSEMBLY"] = assembly;
        // coordinatorMap["UNIT"] = unit;
        coordinatorMap["DESIGNATION"] = "ASSEMBLY COORDINATOR";

        userMap["STATE"] = state;
        userMap["DISTRICT"] = district;
        userMap["ASSEMBLY"] = assembly;
        // userMap["UNIT"] = unit;

      } else if (from == "DISTRICT_LEVEL") {
        coordinatorMap["STATE"] = state;
        coordinatorMap["DISTRICT"] = district;
        // coordinatorMap["ASSEMBLY"] = assembly;
        coordinatorMap["DESIGNATION"] = "DISTRICT COORDINATOR";

        userMap["STATE"] = state;
        userMap["DISTRICT"] = district;
        // userMap["ASSEMBLY"] = assembly;
      } else if (from == "STATE_LEVEL") {
        coordinatorMap["STATE"] = state;
        // coordinatorMap["DISTRICT"] = district;
        coordinatorMap["DESIGNATION"] = "STATE COORDINATOR";

        userMap["STATE"] = state;
        // userMap["DISTRICT"] = district;
      } else if (from == "NATIONAL_LEVEL") {
        // coordinatorMap["STATE"] = state;
        coordinatorMap["DESIGNATION"] = "NATIONAL COORDINATOR";

        // userMap["STATE"] = state;
      }


      userMap["NAME"] = coordinatorName.text.toString();
      userMap["PHONE_NUMBER"] = "+91${coordinatorPhone.text.toString()}";

      userMap["LEVEL"] = from;
      // if (from == "NATIONAL_LEVEL") {
      //   userMap["LEVEL"] = "STATE_LEVEL";
      // } else if (from == "STATE_LEVEL") {
      //   userMap["LEVEL"] = "DISTRICT_LEVEL";
      // } else if (from == "DISTRICT_LEVEL") {
      //   userMap["LEVEL"] = "ASSEMBLY_LEVEL";
      // } else if (from == "ASSEMBLY_LEVEL") {
      //   userMap["LEVEL"] = "UNIT_LEVEL";
      // }
      userMap["REF"] = "COORDINATORS/$coordinatorId";
      userMap["USER_ID"] = coordinatorId;

      bool numberStatus = false;
      if(type!="Edit"){
        print("jjkff"+type);
        numberStatus = await checkNumberExist('+91'+coordinatorPhone.text);
      }

      if(numberStatus){
        db
            .collection("COORDINATORS")
            .where("PHONE_NUMBER", isEqualTo: coordinatorPhone.text)
            .get().then((value) async {
              if(value.size==0){
                print(existMemberId+"oppopppo");
                await  db.collection("COORDINATORS").doc(coordinatorId).set(coordinatorMap);
                // await db.collection("USERS").doc(existMemberId).delete();
                await db.collection("USERS").doc(coordinatorId).set(userMap,SetOptions(merge: true));
                if(from == "NATIONAL_LEVEL"){
                  getCoordinators();
                  print(' IRNFIRFNIRFN   '+from);
                }
                else if(from=="STATE_LEVEL"){
                  getStateCoordinators(state);
                }
                else if(from=="DISTRICT_LEVEL"){
                  getDistrictCoordinators(state,district);
                }
                else if(from=="ASSEMBLY_LEVEL"){
                  getAssemblyCoordinators(state,district,assembly);
                }
                else if(from=="UNIT_LEVEL"){
                  getUnitCoordinators(state,district,assembly,unit);
                }
                finish(context);
              }else if(value.size>=1){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.red,
                  content: Center(
                    child: Text(
                      "Number Already Exist",style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ));

              }
        });
      }else if(!numberStatus){
        if(type!="Edit"){
          await  db.collection("COORDINATORS").doc(coordinatorId).set(coordinatorMap);
          await db.collection("USERS").doc(coordinatorId).set(userMap);
        }else{
          await  db.collection("COORDINATORS").doc(coordId).set(coordinatorMap,SetOptions(merge: true));
          await db.collection("USERS").doc(coordId).set(userMap,SetOptions(merge: true));
        }


        if(from == "NATIONAL_LEVEL"){
          getCoordinators();
          print(' IRNFIRFNIRFN   '+from);
        }
        else if(from=="STATE_LEVEL"){
          getStateCoordinators(state);
        }
        else if(from=="DISTRICT_LEVEL"){
          getDistrictCoordinators(state,district);
        }
        else if(from=="ASSEMBLY_LEVEL"){
          getAssemblyCoordinators(state,district,assembly);
        }
        else if(from=="UNIT_LEVEL"){
          getUnitCoordinators(state,district,assembly,unit);
        }

        coordinatorLoader= false;
        notifyListeners();
        finish(context);
      }






        //
        // if(!numberStatus&&!checkMemberExist){
        //   print(' JFJRKFNKJRFIRJF');
        //
        // } else if(numberStatus&&checkMemberExist){
        //   print("fkkvkf");
        //
        // }
        // else{
        // }

      notifyListeners();
    }

  String existMemberId= '';
  Future<bool> checkNumberExist(String phone) async {
    print(phone+' hhhh');
    checkMemberExist = false;
    var D = await db
        .collection("USERS")
        .where("PHONE_NUMBER", isEqualTo: phone)
        .get();
    if (D.docs.isNotEmpty) {
      print(D.docs.first.get('LEVEL').toString()+"dkkiir");
     String level=  D.docs.first.get('LEVEL').toString();
    if(level == "MEMBER"){
      checkMemberExist = true;
      notifyListeners();
      print("dhfhfhb"+checkMemberExist.toString());
      existMemberId = D.docs.first.get("USER_ID").toString();
      print("fkkfk"+checkMemberExist.toString()+existMemberId);
      await db.collection("USERS").doc(existMemberId).delete();

      return true;
    }else{
      checkMemberExist= false;
      return true;
    }

    } else {
      checkMemberExist = false;
      return false;
    }
  }


    bool coordinatorExist = false;
    Future<void> checkCoordinatorExistCheck(String phone,BuildContext context)  async {
    coordinatorExist= false;
    notifyListeners();
print("sabdnasbmfds"+coordinatorExist.toString());
      await db.collection("COORDINATORS").where(
          "PHONE_NUMBER", isEqualTo: coordinatorPhone.text.toString())
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          coordinatorExist = true;
          notifyListeners();
        }
        else {
          coordinatorExist = false;
          const snackBar = SnackBar(
          content: Text('This number already exist'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        notifyListeners();

      }
      notifyListeners();
    });
   print('snmanfmamnasbddsad'+coordinatorExist.toString());
  }

    void clearCoordinators() {
      coordinatorName.clear();
      coordinatorPhone.clear();
      coordinatorAddress.clear();
      coordinatorUnit.clear();
      coordinatorPanchayath.clear();
      coordinatorAssembly.clear();
      coordinatorDistrict.clear();
      coordinatorState.clear();
      coordinatorImage = null;
      notifyListeners();
    }


  bool checkLevel =false;
   checkUserMemberExist(String phone) async {
    print(phone+' uuuu');
    checkLevel = false;
    var data = await db
        .collection("USERS")
        .where("PHONE_NUMBER", isEqualTo: phone)
        .get();
     if(data.docs.isNotEmpty){
        print("ccdjjc "+checkLevel.toString());
       if(data.docs.first.get("LEVEL") == 'MEMBER_LEVEL' ){
           print("ijiii ");
          checkLevel = true;
           notifyListeners();
       }
       else{
         checkLevel = false;
         notifyListeners();
         print("jjiii "+checkLevel.toString());

       }
    }else{
       checkLevel = true;
       notifyListeners();
     }
  }




  bool checkNumber = false;
    bool checkVoterId = false;
    alreadyExistNumber(String phone) async {
      print("qqqqq1" + phone);
      checkNumber = false;

      var data = await db.collection("MEMBERS").where("PHONE_NUMBER", isEqualTo: phone).get();
      if (data.docs.isNotEmpty) {
        checkNumber = true;
        print("ndfjsdbf$checkNumber");
        notifyListeners();
      } else {
        checkNumber = false;
        print(checkNumber.toString() + "ajdnesew");
        notifyListeners();
      }
      print("jansmdsmfdsm" + checkNumber.toString());
    }

  alreadyExistVoterId(String voterId,String registerType) async {
    print("qqqqq1" + voterId.toString());

    checkVoterId = false;
    if(registerType == "WITH ID"){
      var data = await db.collection("MEMBERS").where("VOTER_ID", isEqualTo: voterId).get();
      if (data.docs.isNotEmpty) {
        checkVoterId = true;
        notifyListeners();
      }  else {
        checkVoterId = false;

        print(checkVoterId.toString() + "tyassrr");

        notifyListeners();
      }
    }else{
      checkVoterId = false;
      notifyListeners();
    }

  }


    void getUnitCommitees(String state, String district, String assembly,
        String unit,String from) {
      var dataSnapshot;
      if(from=='UNIT_LEVEL'){
        dataSnapshot=db.collection("MEMBERS").where("STATE", isEqualTo: state).where(
            "DISTRICT", isEqualTo: district).where("ASSEMBLY", isEqualTo: assembly)
            .where("UNIT", isEqualTo: unit).where("COMMITTEE_MEMBER_STATUS", isEqualTo: "YES")
            .where('DESIGNATION_LEVEL',isEqualTo: 'UNIT_LEVEL');
      }else if(from=='ASSEMBLY_LEVEL'){
        dataSnapshot=db.collection("MEMBERS").where("STATE", isEqualTo: state).where(
            "DISTRICT", isEqualTo: district).where(
            "ASSEMBLY", isEqualTo: assembly).where('DESIGNATION_LEVEL',isEqualTo: 'ASSEMBLY_LEVEL')
            .where("COMMITTEE_MEMBER_STATUS", isEqualTo: "YES");
      }else if(from=='DISTRICT_LEVEL'){
        dataSnapshot=db.collection("MEMBERS").where("STATE", isEqualTo: state).where(
            "DISTRICT", isEqualTo: district).where('DESIGNATION_LEVEL',isEqualTo: 'DISTRICT_LEVEL')
            .where("COMMITTEE_MEMBER_STATUS", isEqualTo: "YES");
      }else if(from=='STATE_LEVEL'){
        dataSnapshot=db.collection("MEMBERS").where("STATE", isEqualTo: state)
            .where('DESIGNATION_LEVEL',isEqualTo: 'STATE_LEVEL')
            .where("COMMITTEE_MEMBER_STATUS", isEqualTo: "YES");
      }else if(from=='NATIONAL_LEVEL'){
        dataSnapshot=db.collection("MEMBERS").where('DESIGNATION_LEVEL',isEqualTo: 'NATIONAL_LEVEL')
            .where("COMMITTEE_MEMBER_STATUS", isEqualTo: "YES");
      }
      dataSnapshot.snapshots().listen((value) {
        committeeDesignationModelList.clear();
        if (value.docs.isNotEmpty) {
          for (var i in value.docs) {
            Map<dynamic, dynamic> map = i.data();
            committeeDesignationModelList.add(
                CommitteeDesignationModel(
                    memberId: map["MEMBER_ID"],
                    photo: map["PHOTO"],
                    name: map["NAME"],
                    desination: map["DESIGNATION"]
                ));
            notifyListeners();
          }
        }
        notifyListeners();
      });
      notifyListeners();
    }



    void getRequests(String state,) {
      print("ririir");
      requestMembersList.clear();
      db.collection("MEMBERS")
          .where("STATE", isEqualTo: state)
          // .where("DISTRICT", isEqualTo: district)
          // .where("ASSEMBLY", isEqualTo: assembly)
          .where("REQUEST_STATUS", isEqualTo: "PENDING")
          .get().then((value) {
        print(value.docs.length.toString() + "ioioyoy");
        if (value.docs.isNotEmpty) {
          requestMembersList.clear();
          print(value.docs.length.toString() + "f78f7f");
          for (var e in value.docs) {
            requestMembersList.add(RequestMembershipModel(
              e.get("MEMBER_ID").toString(),
              e.get("NAME").toString(),
              e.get("PHONE_NUMBER").toString(),
              e.get("PHOTO").toString(),
              e.get("STATE").toString(),
              e.get("DISTRICT").toString(),
              e.get("ASSEMBLY").toString(),
              e.get("UNIT").toString(),
            ));
            notifyListeners();
            filterRequestMembersList= requestMembersList;
            notifyListeners();
          }
        }
        notifyListeners();
      });
      notifyListeners();
    }

    void acceptRequest(String id, String uId,String name,String phone, String state, String district, String assembly, String unit,) {
      HashMap<String, Object> map = HashMap();
      HashMap<String, Object> unitMap = HashMap();
      HashMap<String, Object> userMap = HashMap();

      map["REQUEST_STATUS"] = "APPROVE";
      map["APPROVED_BY"] = uId;
      map["APPROVED_DATE"] = DateTime.now();
      db.collection("MEMBERS").doc(id).set(map, SetOptions(merge: true));

      db.collection("TOTAL_STATES").doc(state).set({"PAID_MEMBERS":FieldValue.increment(1)},SetOptions(merge: true));
      db.collection("TOTAL_ASSEMBLY").doc(assembly).set({"PAID_MEMBERS_ASSEMBLY":FieldValue.increment(1),"PAID_MEMBERS_DISTRICT":FieldValue.increment(1)},SetOptions(merge: true));

      userMap["NAME"] = name;
      userMap["PHONE_NUMBER"] ="+91$phone";
      userMap["STATE"] = state;
      userMap["DISTRICT"] = district;
      userMap["ASSEMBLY"] = assembly;
      userMap["UNIT"] = unit;
      userMap["LEVEL"] = "MEMBER_LEVEL";
      userMap["REF"] = "MEMBERS/$id";
      userMap["USER_ID"] = id;
      db.collection("USERS").doc(id).set(userMap, SetOptions(merge: true));

      unitMap["STATE"] = state;
      unitMap["DISTRICT"] = district;
      unitMap["ASSEMBLY"] = assembly;
      unitMap["UNIT"] = unit;
      unitMap["ADDED_BY"] = uId;
      unitMap["ADDED_TIME"] = DateTime.now();
      unitMap['ADDED_TIME_MILLIS']=DateTime.now().millisecondsSinceEpoch;

      db.collection("UNITS").doc('${district}_${assembly}_$unit').get().then((value) {
        if (value.exists) {} else {
          db.collection("UNITS").doc('${district}_${assembly}_$unit').set(unitMap, SetOptions(merge: true));
          notifyListeners();
        }
      });
      getRequests(state,);
      // db.collection("UNITS").doc()

      // db.collection("MEMBERS").doc(id).get().then((value2){
      //   if(value2.exists){
      //   }else{
      //     db.collection("MEMBERS").doc(id).set(map.cast());
      //     // db.collection("REQUEST").doc(id).set({"STATUS" :"REGISTERED"},SetOptions(merge: true));
      //     notifyListeners();
      //   }
      // });
      notifyListeners();
    }

    void rejectRequest(String id,String state,String district,String assembly,String uId) {
      HashMap<String, Object> map = HashMap();
      map["REQUEST_STATUS"] = "REJECTED";
      map["REJECTED_BY"] = uId;
      map["REJECTED_DATE"] = DateTime.now();

      db.collection("MEMBERS").doc(id).set(map,SetOptions(merge: true));
      getRequests(state);
      notifyListeners();
    }


    void whatsappLaunch({@required number, @required message}) async {
      if (number
          .toString()
          .length == 10) {
        number = "+91$number";
      }
      String url = "whatsapp://send?phone=$number&text=$message";
      await canLaunchUrl(Uri.parse(url))
          ? launchUrl(Uri.parse(url))
          : print("can't open whatsapp");
      // await canLaunchUrl(Uri.parse(url)) ? launchUrl(Uri.parse(url)) :print("can't open whatsapp");
      // whatsappLaunch(number:number,message: "*Hello*" );
    }


    void makingPhoneCall(String Phone) async {
      String url = "";
      url = 'tel:$Phone';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    List<String> memberList = [];

    void getMembersCount(String state, String district, String assembly,
        String unit, String from) {
      // if (from == "NATIONAL_LEVEL") {
      //   print(state + "1st");
      //   allMembers = 0;
      //   memberList.clear();
      //   db.collection("MEMBERS")
      //       .get()
      //       .then((value) {
      //     if (value.docs.isNotEmpty) {
      //       memberList.clear();
      //       for(var e in value.docs){
      //         Map<dynamic, dynamic> map = e.data();
      //         if(!map.containsKey("REQUEST_STATUS")){
      //           memberList.add(map.toString());
      //           allMembers = memberList.length;
      //           notifyListeners();
      //         }else if(map["REQUEST_STATUS"] == "APPROVE"){
      //           memberList.add(map.toString());
      //             allMembers = memberList.length;
      //             notifyListeners();
      //
      //         }else{
      //         }
      //       }
      //       // allMembers = value.docs.length;
      //       // notifyListeners();
      //     }
      //   });
      // } else if (from == "STATE_LEVEL") {
      //   print(state + "2d");
      //   print(district + "123456789");
      //   allMembers = 0;
      //   memberList.clear();
      //   db.collection("MEMBERS")
      //       .where("STATE", isEqualTo: state)
      //       .get()
      //       .then((value) {
      //     memberList.clear();
      //     for(var e in value.docs){
      //       Map<dynamic, dynamic> map = e.data();
      //       if(!map.containsKey("REQUEST_STATUS")){
      //         memberList.add(map.toString());
      //         allMembers = memberList.length;
      //         notifyListeners();
      //       }else if(map["REQUEST_STATUS"] == "APPROVE"){
      //         memberList.add(map.toString());
      //         allMembers = memberList.length;
      //         print(map.length.toString()+"  333333");
      //         notifyListeners();
      //
      //       }else{
      //       }
      //     }
      //     // if (value.docs.isNotEmpty) {
      //     //   allMembers = value.docs.length;
      //     //   notifyListeners();
      //     // }
      //   });
      // } else if (from == "DISTRICT_LEVEL") {
      //   print(state + "3rd");
      //   print(district + "0000000000");
      //   allMembers = 0;
      //   memberList.clear();
      //   db.collection("MEMBERS")
      //       .where("STATE", isEqualTo: state)
      //       .where("DISTRICT", isEqualTo: district)
      //       .get()
      //       .then((value) {
      //     memberList.clear();
      //     for(var e in value.docs){
      //       Map<dynamic, dynamic> map = e.data();
      //       if(!map.containsKey("REQUEST_STATUS")){
      //         memberList.add(map.toString());
      //         allMembers = memberList.length;
      //         notifyListeners();
      //       }else if(map["REQUEST_STATUS"] == "APPROVE"){
      //         memberList.add(map.toString());
      //         allMembers = memberList.length;
      //         notifyListeners();
      //
      //       }else{
      //       }
      //     }
      //     // if (value.docs.isNotEmpty) {
      //     //   allMembers = value.docs.length;
      //     //   notifyListeners();
      //     // }
      //   });
      // } else
      //   if(from == "ASSEMBLY_LEVEL"){
      //   print(state+'  '+district+'  '+assembly+' DEDEDEED');
      //   allMembers = 0;
      //   memberList.clear();
      //   db.collection("MEMBERS")
      //       .where("STATE", isEqualTo: state)
      //       .where("DISTRICT", isEqualTo: district)
      //       .where("ASSEMBLY", isEqualTo: assembly)
      //       .get()
      //       .then((value) {
      //     memberList.clear();
      //     for(var e in value.docs){
      //       Map<dynamic, dynamic> map = e.data();
      //       if(!map.containsKey("REQUEST_STATUS")){
      //         memberList.add(map.toString());
      //         allMembers = memberList.length;
      //         notifyListeners();
      //       }else if(map["REQUEST_STATUS"] == "APPROVE"){
      //         memberList.add(map.toString());
      //         allMembers = memberList.length;
      //         notifyListeners();
      //
      //       }else{
      //       }
      //     }
      //     // if (value.docs.isNotEmpty) {
      //     //   allMembers = value.docs.length;
      //     //   notifyListeners();
      //     // }
      //   });
      // }
      if(from=="UNIT_LEVEL"){
        allUnPaidMembersCount = 0;
        memberList.clear();
        print(district+'ll  '+assembly+'pp '+unit+' J J JF CFJC');
        db.collection("MEMBERS")
            .where("DISTRICT", isEqualTo: district)
            .where("ASSEMBLY", isEqualTo: assembly)
            .where("UNIT", isEqualTo: unit)
            .get()
            .then((value) {
          memberList.clear();
          for(var e in value.docs){
            Map<dynamic, dynamic> map = e.data();
            if(!map.containsKey("REQUEST_STATUS")){
              memberList.add(map.toString());
              allPaidMembersCount = memberList.length;
              notifyListeners();

            }else if(map["REQUEST_STATUS"] == "APPROVE"){
              memberList.add(map.toString());
              allPaidMembersCount = memberList.length;
              notifyListeners();

            }else{
            }
          }
          // if (value.docs.isNotEmpty) {
          //   allMembers = value.docs.length;
          //   notifyListeners();
          // }
        });
      }
      notifyListeners();
    }



  void getUnPaidMembersCount( String state, String district, String assembly,
        String unit, String from ) {
      // if (from == "NATIONAL_LEVEL") {
      //   print(state + "1st");
      //   allUnPaidMembers = 0;
      //   db.collection("MEMBERS").where("STATUS",isEqualTo: "REGISTERED").get().then((value) {
      //     if (value.docs.isNotEmpty) {
      //       allUnPaidMembers = value.docs.length;
      //       notifyListeners();
      //     }
      //     notifyListeners();
      //   });
      // }
      // else if (from == "STATE_LEVEL") {
      //   print(state + "2d");
      //   print(district + "123456789");
      //   allUnPaidMembers = 0;
      //   db.collection("MEMBERS")
      //       .where("STATE", isEqualTo: state).where("STATUS",isEqualTo: "REGISTERED")
      //       .get()
      //       .then((value) {
      //     if (value.docs.isNotEmpty) {
      //       allUnPaidMembers = value.docs.length;
      //       notifyListeners();
      //     }
      //     notifyListeners();
      //   });
      // }
      // else if (from == "DISTRICT_LEVEL") {
      //   print(state + "3rd");
      //   print(district + "0000000000");
      //   allUnPaidMembers = 0;
      //   db.collection("MEMBERS").where("STATE", isEqualTo: state).where(
      //       "DISTRICT", isEqualTo: district).where("STATUS",isEqualTo: "REGISTERED").get().then((value) {
      //     if (value.docs.isNotEmpty) {
      //       allUnPaidMembers = value.docs.length;
      //       notifyListeners();
      //     }
      //     notifyListeners();
      //   });
      // }
      // else  if(from == "ASSEMBLY_LEVEL"){
      //   print(state+'  '+district+'  '+assembly+' DEDEDEED');
      //   allUnPaidMembers = 0;
      //   db.collection("MEMBERS").where("STATE", isEqualTo: state).where(
      //       "DISTRICT", isEqualTo: district).
      //   where("ASSEMBLY", isEqualTo: assembly).where("STATUS",isEqualTo: "REGISTERED")
      //       .get()
      //       .then((value) {
      //     if (value.docs.isNotEmpty) {
      //       allUnPaidMembers = value.docs.length;
      //       notifyListeners();
      //     }
      //     notifyListeners();
      //   });
      // }
      if(from=="UNIT_LEVEL"){
        allUnPaidMembersCount = 0;
        print(district+'ll  '+assembly+'pp '+unit+' J J JF CFJC');
        db.collection("MEMBERS")
            .where("DISTRICT", isEqualTo: district)
            .where("ASSEMBLY", isEqualTo: assembly)
            .where("UNIT", isEqualTo: unit)
            .where("STATUS",isEqualTo: "REGISTERED")
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            allUnPaidMembersCount = value.docs.length;
            notifyListeners();
          }
          notifyListeners();
        });
      }
      notifyListeners();
    }


  searchRequestMembers(txt){
    print("nmnsdfsd"+txt);
    requestMembersList = filterRequestMembersList
        .where((a) => a.name.toLowerCase().contains(txt.toLowerCase()) ||
        a.memberId.toLowerCase().contains(txt.toLowerCase())||
        a.phone.toLowerCase().contains(txt.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void getCoordinators(){
    coordinatorList.clear();
      db.collection("COORDINATORS")
          .where("DESIGNATION",isEqualTo: "NATIONAL COORDINATOR")
          .get()
          .then((value){
        if(value.docs.isNotEmpty){
          coordinatorList.clear();
          for(var e in value.docs){
            Map<dynamic, dynamic> map = e.data();
            coordinatorList.add(CoordinatorModel(
                map["NAME"].toString(),
                map["PHONE_NUMBER"].toString(),
                e.id.toString(),
                map["PHOTO"].toString(),
                map["DESIGNATION"].toString(),
                map["STATE"]??"",
                map["DISTRICT"]??"",
                map["ASSEMBLY"]??"",
                map["UNIT"]??"",

            ));
            notifyListeners();
          }
        }
        notifyListeners();
      });
  }

  void getStateCoordinators(String state){
      print("state1111 "+state);
      coordinatorStateList.clear();
    db.collection("COORDINATORS")
        .where("STATE",isEqualTo: state)
        .where("DESIGNATION",isEqualTo: "STATE COORDINATOR")
        .get()
        .then((value){
          if(value.docs.isNotEmpty){
        coordinatorStateList.clear();
        for(var e in value.docs){
          Map<dynamic, dynamic> map = e.data();
          print(map.toString()+" TTTTTTTTT");
          coordinatorStateList.add(CoordinatorModel(
            map["NAME"].toString(),
            map["PHONE_NUMBER"].toString(),
            e.id.toString(),
            map["PHOTO"].toString(),
            map["DESIGNATION"].toString(),
            map["STATE"].toString(),
            map["DISTRICT"]??"",
            map["ASSEMBLY"]??"",
            map["UNIT"]??"",
          ));
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  void getDistrictCoordinators(String state,String district){
    coordinatorDistrictList.clear();
    db.collection("COORDINATORS")
        .where("STATE",isEqualTo: state)
        .where("DISTRICT",isEqualTo: district)
        .where("DESIGNATION",isEqualTo: "DISTRICT COORDINATOR")
        .get()
        .then((value){
      if(value.docs.isNotEmpty){
        coordinatorDistrictList.clear();
        for(var e in value.docs){
          Map<dynamic, dynamic> map = e.data();
        coordinatorDistrictList.add(CoordinatorModel(
            map["NAME"].toString(),
            map["PHONE_NUMBER"].toString(),
            e.id.toString(),
            map["PHOTO"].toString(),
            map["DESIGNATION"].toString(),
            map["STATE"].toString(),
            map["DISTRICT"].toString(),
            map["ASSEMBLY"]??"",
            map["UNIT"]??"",
          ));
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  void getAssemblyCoordinators(String state,String district,String assembly){
    coordinatorAssemblyList.clear();
    db.collection("COORDINATORS")
        .where("STATE",isEqualTo: state)
        .where("DISTRICT",isEqualTo: district)
        .where("ASSEMBLY",isEqualTo: assembly)
        .where("DESIGNATION",isEqualTo: "ASSEMBLY COORDINATOR")
        .get()
        .then((value){
      if(value.docs.isNotEmpty){
        coordinatorAssemblyList.clear();
        for(var e in value.docs){
          Map<dynamic, dynamic> map = e.data();
          coordinatorAssemblyList.add(CoordinatorModel(
            map["NAME"].toString(),
            map["PHONE_NUMBER"].toString(),
            e.id.toString(),
            map["PHOTO"].toString(),
            map["DESIGNATION"].toString(),
            map["STATE"].toString(),
            map["DISTRICT"].toString(),
            map["ASSEMBLY"].toString(),
            map["UNIT"]??"",
          ));
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  void getUnitCoordinators(String state,String district,String assembly,String unit){
    coordinatorUnitList.clear();
    db.collection("COORDINATORS")
        .where("STATE",isEqualTo: state)
        .where("DISTRICT",isEqualTo: district)
        .where("ASSEMBLY",isEqualTo: assembly)
        .where("UNIT",isEqualTo: unit)
        .where("DESIGNATION",isEqualTo: "UNIT COORDINATOR")
        .get()
        .then((value){
      coordinatorUnitList.clear();
      if(value.docs.isNotEmpty){
        coordinatorUnitList.clear();
        for(var e in value.docs){
          Map<dynamic, dynamic> map = e.data();
          coordinatorUnitList.add(CoordinatorModel(
            map["NAME"].toString(),
            map["PHONE_NUMBER"].toString(),
            e.id.toString(),
            map["PHOTO"].toString(),
            map["DESIGNATION"].toString(),
            map["STATE"].toString(),
            map["DISTRICT"].toString(),
            map["ASSEMBLY"].toString(),
            map["UNIT"].toString(),
          ));
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  List<CoordinatorModel> getCoordinator(String from) {

    if (from == 'NATIONAL_LEVEL') {
      return coordinatorList;
    }
    if (from == 'STATE_LEVEL') {
      return coordinatorStateList;
    }
    if (from == 'DISTRICT_LEVEL') {
      return coordinatorDistrictList;
    }
    if (from == 'ASSEMBLY_LEVEL') {
      return coordinatorAssemblyList;
    }
    if (from == 'UNIT_LEVEL') {
      return coordinatorUnitList;
    }
    return [];
  }


  void editCoordinator(String id){
    db.collection("COORDINATORS").doc(id).get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> map = value.data() as Map;
        coordinatorName.text = map["NAME"].toString();
        coordinatorAddress.text = map["ADDRESS"].toString();
        coordinatorImageUrl = map["PHOTO"].toString();
        coordinatorPhone.text = map["PHONE_NUMBER"].toString();
      }
    });
    notifyListeners();
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            scrollable: true,
            title: Container(
              child: const Text(
                "Do you want to exit?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            content: Container(
              // height: 50,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: myGreen),
                            borderRadius: BorderRadius.circular(10,),
                          ),
                          child: TextButton(
                              child: const Text('YES',
                                  style: TextStyle( color: Colors.black )),
                              onPressed: () {
                                SystemNavigator.pop();
                              }),
                        ),
                        Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: myDarkGreen),
                            color: myDarkGreen,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: TextButton(
                              child: const Text(
                                'NO',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                finish(context);
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }



  Future<void> saveImageToGallery(Uint8List imageBytes) async {
    // Save the image to the device's gallery
    final result = await ImageGallerySaver.saveImage(imageBytes, quality: 100);

    // Show a message to the user
    if (result['isSuccess']) {
      print('Image saved to gallery.');
    } else {
      print('Failed to save image to gallery.');
    }
  }


  Future<void> loopMembers() async {
    HashMap<String, Object> map = HashMap();
    int i=0;
    await db.collection("MEMBERS").get().then((value) async {
      for(var e in value.docs) {
       i++;
        map["UNIT_NOMINEE"] = "FALSE";
        map["UNIT_SHOW"] = "TRUE";
        map["ASSEMBLY_SHOW"] = "TRUE";
        map["DISTRICT_SHOW"] = "TRUE";
        map["STATE_SHOW"] = "TRUE";
        map["NATIONAL_SHOW"] = "TRUE";
        map["ASSEMBLY_COUNSELOR"] = "FALSE";
        map["DISTRICT_COUNSELOR"] = "FALSE";
        map["STATE_COUNSELOR"] = "FALSE";
        map["NATIONAL_COUNSELOR"] = "FALSE";
        await db.collection("MEMBERS").doc(e.id).set(map,SetOptions(merge: true));
        print(i.toString() + "MEMBERS1111");
     }});
    print(i.toString()+"99999999999");
    }

  void selectedMembersFetchForCommitee (String state,String district,String assembly,String unit,String from){
    print("aaaaaaa"+state+"_"+district+"_"+assembly+"_"+unit+'  '+from);

    var dataSnapshot;
    if(from=='UNIT_LEVEL'){
      dataSnapshot=
          db.collection("MEMBERS")
              .where("DISTRICT",isEqualTo:district)
              .where("ASSEMBLY", isEqualTo:assembly)
              .where("STATUS", isEqualTo:'PAID')
              .where("UNIT",isEqualTo:unit);
    }else if(from=='ASSEMBLY_LEVEL'){
      dataSnapshot=
          db.collection("MEMBERS")
              .where("STATE",isEqualTo:state)
              .where("DISTRICT",isEqualTo:district)
              .where("ASSEMBLY", isEqualTo:assembly)
              .where("STATUS", isEqualTo:'PAID')
              .where("UNIT_NOMINEE", isEqualTo:'TRUE');
    }else if(from=='DISTRICT_LEVEL'){
      dataSnapshot=
          db.collection("MEMBERS")
              .where("STATE",isEqualTo:state)
              .where("DISTRICT",isEqualTo:district)
              .where("STATUS", isEqualTo:'PAID')
              .where("ASSEMBLY_COUNSELOR", isEqualTo:'TRUE');
    }else if(from=='STATE_LEVEL'){
      dataSnapshot=
          db.collection("MEMBERS")
              .where("STATE",isEqualTo:state)
              .where("STATUS", isEqualTo:'PAID')
              .where("DISTRICT_COUNSELOR", isEqualTo:'TRUE');
    }else if(from=='NATIONAL_LEVEL'){
      dataSnapshot=
          db.collection("MEMBERS")
              .where("STATUS", isEqualTo:'PAID')
              .where("NATIONAL_COUNSELOR", isEqualTo:'TRUE');
    }

    dataSnapshot.snapshots().listen((value) {
      selectCommiteeList.clear();
      if(value.docs.isNotEmpty){
        for(var element in value.docs){
          Map<dynamic, dynamic> map = element.data();
          selectCommiteeList.add(CounsilorNomineeModel(
              map["NAME"].toString(),
              map["MEMBER_ID"].toString(),
              map["PHONE_NUMBER"].toString(),
              map["PHOTO"]??'',map['COMMITTEE_MEMBER_STATUS']??"",
              false,
            map['DESIGNATION']??'',
            map['DESIGNATION_LEVEL']??''

          ));
          print(selectCommiteeList.length.toString()+"sdfs");
          notifyListeners();
        }
        notifyListeners();
      }else{
        print("sdfdsfqqq");
      }
    });
  }


  void searchNominees(String from,String item){
    if(from=='NATIONAL_LEVEL'){
      print(searchNationalNominees.length.toString()+' IJCNIJCNFC');
      nationalNominees = searchNationalNominees
          .where((a) =>
      a.name.contains(item.toLowerCase()) ||
          a.name.contains(item.toLowerCase()))
          .toList();
      notifyListeners();
    }else  if(from=='STATE_LEVEL'){
      stateNominees = searchStateNominees
          .where((a) =>
      a.name.toLowerCase().contains(item.toLowerCase()) ||
          a.name.toLowerCase().contains(item.toLowerCase()))
          .toList();
      notifyListeners();
    }else if(from=='DISTRICT_LEVEL'){
      districtNominees = searchDistrictNominees
          .where((a) =>
      a.name.toLowerCase().contains(item.toLowerCase()) ||
          a.name.toLowerCase().contains(item.toLowerCase()))
          .toList();
      notifyListeners();
    }else if(from=='ASSEMBLY_LEVEL'){
      assemblyNominees = searchAssemblyNominees
          .where((a) =>
      a.name.toLowerCase().contains(item.toLowerCase()) ||
          a.name.toLowerCase().contains(item.toLowerCase()))
          .toList();
      notifyListeners();
    }else if(from=='UNIT_LEVEL'){
      unitNominees = searchUnitNominees
          .where((a) =>
      a.name.toLowerCase().contains(item.toLowerCase()) ||
          a.name.toLowerCase().contains(item.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }

  Future<void> loopLock() async {
    var jsonText = await rootBundle.loadString('assets/IYC_JSON.json');
    var jsonResponse = json.decode(jsonText.toString());
    Map <dynamic, dynamic> jsonMap = await jsonResponse as Map;
    int i=0;
    jsonMap.forEach((key, value) async {
      HashMap<String, Object> map = HashMap();
      map["COMMITTEE_LOCK"] ="OFF";
      map["COUNSELOR_LOCK"] ="OFF";
      map["MEMBER_LOCK"] ="OFF";
      map["COORDINATOR_LOCK"] ="OFF";
      map["UNIT_LOCK"] ="OFF";

      mRootReference.child("StateAdditionLock").child(value['State'].toString()).update(map);
      i++;
      print(i.toString()+"uuiuiui");
    });
    print(i.toString()+"prororo");
    }

    bool stateCommitteeLock = false;
    bool stateCounselorLock = false;
    bool stateMemberLock = false;
    bool stateCoordinatorLock = false;
    bool addUnitLock = false;

    void checkStateAdditionLock(String state){
      stateCommitteeLock=false;
      stateCounselorLock=false;
      stateMemberLock=false;
      stateCoordinatorLock=false;
      addUnitLock=false;

      mRootReference.child("StateAdditionLock").child(state).onValue.listen((event) {
        if(event.snapshot.exists) {
          Map<dynamic, dynamic> map = event.snapshot.value as Map;
          print(map.toString()+"tiiii");
            print(map['MEMBER_LOCK'].toString()+"TYUIUIUIUI");

            if(map["MEMBER_LOCK"].toString()=="ON"){
              stateMemberLock = true;
              notifyListeners();
            }else{
              stateMemberLock = false;
              notifyListeners();
            }

            if(map["COORDINATOR_LOCK"].toString() == "ON"){
              stateCoordinatorLock = true;
              notifyListeners();
            }else{
              stateCoordinatorLock = false;
              notifyListeners();
            }

            if(map["COUNSELOR_LOCK"].toString()  == "ON"){
              stateCounselorLock = true;
              notifyListeners();
            }else{
              stateCounselorLock = false;
              notifyListeners();
            }

            if(map["COMMITTEE_LOCK"].toString()  == "ON"){
              stateCommitteeLock = true;
              notifyListeners();
            }else{
              stateCommitteeLock = false;
              notifyListeners();
            }
            if(map["UNIT_LOCK"].toString()== "ON"){
              addUnitLock = true;
              notifyListeners();
            }else{
              addUnitLock = false;
              notifyListeners();
            }

        }
      });
      notifyListeners();
    }

  void fetchDetails() {
    mRoot.child('0').onValue.listen((event) {
      if(event.snapshot.exists){
        Map<dynamic,dynamic> map = event.snapshot.value as Map;

        contactNumber=map['PhoneNumber']??'';

      }
    });
  }





  void alertSupport(context){
    // HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            contentPadding: EdgeInsets.zero,


            title: const Align(
                alignment: Alignment.center,
                child: Text("Support",
                  style: TextStyle(fontFamily: "PoppinsMedium"),)),

            content:
            Container(
              height: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  InkWell(
                    onTap: (){
                      launch("tel://${contactNumber}");
                      finish(context);
                    },
                    child: Container(
                      width: 248,
                      height: 46,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 1),
                          borderRadius: BorderRadius.circular(23),
                          color: Colors.white
                      ),
                      alignment: Alignment.center,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.phone,color: Colors.black,size: 20),
                          const SizedBox(width: 6,),
                          Text(
                            'Call',
                            style: TextStyle(color: Colors.black,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      launch('whatsapp://send?phone=${contactNumber}');
                      finish(context);
                    },
                    child: Container(
                      width: 248,
                      height: 46,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 1),
                          borderRadius: BorderRadius.circular(23),
                          color: Colors.white
                      ),
                      alignment: Alignment.center,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/whatsapp.png",scale: 2.5,),
                          // Icon(Icons.whatsapp_sharp),
                          SizedBox(width: 3,),
                          Text(
                            'WhatsApp',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,)
                ],
              ),
            ),


          );
        });



  }


  List<masterCordinatorModel> stateCordinator(String state){
    List<masterCordinatorModel> stateRegList=[];
    stateRegList=masterCordinatorList.where((element) => element.state == state).where((element) => element.designation=='STATE COORDINATOR')
        .toSet()
        .toList();
    stateRegList.sort((b, a) =>
        a.count
            .compareTo(b.count));
    return stateRegList;
  }

  List<masterCordinatorModel> districtCordinator(String state,String district){
    List<masterCordinatorModel> stateRegList=[];
    stateRegList=masterCordinatorList.where((element) => element.state == state).where((element) => element.district==district)
        .where((element) => element.designation=='DISTRICT COORDINATOR')
        .toSet()
        .toList();
    stateRegList.sort((b, a) =>
        a.count
            .compareTo(b.count));
    return stateRegList;
  }
  List<masterCordinatorModel> assemblyCordinator(String state,String district,String assembly){
    List<masterCordinatorModel> stateRegList=[];
    stateRegList=masterCordinatorList.where((element) => element.state == state)
        .where((element) => element.district==district)
        .where((element) => element.assembly==assembly)
        .where((element) => element.designation=='ASSEMBLY COORDINATOR')
        .toSet()
        .toList();
    stateRegList.sort((b, a) =>
        a.count
            .compareTo(b.count));
    return stateRegList;
  }

  List<masterCordinatorModel> unitCordinator(String state,String district,String assembly,String unit){
    List<masterCordinatorModel> stateRegList=[];
    stateRegList=masterCordinatorList
        .where((element) => element.district==district)
        .where((element) => element.assembly==assembly)
        .where((element) => element.unit==unit)
        .where((element) => element.designation=='UNIT COORDINATOR')
        .toSet()
        .toList();
    stateRegList.sort((b, a) =>
        a.count
            .compareTo(b.count));
    return stateRegList;
  }

  void addMasterCordinatorData(String from,String state,String district,String assembly){
      dynamic dataSnapshots;

      if(from=='NATIONAL_LEVEL'){
        dataSnapshots= db.collection('COORDINATORS');
      }else if(from=='STATE_LEVEL'){
        dataSnapshots= db.collection('COORDINATORS').where('STATE',isEqualTo: state);
      }else if(from=='DISTRICT_LEVEL'){
        dataSnapshots= db.collection('COORDINATORS').where('STATE',isEqualTo: state).where('DISTRICT',isEqualTo: district);;
      }else if(from=='ASSEMBLY_LEVEL'){
        dataSnapshots= db.collection('COORDINATORS').where('STATE',isEqualTo: state)
            .where('DISTRICT',isEqualTo: district).where('ASSEMBLY',isEqualTo: assembly);
      }

    masterCordinatorList.clear();
      dataSnapshots.get().then((value){
      if(value.docs.isNotEmpty){
        for(var elements in value.docs){
          Map<dynamic,dynamic> map = elements.data() as Map;
          DateTime dateTime=DateTime.now();
          if(map["ADDED_DATE"]!=null){
            Timestamp date = map["ADDED_DATE"];
            dateTime = date.toDate();
          }

          masterCordinatorList.add(masterCordinatorModel(
              elements.id,
              map['ADDED_BY'].toString(),
              map['ADDED_DATE_MILLIS'].toString(),
              dateTime,
              map['ADDRESS'].toString(),
              map['DESIGNATION'].toString(),
              map['NAME'].toString(),
              map['PHONE_NUMBER'].toString(),
              map['PHOTO'].toString(),
              map['STATE']??'',
              map['DISTRICT']??'',
              map['ASSEMBLY']??'',
              map['UNIT']??'',0));
          print(masterCordinatorList.length.toString()+' NFJKVKRGVNKRGNV KRGV');
          notifyListeners();
        }
      }
    });
  }
  
  void fetchMasterCoordinatorsDetails(String state,String district,String assembly,String from){
      dynamic datasnapShots;
      if(from=='NATIONAL_LEVEL'){
        datasnapShots=db.collection('COORDINATORS').where('STATE',isEqualTo: 'DELHI');
      }else if(from=='STATE_LEVEL'){
        datasnapShots=db.collection('COORDINATORS').where('STATE',isEqualTo: state);
      }else if(from=='DISTRICT_LEVEL'){
        datasnapShots=db.collection('COORDINATORS').where('STATE',isEqualTo: state).where('DISTRICT',isEqualTo: district);
      }else if(from=='ASSEMBLY_LEVEL'){
        datasnapShots=db.collection('COORDINATORS').where('STATE',isEqualTo: state).where('ASSEMBLY',isEqualTo: assembly);
      }




      FilterMasterCoordinatorDetailsList.clear();
    MasterCoordinatorDetailsList.clear();
      datasnapShots.get().then((value){
      if(value.docs.isNotEmpty) {
        for (var elements in value.docs) {
          Map<dynamic, dynamic> map = elements.data() as Map;
          FilterMasterCoordinatorDetailsList.add(
              MasterCoordinatorDetailsModel(
                  elements.id,
                  map['NAME'].toString(),
                  '0',
                  map['DESIGNATION']??'',
                  map['STATE']??'',
                  map['DISTRICT']??'',
                  map['ASSEMBLY']??'',
                  map['UNIT']??'',
                  map['PHONE_NUMBER']??''));
          MasterCoordinatorDetailsList=FilterMasterCoordinatorDetailsList;
        }
        checkCoordinatorAddedMembers();

        notifyListeners();
        print(MasterCoordinatorDetailsList.length.toString()+' JJJHHHHHH');
      }
      });
  }

  void checkCoordinatorAddedMembers()  {
      // print(MasterCoordinatorDetailsList.length.toString()+' NFIVNIVNGV');
      for(var elelemts in MasterCoordinatorDetailsList){
        db.collection('MEMBERS').where('ADDED_BY',isEqualTo: elelemts.coordinatorID).get().then((value){
          if(value.docs.isNotEmpty){
            elelemts.NumberofMembers=value.size.toString();
            // print(value.size.toString()+' yyyyyyyyyyyyyyyyyyyy '+ elelemts.coordinatorID+' '+elelemts.name+' '+elelemts.district);
            notifyListeners();
          }
        });
      }
      oFFReportLoader();
  }


  late  YoutubePlayerController videoController;
  int videoIndex = 0;
  List<LanguageModel> languageList = [];
  String videoLanguage = '';
  String videoId = '';
  String description = '';
  String firstVideo = '';
  String planVideo = "";
  String english = "";
  String malayalam = "";
  String hindi = "";
  String level4 = "";
  String level5 = "";
  bool videoUrl = false;
  List<bool> plyCheck = [false, false, false];

  getLanguages(BuildContext context,String appLanguage) {
    languageList.clear();
    db.collection("VIDEOS").get().then((event) {
      if(event.docs.isNotEmpty){
        languageList.clear();
        for (var element in event.docs) {
          db.collection("VIDEOS").doc(element.id).get().then((value){
            if(value.exists){
              Map<dynamic, dynamic> map = value.data() as Map;
              if (element.id == appLanguage) {
                videoId = map["LINK"].toString();
                description = map["DESCRIPTION"].toString();
                callNext(HowToUseScreen(videoId: videoId, description: description, language: element.id,), context);
                notifyListeners();
              }
              languageList.add(LanguageModel(element.id, map["LINK"].toString(), map["DESCRIPTION"].toString(),));
            }
          });

        }
        notifyListeners();
      }

      notifyListeners();

    });

  }

  videoPlay() {
    videoController = YoutubePlayerController(
      initialVideoId: languageList.first.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        hideControls: false,
        endAt: 0,
        mute: true,
      ),
    );
    notifyListeners();
  }
  changePlayPause(index) {
    for (int i = 0; i < plyCheck.length; i++) {
      if (plyCheck[i] == true) {
        plyCheck[i] = false;
      } else if (i != index) {
        plyCheck[i] = false;
      } else {
        plyCheck[i] = true;

      }
    }

    notifyListeners();
  }

  getVideoIndex() {
    plyCheck = [false, false, false];

    notifyListeners();
  }
  
  
  void addProfessions(){
    String profession = memberProfession.text.toString().toUpperCase();
    Map<String, Object> map = HashMap();
        print("fooifiof");
        map[profession] = profession;
        mRootReference.child("PROFESSIONS").update(map);
  }
  
  void getProfessions(){
    professionList.clear();
    mRootReference.child("PROFESSIONS").once().then((value){
      if(value.snapshot.exists){
        professionList.clear();
        Map<dynamic,dynamic> map=value.snapshot.value as Map;
        map.forEach((key, value) {
          professionList.add(value.toString());
          notifyListeners();
        });
      }
    });
    notifyListeners();
  }

  void addEducation(){
    String education = memberEducation.text.toString().toUpperCase();
    Map<String, Object> map = HashMap();
    print("fooifiof");
    map[education] = education;
    mRootReference.child("EDUCATION").update(map);
  }
  void getEducations(){
    educationList.clear();
    mRootReference.child("EDUCATION").once().then((value){
      if(value.snapshot.exists){
        educationList.clear();
        Map<dynamic,dynamic> map=value.snapshot.value as Map;
        map.forEach((key, value) {
          educationList.add(value.toString());
          notifyListeners();
        });
      }
    });
    notifyListeners();
  }

  String requestAlertContent='';
  void getRequestConditions(){
    mRootReference.child("0").onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        requestAlertContent= map["TermsAndCondition"].toString();
        notifyListeners();
      }
      notifyListeners();
    });
  }

  List<DocumentSnapshot> memberDocList = [];

  getMemberList(String phone) {
    var tenDigit = "";

    try {
      tenDigit = phone.substring(3, 13);
    } catch (e) {}

    db
        .collection("MEMBERS")
        .where("PHONE_NUMBER", isEqualTo: tenDigit)
        .get()
        .then((value) {
      memberDocList = value.docs;
      print(memberDocList.length.toString()+"dkjiddj");
      print(value.docs.first.get("VOTER_ID").toString()+"kfkkf");
      // print(value.docs.first.get("REQUEST_STATUS").toString()+"dkjiddj");
      notifyListeners();
    });
  }

  int allPaidMembersCount=0;
  int allUnPaidMembersCount=0;
  void getAllMembersCount(){
    allPaidMembersCount=0;
    allUnPaidMembersCount=0;
    db.collection("TOTAL_STATES").get().then((value) {
      if (value.docs.isNotEmpty) {
        for(var element in value.docs){
          print(element.get("STATE").toString()+" oooopppppp "+element.get("PAID_MEMBERS").toString()+" njjjkk "+element.get("UNPAID_MEMBERS").toString());
          allPaidMembersCount = allPaidMembersCount + int.parse(element.get("PAID_MEMBERS").toString())
              + int.parse(element.get("UNPAID_MEMBERS").toString());
          notifyListeners();
          print(allPaidMembersCount.toString()+"sppoppso");
          allUnPaidMembersCount = allUnPaidMembersCount + int.parse(element.get("UNPAID_MEMBERS").toString());
          notifyListeners();
        }
      }
    });
    
    notifyListeners();
  }


  void getPaidMemberCountState(String state){
    allPaidMembersCount = 0;
    allUnPaidMembersCount = 0;
    db.collection("TOTAL_STATES").doc(state).get().then((value){
      print(state.toString()+"iouiii");
      if(value.exists){
        Map<dynamic, dynamic> map = value.data() as Map;
        print(state.toString()+"ii988");
        allPaidMembersCount= allPaidMembersCount+int.parse(map['PAID_MEMBERS'].toString())+int.parse(map['UNPAID_MEMBERS'].toString());
        notifyListeners();

        allUnPaidMembersCount =allUnPaidMembersCount+int.parse(map['UNPAID_MEMBERS'].toString());
        notifyListeners();
      }
    });
  }


  void getPaidMemberCountDistrict(String district){
    allPaidMembersCount = 0;
    allUnPaidMembersCount = 0;
    print("eueuiu");

    var d1=db.collection("TOTAL_ASSEMBLY").where("DISTRICT",isEqualTo:district).get();

    d1.then((value) {
      if(value.docs.isNotEmpty){
        allPaidMembersCount = 0;
        allUnPaidMembersCount = 0;
        for(var e in value.docs) {
          allPaidMembersCount= int.parse(e.get("PAID_MEMBERS_DISTRICT").toString())+
              int.parse(e.get("UNPAID_MEMBERS_DISTRICT").toString());

          print(allPaidMembersCount.toString()+"jjkhhh");
          notifyListeners();
          allUnPaidMembersCount =int.parse(e.get("UNPAID_MEMBERS_DISTRICT").toString());
          notifyListeners();
        }

      }
    });

  }
  void getPaidMemberCountAssembly(String district,String assembly,){

    allPaidMembersCount = 0;
    allUnPaidMembersCount = 0;

    print(district+"totiit"+assembly);
    var d2=db.collection("TOTAL_ASSEMBLY").where("DISTRICT",isEqualTo:district).where("ASSEMBLY",isEqualTo:assembly).get();

    d2.then((value2){
      if(value2.docs.isNotEmpty){
        for(var k in value2.docs){
          allPaidMembersCount= allPaidMembersCount+
              int.parse(k.get("PAID_MEMBERS_ASSEMBLY").toString())+
              int.parse(k.get("UNPAID_MEMBERS_ASSEMBLY").toString());
          notifyListeners();
          allUnPaidMembersCount = allUnPaidMembersCount+int.parse(k.get("UNPAID_MEMBERS_ASSEMBLY").toString());
          notifyListeners();
        }
      }
     print( allPaidMembersCount.toString()+"dkdiii"+allUnPaidMembersCount.toString());
    });

  }

  Future<void> stateTotal() async {
    var jsonText = await rootBundle.loadString('assets/IYC_JSON.json');
    var jsonResponse = json.decode(jsonText.toString());
    Map <dynamic, dynamic> jsonMap = await jsonResponse as Map;
    int i=0;
    jsonMap.forEach((key, value) async {
      HashMap<String, Object> map = HashMap();
      map["STATE"] = value['State'].toString();
      map["PAID_MEMBERS"] = 0;
      map["UNPAID_MEMBERS"] = 0;
      db.collection("TOTAL_STATES").doc(value['State'].toString()).set(map,SetOptions(merge: true));
      i++;
      print(i.toString()+"uuiuiui");
      print(value['State'].toString()+"mmmmmmmmmmm");
    });
    print(i.toString()+"prororo");
  }

  Future<void> assemblyTotal() async {
    var jsonText = await rootBundle.loadString('assets/IYC_JSON.json');
    var jsonResponse = json.decode(jsonText.toString());
    Map <dynamic, dynamic> jsonMap = await jsonResponse as Map;
    int i=0;
    jsonMap.forEach((key, value) async {
      HashMap<String, Object> map = HashMap();
      map["STATE"] = value['State'].toString();
      map["DISTRICT"] = value['District'].toString();
      map["ASSEMBLY"] = value['Assembly'].toString();
      map["PAID_MEMBERS_DISTRICT"] = 0;
      map["PAID_MEMBERS_ASSEMBLY"] = 0;
      map["UNPAID_MEMBERS_DISTRICT"] = 0;
      map["UNPAID_MEMBERS_ASSEMBLY"] = 0;
      db.collection("TOTAL_ASSEMBLY").doc(value['Assembly'].toString()).set(map,SetOptions(merge: true));
      i++;
      print(i.toString()+"uuiuiui");
      print(value['State'].toString()+"mmmmmmmmmmm");
      print(value['Assembly'].toString()+"nnnnnnnnnnnnn");
    });
    print(i.toString()+"prororo");
  }

  List<String> memberCountList = [];
  String count='';
  void updateStateCount(){
    db.collection("TOTAL_STATES").get().then((value){
      if(value.docs.isNotEmpty){
        for(var e in value.docs) {
          print(e.id+"eoeooo");
        var data=db.collection("MEMBERS").where("STATE",isEqualTo: e.id).where("STATUS",isEqualTo:'PAID').get();
        var data2=db.collection("MEMBERS").where("STATE",isEqualTo: e.id).where("STATUS",isNotEqualTo:'PAID').get();
        
      data.then((valueeee){
        if(valueeee.docs.isNotEmpty){
          memberCountList.clear();
          for(var k in valueeee.docs ){
            print("weeuu");
            Map<dynamic,dynamic>map=k.data();

            if(!map.containsKey("REQUEST_STATUS")){
              print(e.id+"ooo99999999");
              db.collection("TOTAL_STATES").doc(e.id).set({"PAID_MEMBERS": double.parse(valueeee.docs.length.toString())},SetOptions(merge: true));

            }else{
              if(map["REQUEST_STATUS"].toString()=="APPROVE"){
                print("ifuhygtgyhujikl"+valueeee.docs.length.toString());
                print("ooiiiuui"+map.length.toString());
                memberCountList.add(map.toString());
                notifyListeners();
                print(e.id+"peeeeeeeeeeeeep");
                db.collection("TOTAL_STATES").doc(e.id).set({"PAID_MEMBERS": double.parse(memberCountList.length.toString())},SetOptions(merge: true));
              }
            }
          }
        }
      });
      data2.then((val){
        db.collection("TOTAL_STATES").doc(e.id).set({"UNPAID_MEMBERS": double.parse(val.docs.length.toString())},SetOptions(merge: true));

      });
        }
      }
    });
  }

  Future<void> loopStateWiseCountSetting() async {
    int ii=0;
  await  db.collection('MEMBERS').get().then((value) async {
      if(value.docs.isNotEmpty){
        print('Total Member Count :'+value.docs.length.toString());
        for(var elemets in value.docs){
          print('Now at :'+ii.toString());
          ii=ii+1;
          Map<dynamic,dynamic> map=elemets.data() as Map;
          if(map['STATUS'].toString()=='PAID' && !map.containsKey("REQUEST_STATUS")){
            String totalAmount='1';
            if(map['STATE']!='' && map['STATE'].toString()!='null'){
              print(elemets.id+' PPPPPAAAAAAAAAAAAAAAAAAAA');
              await db.collection('TOTAL_STATES').doc(map['STATE']).update(
                  {"PAID_MEMBERS": FieldValue.increment(double.parse(totalAmount.toString()))});
            }

          }else if(map['STATUS'].toString()=='PAID' && map.containsKey("REQUEST_STATUS")){
            if(map["REQUEST_STATUS"].toString()=="APPROVE"){
              String totalAmount='1';
              if(map['STATE']!='' && map['STATE'].toString()!='null') {
                print(elemets.id+' OOOOOOOOOOPPPPPPPPPPPPP');
                await db.collection('TOTAL_STATES').doc(map['STATE']).update({
                      "PAID_MEMBERS": FieldValue.increment(
                          double.parse(totalAmount.toString()))
                    });
              }
            }
          } else if(map['STATUS'].toString()=='REGISTERED'){
            String totalAmount='1';
            if(map['STATE']!='' && map['STATE'].toString()!='null') {
              print(elemets.id+' UUUUUUUUUUOOOOOOOOOOOOOOOOO');
              await db.collection('TOTAL_STATES').doc(map['STATE']).update({
                    "UNPAID_MEMBERS": FieldValue.increment(
                        double.parse(totalAmount.toString()))
                  });
            }
          }
        }
      }
    });
  }


  Future<void> loopAssemblyWiseCount() async {
    int ii=0;
   await db.collection('MEMBERS').get().then((value) async {
      if(value.docs.isNotEmpty) {
        print('Total Member Count :' + value.docs.length.toString());
        for (var elemets in value.docs) {
          print('Now at :' + ii.toString()+' '+elemets.id);
          ii = ii + 1;
          Map<dynamic, dynamic> map = elemets.data() as Map;
          if(map['ASSEMBLY']!='' &&map['ASSEMBLY'].toString()!='null'&&
              map['DISTRICT']!='' &&map['DISTRICT'].toString()!='null' &&
              map['STATE']!='' &&map['STATE'].toString()!='null'
          ){


            if(map['STATUS'].toString()=='PAID' && !map.containsKey("REQUEST_STATUS")){
              await   db.collection('TOTAL_ASSEMBLY')
                    .where('STATE',isEqualTo: map['STATE'].toString())
                    .where('DISTRICT',isEqualTo: map['DISTRICT'].toString())
                    .where('ASSEMBLY',isEqualTo: map['ASSEMBLY'].toString()).get().then((value) async {
                      if(value.docs.isNotEmpty){
                        for(var eee in value.docs){
                          if(eee.id==map['ASSEMBLY'].toString()) {
                            print(eee.id + ' HHHHH ' + map['ASSEMBLY']);
                            String totalAmount = '1';
                            await db.collection('TOTAL_ASSEMBLY').doc(
                                map['ASSEMBLY']).update(
                                {"PAID_MEMBERS_ASSEMBLY": FieldValue.increment(
                                    double.parse(totalAmount.toString()))});
                          }
                        }
                      }
                });

            }
            else if(map['STATUS'].toString()=='PAID' && map.containsKey("REQUEST_STATUS")){
              if(map["REQUEST_STATUS"].toString()=="APPROVE") {
                await  db.collection('TOTAL_ASSEMBLY')
                    .where('STATE', isEqualTo: map['STATE'].toString())
                    .where('DISTRICT', isEqualTo: map['DISTRICT'].toString())
                    .where('ASSEMBLY', isEqualTo: map['ASSEMBLY'].toString())
                    .get()
                    .then((value) async {
                  if (value.docs.isNotEmpty) {
                    for (var eee in value.docs) {
                      print(eee.id + ' WWWWWWWWW ' + map['ASSEMBLY']);
                      if(eee.id==map['ASSEMBLY'].toString()) {
                        String totalAmount = '1';
                        await db.collection('TOTAL_ASSEMBLY')
                            .doc(map['ASSEMBLY'])
                            .update({"PAID_MEMBERS_ASSEMBLY": FieldValue
                            .increment(double.parse(totalAmount.toString()))});
                      }
                    }
                  }
                });
              }

            }
            else if(map['STATUS'].toString()=='REGISTERED'){
              await  db.collection('TOTAL_ASSEMBLY')
                  .where('STATE', isEqualTo: map['STATE'].toString())
                  .where('DISTRICT', isEqualTo: map['DISTRICT'].toString())
                  .where('ASSEMBLY', isEqualTo: map['ASSEMBLY'].toString())
                  .get()
                  .then((value) async {
                if (value.docs.isNotEmpty) {
                  for (var eee in value.docs) {
                    if(eee.id==map['ASSEMBLY'].toString()) {
                      print(eee.id + ' RRRRRRRRRRRR ' + map['ASSEMBLY']);
                      String totalAmount = '1';
                      await db.collection('TOTAL_ASSEMBLY')
                          .doc(map['ASSEMBLY'])
                          .update({
                        "UNPAID_MEMBERS_ASSEMBLY": FieldValue.increment(
                            double.parse(totalAmount.toString()))
                      });
                    }
                  }
              }
              });
            }

            await  db.collection('TOTAL_ASSEMBLY').where('STATE',isEqualTo: map['STATE'])
                .where('DISTRICT',isEqualTo: map['DISTRICT'])
                .get().then((value) async {
              if(value.docs.isNotEmpty){
                for(var elemts in value.docs){

                  Map<dynamic,dynamic> map = elemts.data() as Map;
                  if(map['STATUS'].toString()=='PAID' && !map.containsKey("REQUEST_STATUS")) {
                    print(elemts.id+' INCFVNFVNF');
                    String totalAmount = '1';
                    await db.collection('TOTAL_ASSEMBLY').doc(elemts.id).update(
                        {"PAID_MEMBERS_DISTRICT": FieldValue.increment(double
                            .parse(totalAmount.toString()))});
                  }else if(map['STATUS'].toString()=='PAID' && map.containsKey("REQUEST_STATUS")) {
                    if (map["REQUEST_STATUS"].toString() == "APPROVE") {
                      print(elemts.id+' INCFVNFVNF');
                      String totalAmount = '1';
                      await db.collection('TOTAL_ASSEMBLY').doc(elemts.id).update(
                          {"PAID_MEMBERS_DISTRICT": FieldValue.increment(double
                              .parse(totalAmount.toString()))});
                    }
                  }else if(map['STATUS'].toString()=='REGISTERED'){
                    print(elemts.id+' INCFVNFVNF');
                    String totalAmount = '1';
                    await db.collection('TOTAL_ASSEMBLY').doc(elemts.id).update(
                        {"UNPAID_MEMBERS_DISTRICT": FieldValue.increment(double
                            .parse(totalAmount.toString()))});
                  }
                }
              }
            });

          }
        }
      }
      });
  }


  Future<void> LOOPdISTRICT([dynamic lastDoc = false]) async {
    int ii=0;
    await db.collection('MEMBERS').orderBy('MEMBER_ID',descending: false) .startAfter([lastDoc]).where("STATE",isEqualTo: "KARNATAKA").get().then((value) async {
      if(value.docs.isNotEmpty) {
        print('Total Member Count All :' + value.docs.length.toString());
        for (var elemets in value.docs) {
          print('Now at :' + ii.toString()+' '+elemets.id);
          ii = ii + 1;
          Map<dynamic, dynamic> map = elemets.data() as Map;
          if(ii==2001){
            print(' HJBHBJBHJB'+elemets.id);
          }

          if(map['DISTRICT']!='' &&map['DISTRICT'].toString()!='null' &&
              map['STATE']!='' &&map['STATE'].toString()!='null'){

            print(map['STATE'].toString()+' NFV DWDWDW'+map['DISTRICT'].toString());
            await  db.collection('TOTAL_ASSEMBLY').where('STATE',isEqualTo:'KARNATAKA')
                .where('DISTRICT',isEqualTo: map['DISTRICT'].toString())
                .get().then((value) async {
              if(value.docs.isNotEmpty){
                print(' UBNFUVNUV');
                for(var elemts in value.docs){
                  if(map['STATUS'].toString()=='PAID' && !map.containsKey("REQUEST_STATUS")) {
                    print(elemts.id+' INCFVNFVNF');
                    String totalAmount = '1';
                    await db.collection('TOTAL_ASSEMBLY').doc(elemts.id).update(
                        {"PAID_MEMBERS_DISTRICT": FieldValue.increment(double
                            .parse(totalAmount.toString()))});
                  }else if(map['STATUS'].toString()=='PAID' && map.containsKey("REQUEST_STATUS")) {
                    if (map["REQUEST_STATUS"].toString() == "APPROVE") {
                      print(elemts.id+' EWFEFFR');
                      String totalAmount = '1';
                      await db.collection('TOTAL_ASSEMBLY').doc(elemts.id).update(
                          {"PAID_MEMBERS_DISTRICT": FieldValue.increment(double
                              .parse(totalAmount.toString()))});
                    }
                  }else if(map['STATUS'].toString()=='REGISTERED'){
                    print(elemts.id+' QWEDEWFFW');
                    String totalAmount = '1';
                    await db.collection('TOTAL_ASSEMBLY').doc(elemts.id).update(
                        {"UNPAID_MEMBERS_DISTRICT": FieldValue.increment(double
                            .parse(totalAmount.toString()))});
                  }
                }
              }
            });

          }
        }
      }
    });
  }

  Future<void> addedByIssueClearence() async {
    int i=0;
   await db.collection('MEMBERS').where('ADDED_BY',isEqualTo: '1691669951526').get().then((value) async {
      if(value.docs.isNotEmpty){
        i=i+1;
        print('Now at Count :'+i.toString());
        for(var elemets in value.docs){
          print('Total Count :'+value.docs.length.toString());
          HashMap<String,Object> mapp= HashMap();
          mapp['ADDED_BY']='1691654455669';
          await  db.collection('MEMBERS').doc(elemets.id).set(mapp,SetOptions(merge: true));

        }
      }
    });
  }

  bool clearDistrictBool=false;


  Future<void> clearDistrictCount() async {
    clearDistrictBool=true;
    notifyListeners();
   await db.collection('TOTAL_ASSEMBLY').where('STATE',isEqualTo:regReportStateCT.text)
        .where('DISTRICT',isEqualTo:regReportdistNameCT.text).get().then((value) async {
      if(value.docs.isNotEmpty) {
        print('Total  :' + value.docs.length.toString());
        for (var elemets in value.docs) {
          HashMap<String,Object> maaap=HashMap();
          maaap['UNPAID_MEMBERS_DISTRICT']=0;
          maaap['PAID_MEMBERS_DISTRICT']=0;
          await db.collection('TOTAL_ASSEMBLY').doc(elemets.id).set(maaap,SetOptions(merge: true));

        }
        clearDistrictBool=false;
        notifyListeners();
      }
    });
  }
  Future<void> districtWiseLoopppp() async {
    clearDistrictBool=true;
    notifyListeners();
    int ii=0;
    if(regReportStateCT.text!='' && regReportStateCT.text!='null'&&regReportdistNameCT.text!='' && regReportdistNameCT.text!='null'){
      await db.collection('MEMBERS')
          .where("STATE",isEqualTo: regReportStateCT.text)
          .where("DISTRICT",isEqualTo: regReportdistNameCT.text)
          .get().then((value) async {
        if(value.docs.isNotEmpty) {
          print('Total Member Count All :' + value.docs.length.toString());
          for (var elemets in value.docs) {
            print('Now at :' + ii.toString()+' '+elemets.id);
            ii = ii + 1;
            Map<dynamic, dynamic> map = elemets.data() as Map;
            if(map['DISTRICT']!='' &&map['DISTRICT'].toString()!='null' &&
                map['STATE']!='' &&map['STATE'].toString()!='null'){
              print(map['STATE'].toString()+' NFV '+map['DISTRICT'].toString());
              await  db.collection('TOTAL_ASSEMBLY').where('STATE',isEqualTo: map['STATE'].toString())
                  .where('DISTRICT',isEqualTo: map['DISTRICT'].toString())
                  .get().then((value) async {
                if(value.docs.isNotEmpty){
                  for(var elemts in value.docs){
                    if(map['STATUS'].toString()=='PAID' && !map.containsKey("REQUEST_STATUS")) {
                      print(elemts.id+' INCFVNFVNF');
                      String totalAmount = '1';
                      await db.collection('TOTAL_ASSEMBLY').doc(elemts.id).update(
                          {"PAID_MEMBERS_DISTRICT": FieldValue.increment(double
                              .parse(totalAmount.toString()))});
                    }else if(map['STATUS'].toString()=='PAID' && map.containsKey("REQUEST_STATUS")) {
                      if (map["REQUEST_STATUS"].toString() == "APPROVE") {
                        print(elemts.id+' EWFEFFR');
                        String totalAmount = '1';
                        await db.collection('TOTAL_ASSEMBLY').doc(elemts.id).update(
                            {"PAID_MEMBERS_DISTRICT": FieldValue.increment(double
                                .parse(totalAmount.toString()))});
                      }
                    }else if(map['STATUS'].toString()=='REGISTERED'){
                      print(elemts.id+' QWEDEWFFW');
                      String totalAmount = '1';
                      await db.collection('TOTAL_ASSEMBLY').doc(elemts.id).update(
                          {"UNPAID_MEMBERS_DISTRICT": FieldValue.increment(double
                              .parse(totalAmount.toString()))});
                    }
                  }
                }
              });

            }
          }
          clearDistrictBool=false;
          notifyListeners();
        }
      });
    }

  }

  Future<void> assemblyWiseLoopppp() async {
    clearDistrictBool=true;
    notifyListeners();
    int ii=0;
    if(selectLoopStateCT.text!='' && selectLoopStateCT.text!='null'&&selectLoopDistrictCT.text!='' && selectLoopDistrictCT.text!='null'&&selectLoopAssemblyCT.text!='' && selectLoopAssemblyCT.text!='null'){
      await db.collection('MEMBERS')
          .where("STATE",isEqualTo: selectLoopStateCT.text)
          .where("DISTRICT",isEqualTo: selectLoopDistrictCT.text)
          .where("ASSEMBLY",isEqualTo: selectLoopAssemblyCT.text)
          .get().then((value) async {
        if(value.docs.isNotEmpty) {
          print('Total Member Count All :' + value.docs.length.toString());
          for (var elemets in value.docs) {
            print('Now at :' + ii.toString()+' '+elemets.id);
            ii = ii + 1;
            Map<dynamic, dynamic> map = elemets.data() as Map;
            if(map['ASSEMBLY']!='' &&map['ASSEMBLY'].toString()!='null' &&
                map['DISTRICT']!='' &&map['DISTRICT'].toString()!='null' &&
                map['STATE']!='' &&map['STATE'].toString()!='null'){
              print(map['STATE'].toString()+' NFV '+map['DISTRICT'].toString()+' NFV '+map['ASSEMBLY'].toString());
              await  db.collection('TOTAL_ASSEMBLY')
                  .where('STATE',isEqualTo: map['STATE'].toString())
                  .where('DISTRICT',isEqualTo: map['DISTRICT'].toString())
                  .where('ASSEMBLY',isEqualTo: map['ASSEMBLY'].toString())
                  .get().then((value) async {
                if(value.docs.isNotEmpty){
                  for(var elemts in value.docs){
                    if(map['STATUS'].toString()=='PAID' && !map.containsKey("REQUEST_STATUS")) {
                      print(elemts.id+' INCFVNFVNF');
                      String totalAmount = '1';
                      await db.collection('TOTAL_ASSEMBLY').doc(elemts.id).update(
                          {"PAID_MEMBERS_ASSEMBLY": FieldValue.increment(double
                              .parse(totalAmount.toString()))});
                    }else if(map['STATUS'].toString()=='PAID' && map.containsKey("REQUEST_STATUS")) {
                      if (map["REQUEST_STATUS"].toString() == "APPROVE") {
                        print(elemts.id+' EWFEFFR');
                        String totalAmount = '1';
                        await db.collection('TOTAL_ASSEMBLY').doc(elemts.id).update(
                            {"PAID_MEMBERS_ASSEMBLY": FieldValue.increment(double
                                .parse(totalAmount.toString()))});
                      }
                    }else if(map['STATUS'].toString()=='REGISTERED'){
                      print(elemts.id+' QWEDEWFFW');
                      String totalAmount = '1';
                      await db.collection('TOTAL_ASSEMBLY').doc(elemts.id).update(
                          {"UNPAID_MEMBERS_ASSEMBLY": FieldValue.increment(double
                              .parse(totalAmount.toString()))});
                    }
                  }
                }
              });

            }
          }
          clearDistrictBool=false;
          notifyListeners();
        }
      });
    }

  }

  Future<void> clearAssemblyCounts() async {
    clearDistrictBool=true;
    notifyListeners();
    int i=0;
   await db.collection('TOTAL_ASSEMBLY')
           .where("STATE",isEqualTo: selectLoopStateCT.text)
           .where("DISTRICT",isEqualTo: selectLoopDistrictCT.text)
           .where("ASSEMBLY",isEqualTo: selectLoopAssemblyCT.text)
       .get().then((value) async {
      if(value.docs.isNotEmpty){
        print(value.docs.length.toString()+' CNKJC');
        for(var eeeee in value.docs){
          print(i.toString()+' NCODNC');
          i=i+1;
          Map<dynamic,dynamic> map=eeeee.data() as Map;
          HashMap<String,Object> mappp=HashMap();
          mappp['PAID_MEMBERS_ASSEMBLY']=0;
          mappp['UNPAID_MEMBERS_ASSEMBLY']=0;
          // mappp['PAID_MEMBERS_DISTRICT']=0;
          // mappp['UNPAID_MEMBERS_DISTRICT']=0;
          await db.collection('TOTAL_ASSEMBLY').doc(eeeee.id).set(mappp,SetOptions(merge: true));


        }
        clearDistrictBool=false;
        notifyListeners();
      }
    });
  }

  void updateAssemblyDistrictCount(){
    db.collection("TOTAL_ASSEMBLY").get().then((value){
      if(value.docs.isNotEmpty){
        for(var e in value.docs) {
          print(e.id+"eepepe");
          print(e.get("DISTRICT")+"oee0e");
        var districtPaid=db.collection("MEMBERS").where("DISTRICT",isEqualTo: e.get("DISTRICT")).where("STATUS",isEqualTo:'PAID').get();
        var assemblyPaid=db.collection("MEMBERS").where("DISTRICT",isEqualTo: e.get("DISTRICT")).where("ASSEMBLY",isEqualTo: e.id).where("STATUS",isEqualTo:'PAID').get();
        var districtUnpaid=db.collection("MEMBERS").where("DISTRICT",isEqualTo: e.get("DISTRICT")).where("STATUS",isNotEqualTo:'PAID').get();
        var assemblyUnpaid=db.collection("MEMBERS").where("DISTRICT",isEqualTo: e.get("DISTRICT")).where("ASSEMBLY",isEqualTo: e.id).where("STATUS",isNotEqualTo:'PAID').get();

          districtPaid.then((valueeee){
        if(valueeee.docs.isNotEmpty){
          for(var k in valueeee.docs ){
            Map<dynamic,dynamic>map=k.data();

            if(map.containsKey("REQUEST_STATUS")){
              if(map["REQUEST_STATUS"].toString()=="APPROVE"){
                db.collection("TOTAL_ASSEMBLY").doc(e.id).set({"PAID_MEMBERS_DISTRICT": double.parse(valueeee.docs.length.toString())},SetOptions(merge: true));
              }
            }else{
              db.collection("TOTAL_ASSEMBLY").doc(e.id).set({"PAID_MEMBERS_DISTRICT": double.parse(valueeee.docs.length.toString())},SetOptions(merge: true));

            }
          }
          print(valueeee.docs.length.toString()+"districtpaid");
        }
      });
          districtUnpaid.then((val1){
            for(var k in val1.docs ){
              Map<dynamic,dynamic>map=k.data();

              if(map.containsKey("REQUEST_STATUS")){
                if(map["REQUEST_STATUS"].toString()=="APPROVE"){
                  db.collection("TOTAL_ASSEMBLY").doc(e.id).set({"UNPAID_MEMBERS_DISTRICT": double.parse(val1.docs.length.toString())},SetOptions(merge: true));
                }
              }else{
                db.collection("TOTAL_ASSEMBLY").doc(e.id).set({"UNPAID_MEMBERS_DISTRICT": double.parse(val1.docs.length.toString())},SetOptions(merge: true));

              }
            }
            print(val1.docs.length.toString()+"districtunpaid");

      });
          assemblyPaid.then((val2){
            for(var k in val2.docs ){
              Map<dynamic,dynamic>map=k.data();

              if(map.containsKey("REQUEST_STATUS")){
                if(map["REQUEST_STATUS"].toString()=="APPROVE"){
                  db.collection("TOTAL_ASSEMBLY").doc(e.id).set({"PAID_MEMBERS_ASSEMBLY": double.parse(val2.docs.length.toString())},SetOptions(merge: true));
                }
              }else{
                db.collection("TOTAL_ASSEMBLY").doc(e.id).set({"PAID_MEMBERS_ASSEMBLY": double.parse(val2.docs.length.toString())},SetOptions(merge: true));

              }
            }
            print(val2.docs.length.toString()+"assemblypaid");

      });
          assemblyUnpaid.then((val){
            for(var k in val.docs ){
              Map<dynamic,dynamic>map=k.data();

              if(map.containsKey("REQUEST_STATUS")){
                if(map["REQUEST_STATUS"].toString()=="APPROVE"){
                  db.collection("TOTAL_ASSEMBLY").doc(e.id).set({"UNPAID_MEMBERS_ASSEMBLY": double.parse(val.docs.length.toString())},SetOptions(merge: true));
                }
              }else{
                db.collection("TOTAL_ASSEMBLY").doc(e.id).set({"UNPAID_MEMBERS_ASSEMBLY": double.parse(val.docs.length.toString())},SetOptions(merge: true));

              }
            }
            print(val.docs.length.toString()+"assemblyunpaid");

      });
        }

      }
    });
    print("completed");
  }

  void totalss(){
    double total=0;
    db.collection("TOTAL_ASSEMBLY").where("DISTRICT",isEqualTo: "BANGALORE").get().then((value){
      if(value.docs.isNotEmpty){
        for(var e in value.docs){
          total=total+double.parse(e.get('PAID_MEMBERS_ASSEMBLY').toString());
          print(total.toString()+"iroiioroi");
        }
      }
    });
  }

  void reportDistrictWiseFilter(String District){
    print(District+' KF VKFVK'+MasterCoordinatorDetailsList.length.toString()+' '+FilterMasterCoordinatorDetailsList.length.toString()+' VFJVNV');
    // if(District!=''){
      MasterCoordinatorDetailsList=FilterMasterCoordinatorDetailsList.where((element) => element.district==District).toSet().toList();
    // }
    print(MasterCoordinatorDetailsList.length.toString()+ ' mKMKM');
    notifyListeners();
  }

  void stateAllreport(){
    MasterCoordinatorDetailsList=FilterMasterCoordinatorDetailsList;
    notifyListeners();
  }

  void reportAssemblyWiseFilter(String District,String assembly){
    MasterCoordinatorDetailsList=FilterMasterCoordinatorDetailsList
        .where((element) => element.district==District)
        .where((element) => element.mandalam==assembly)
        .toSet().toList();
    print(MasterCoordinatorDetailsList.length.toString()+ ' mKMKM');
    notifyListeners();
  }

  void clearAll(String from){
    if(from=='NATIONAL_LEVEL'){
      stateNameCT.clear();
    }
    distNameCT.clear();
    assmblyNameCT.clear();
    MasterCoordinatorDetailsList=FilterMasterCoordinatorDetailsList;
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
  }

  void regDistrictFilterFun(String District){
    print(District+' Ameeeeeeeeeeeeeeeeeeen'+filterMasterModelList.length.toString()+' '+masterModelList.length.toString()+' VFJVNV');
    masterModelList=filterMasterModelList.where((element) => element.district==District).toSet().toList();
    print(masterModelList.length.toString()+ ' mKMKM');
    notifyListeners();
  }

  void regstateAllreport(){
    masterModelList=filterMasterModelList;
    notifyListeners();
  }

  void regAssmblyFilter(String District,String assembly){
    masterModelList=filterMasterModelList
        .where((element) => element.district==District)
        .where((element) => element.mandalam==assembly)
        .toSet().toList();
    print(masterModelList.length.toString()+ ' mKMKM');
    notifyListeners();
  }

  void clearAllRegReport(String from){
    if(from=='NATIONAL_LEVEL'){
      regReportStateCT.clear();
    }
    regReportdistNameCT.clear();
    regReportassmblyNameCT.clear();
    masterModelList=filterMasterModelList;
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
  }
}