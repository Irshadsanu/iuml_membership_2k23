import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iuml_membership/constants/my_colors.dart';
import 'package:iuml_membership/providers/Main_Provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../Models/languageModel.dart';
import '../constants/my_functions.dart';

class HowToUseScreen extends StatefulWidget {
String videoId,description,language;
  HowToUseScreen({Key? key,required this.videoId,required this.description,required this.language}) : super(key: key);

  @override
  State<HowToUseScreen> createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> {
    YoutubePlayerController? videoController;
    late PlayerState _playerState;
    late YoutubeMetaData _videoMetaData;
    double _volume = 100;
    bool _muted = false;
    bool _isPlayerReady = false;
@override
  void  initState() {
  super.initState();

  print("dmmkdddd"+widget. videoId);
  videoController = YoutubePlayerController(

    initialVideoId:widget.videoId,
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      hideControls: false,
      endAt: 0,
      // mute: true,
      showLiveFullscreenButton: false,
      // loop: true
    ),
  )..addListener(listener);

 setState(() {
   videoController!.addListener(() {
     if (videoController!.value.isFullScreen) {
       SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
     } else {
       SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
       SystemChrome.setPreferredOrientations([
         DeviceOrientation.portraitUp,
       ]);
     }
   });
 });

}

    void listener() {
      if (_isPlayerReady && mounted && !videoController!.value.isFullScreen) {
        setState(() {
          _playerState = videoController!.value.playerState;
          _videoMetaData = videoController!.metadata;
        });
      }
    }
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var width = queryData.size.width;
    var height = queryData.size.height;
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leadingWidth: 100,
          elevation: 0,
          backgroundColor: cWhite,
          leading: Row(
            children: [
              const SizedBox(width:10),
              InkWell(
                onTap: (){
                  finish(context);
                },
                child:  Icon(Icons.arrow_back_ios,color:myBlack),
              ),
              const SizedBox(width:5),
              Text(
                'IUML',
                style: TextStyle(
                  color: cl197118,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.48,
                ),
              )
            ],
          ),
          title:Text(
            'How to Use',
            textAlign: TextAlign.center,
            style: TextStyle(
              color:cl303030,
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.45,
            ),
          ),
        ),
        body: Consumer<MainProvider>(
          builder: (context,value,child) {
            return SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: SizedBox(

                      height: 400,

                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: YoutubePlayer(
                            controller: videoController!,
                            showVideoProgressIndicator: true,
                          ),),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 20,right: 15,top: 15),
                    child: RichText(text: TextSpan(children: [
                      // TextSpan(text: "How to pay ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                      TextSpan(text:widget.description,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black)),

                    ])),
                  ),
                  Consumer<MainProvider>(
                      builder: (context,value2,child) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15,top: 20,),
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  child: DropdownSearch<LanguageModel>(
                                    selectedItem:widget.language=="English"?value2.languageList[0]:widget.language=="Hindi"?value2.languageList[1]:value2.languageList[2] ,
                                    dropdownDecoratorProps: DropDownDecoratorProps(
                                        dropdownSearchDecoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey.shade100,),
                                              borderRadius: const BorderRadius.all(Radius.circular(15))),
                                          labelText:"Language",
                                          alignLabelWithHint:true,
                                          labelStyle:  const TextStyle(
                                              fontFamily: 'BarlowCondensed',
                                              fontWeight: FontWeight.bold,fontSize: 17
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Colors.grey.shade100)
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,

                                        ),
                                        baseStyle: TextStyle(fontSize: 16),
                                        textAlign:TextAlign.center

                                    ),

                                    onChanged: (e){
                                      callNextReplacement(HowToUseScreen(videoId: e!.videoId, description: e.description, language: e.name,), context);
                                      },
                                    items: value2.languageList,
                                    itemAsString: (LanguageModel u) =>u.name,
                                    popupProps: PopupProps.menu(
                                        constraints: const BoxConstraints.expand(height: 150),
                                        fit: FlexFit.tight,
                                        menuProps: MenuProps(borderRadius: BorderRadius.circular(10),),
                                        itemBuilder: (ctx,item,isSelected){
                                          return ListTile(
                                            selected: isSelected,
                                            title: Text(item.name,style: TextStyle(fontSize: 14),),

                                          );
                                        }
                                    ),

                                  ),
                                ),
                              );

                      }
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
  @override
  void dispose() {
  setState(() {
    videoController!.dispose();
    videoController=null;
  });

    super.dispose();
  }
}
