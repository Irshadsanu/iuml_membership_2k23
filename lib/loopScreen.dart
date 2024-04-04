import 'package:flutter/material.dart';
import 'package:iuml_membership/clearence/webProvider.dart';
import 'package:iuml_membership/providers/Main_Provider.dart';
import 'package:provider/provider.dart';

class LoopScreen extends StatelessWidget {
  const LoopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(context,listen: false);
    WebProvider webProvider  = Provider.of<WebProvider>(context,listen: false);

    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                ///assemblyLoop
                // mainProvider. loopAssemblyWiseCount();

                webProvider.changeCoordinatorId();
                ///district loop
                // mainProvider.LOOPdISTRICT('1694698057965');
                ///state loop
                // mainProvider.loopStateWiseCountSetting();

              },
              child: Container(
                height: 80,
                  width: 100,
                  color: Colors.orange,
                  child: const Center(child: Text("Loop"))),
            ),
            SizedBox(height: 25,),
            InkWell(
              onTap: (){
              // mainProvider.clearAssemblyCounts();

              },
              child: Container(
                height: 80,
                  width: 100,
                  color: Colors.orange,
                  child: const Center(child: Text("Clear Assembly Count"))),
            ),
            SizedBox(height: 25,),
            InkWell(
              onTap: (){
                // mainProvider.addedByIssueClearence();

              },
              child: Container(
                height: 80,
                  width: 100,
                  color: Colors.orange,
                  child: const Center(child: Text("Added By issue clearence"))),
            ),
          ],
        ),
      ),
    );
  }
}
