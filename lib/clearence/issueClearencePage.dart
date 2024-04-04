import 'package:flutter/material.dart';
import 'package:iuml_membership/clearence/webProvider.dart';
import 'package:provider/provider.dart';

import '../constants/my_colors.dart';
import '../constants/my_functions.dart';
import '../constants/my_text.dart';


class IssueClearance extends StatelessWidget {
  const IssueClearance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WebProvider webProvider =
    Provider.of<WebProvider>(context, listen: false);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {

                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white
                        ),
                        child: const Center(
                          child: Icon(Icons.arrow_back_ios,color: Colors.black,),
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: width/3,
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        elevation: 0.5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),

                        ),
                        child: Consumer<WebProvider>(
                            builder: (context, value, child) {
                              return TextField(
                                controller: value.transactionIdController,
                                decoration: InputDecoration(
                                  fillColor: myWhite,
                                  filled: true,
                                  hintText: 'Transaction ID',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:  BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25.7),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:  BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25.7),
                                  ),
                                ),
                                onChanged: (item) {
                                  // if (item.trim().length==13) {
                                  //   webProvider.getIdDetails(item.trim(),context);
                                  // }
                                  // webProvider.getIdDetails(item.trim(),context);
                                },
                              );
                            }),
                      ),
                    ),
                    Consumer<WebProvider>(
                        builder: (context,value,child) {
                          return InkWell(
                            onTap: () {
                              webProvider.getIdDetails(value.transactionIdController.text.trim(),context);
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: myWhite
                              ),
                              child: const Center(
                                child: Icon(Icons.search,color: Colors.orange,),
                              ),

                            ),
                          );
                        }
                    ),

                  ],
                ),
                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      width: width/3,
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        elevation: 0.5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),

                        ),
                        child: Consumer<WebProvider>(
                            builder: (context, value, child) {
                              return TextField(
                                controller: value.utrController,
                                decoration: InputDecoration(
                                  fillColor: myWhite,
                                  filled: true,
                                  hintText: 'Enter UTR',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:  BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25.7),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:  BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25.7),
                                  ),
                                ),
                                onChanged: (item) {
                                  // if (item.trim().length==13) {
                                  //   webProvider.getIdDetails(item.trim(),context);
                                  // }
                                  // webProvider.getIdDetails(item.trim(),context);
                                },
                              );
                            }),
                      ),
                    ),
                    Consumer<WebProvider>(
                        builder: (context,value,child) {
                          return InkWell(
                            onTap: () {
                              webProvider.getUtrDetails(value.utrController.text.trim(),context);
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: myWhite
                              ),
                              child: const Center(
                                child: Icon(Icons.search,color: Colors.orange,),
                              ),

                            ),
                          );
                        }
                    ),
                  ],
                ),


                const SizedBox(height: 20,),
                SizedBox(
                  width: width/1.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 60,),
                      SizedBox(width: width/6,),


                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: width/1.2,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Consumer<WebProvider>(
                            builder: (context,value,child) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 50,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      SizedBox(
                                          width: width/6,
                                          child: Text("Transaction ID",style: blackPoppinsBoldM20,)),
                                      SizedBox(
                                          width: width/3,
                                          child: Text(":      "+value.issueID,style: blackPoppinsBoldM20,)),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  value.issueName!=''?  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      SizedBox(
                                          width: width/6,
                                          child: Text("Name",style: blackPoppinsBoldM20,)),
                                      SizedBox(
                                          width: width/3,
                                          child: Text(":      "+value.issueName,style: blackPoppinsBoldM20,)),
                                    ],
                                  ):SizedBox(),
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      SizedBox(
                                          width: width/6,
                                          child: Text("STATE",style: blackPoppinsBoldM20,)),
                                      SizedBox(
                                          width: width/3,
                                          child: Text(":      "+value.issueState,style: blackPoppinsBoldM20,)),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      SizedBox(
                                          width: width/6,
                                          child: Text("DISTRICT",style: blackPoppinsBoldM20,)),
                                      SizedBox(
                                          width: width/3,
                                          child: Text(":      "+value.issueDistrict,style: blackPoppinsBoldM20,)),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      SizedBox(
                                          width: width/6,
                                          child: Text("ASSEMBLY",style: blackPoppinsBoldM20,)),
                                      SizedBox(
                                          width: width/3,
                                          child: Text(":      "+value.issueAssembly,style: blackPoppinsBoldM20,)),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      SizedBox(
                                          width: width/6,
                                          child: Text("UNIT",style: blackPoppinsBoldM20,)),
                                      SizedBox(
                                          width: width/3,
                                          child: Text(":      "+value.issueUnit,style: blackPoppinsBoldM20,)),
                                    ],
                                  ),const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      SizedBox(
                                          width: width/6,
                                          child: Text("APP VERSION",style: blackPoppinsBoldM20,)),
                                      SizedBox(
                                          width: width/3,
                                          child: Text(":      "+value.issueAppversion,style: blackPoppinsBoldM20,)),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      SizedBox(
                                          width: width/6,
                                          child: Text("MEMBER_ID",style: blackPoppinsBoldM20,)),
                                      SizedBox(
                                          width: width/3,
                                          child:value.issueMemberID!=''?
                                          Text(":      "+value.issueMemberID,style: blackPoppinsBoldM20,):
                                          Text(":      "+value.issueMemberIdList.toString(),style: blackPoppinsBoldM20,))
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      SizedBox(
                                          width: width/6,
                                          child: Text("STATUS",style: blackPoppinsBoldM20,)),
                                      SizedBox(
                                          width: width/3,
                                          child: Text(":      "+value.issueStatus,style: blackPoppinsBoldM20,)),
                                    ],
                                  ),
                                  // const SizedBox(height: 10,),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children:  [
                                  //     SizedBox(
                                  //         width: width/6,
                                  //         child: Text("Response",style: blackPoppinsBoldM20,)),
                                  //     SizedBox(
                                  //         width: width/3,
                                  //         child: Text(":      ${value.entryExist}",style:  blackPoppinsBoldM20,)),
                                  //   ],
                                  // ),
                                  // const SizedBox(height: 15,),
                                  // value.entryExist == 'AVAILABLE'
                                  //     ?Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children:  [
                                  //     SizedBox(
                                  //         width: width/6,
                                  //         child: Text("Response Status",style: blackPoppinsBoldM20,)),
                                  //     SizedBox(
                                  //         width: width/3,
                                  //         child: Text(":      ${value.entryStatus}",style: blackPoppinsBoldM20,)),
                                  //   ],
                                  // ):const SizedBox(),
                                  // value.entryExist == 'YES'?
                                  // const SizedBox(height: 15,)
                                  //     :const SizedBox(),





                                ],
                              );
                            }
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      width: width/1.2,
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: myWhite
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Consumer<WebProvider>(
                            builder: (context,value,child) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  const SizedBox(height: 15,),
                                  InkWell(
                                    onTap: (){
                                      webProvider.issueClearance(context,value.transactionIdController.text,value.issueMemberID,value.issueTime,value.issueAmount);

                                    },
                                    child: Container(
                                      height: 50,
                                      width: 200,
                                      decoration:  BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                      ),
                                      child:  Center(
                                        child: Text(
                                            "Add To Members",style: blackPoppinsBoldM20
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                ],
                              );
                            }
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),

    );

  }
}
