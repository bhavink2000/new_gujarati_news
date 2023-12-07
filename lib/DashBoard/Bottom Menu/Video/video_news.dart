//@dart=2.9
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_gujarati_news/App%20Helper/Model/video_news_model.dart';
import 'package:new_gujarati_news/DashBoard/dashboard.dart';
import 'package:video_player/video_player.dart';
import '../../../App Helper/Api Future/api_future.dart';
import '../../../App Helper/Api Urls/api_url.dart';
import '../../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../Home/Home Video News/home_video_news_details.dart';
import 'video_bottom_side.dart';
import 'video_side.dart';

class VideoMenu extends StatefulWidget {
  const VideoMenu({Key key}) : super(key: key);

  @override
  State<VideoMenu> createState() => _VideoMenuState();
}

class _VideoMenuState extends State<VideoMenu> {

  //PageController pageController = PageController(initialPage: 0);
  bool isLoading;
  final controller = PageController();
  var isLoadingMore = false;
  var offset = 0;

  @override
  void initState() {
    super.initState();
    getVideo(offset);
    controller.addListener(_scrollListener);
    isLoading = true;
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: AlertDialog(
                  contentPadding: EdgeInsets.all(1),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  content: Container(
                    height: MediaQuery.of(context).size.height / 3.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 5),
                        CircleAvatar(
                          maxRadius: 40.0,
                          backgroundColor: Colors.white,
                          child: Image.asset("Assets/images/sitelogo.png",width: 120),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                          child: Text(
                            "Do you really want to close the App?",
                            style: TextStyle(fontFamily: FontType.AnekGujaratiSemiBold,letterSpacing: 0.5,fontSize: 12,),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextButton(
                              child: Text("Stay",style: TextStyle(fontFamily: FontType.AnekGujaratiSemiBold,letterSpacing: 2,fontSize: 15,color: PurpleColor),),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: Text("Close",style: TextStyle(fontFamily: FontType.AnekGujaratiSemiBold,letterSpacing: 2,fontSize: 15,color: PurpleColor),),
                              onPressed: (){
                                exit(0);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        );
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child: Stack(
                children: [
                  PageView.builder(
                    scrollDirection: Axis.vertical,
                    controller: controller,
                    itemCount: isLoadingMore == false ? videoNews.length + 1 : videoNews.length,
                    itemBuilder: (context, index){
                      if(index < videoNews.length){
                        return VideoWidget(
                          url: videoNews[index].videoUrls,
                          play: true,
                          vNews: videoNews[index],
                          vTags: videoNews[index].tags,
                        );
                      }
                      else{
                        return Center(
                          child: CircularProgressIndicator(
                            color: RedColor,
                          ),
                        );
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Image(image: AssetImage("Assets/images/sitelogo.png"),width: 100),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }

  Future<void> _scrollListener() async {
    print("calling scrollLister");
    if (controller.page == controller.page.toInt() && !isLoadingMore) {
      print("call");
      setState(() {
        isLoadingMore = true;
      });

      offset = offset + 1;
      await getVideo(offset);
      setState(() {
        isLoadingMore = false;
      });
    }
    else{
      print("don't call");
    }
  }

  Future<VideoNewsModel> videoNewsObj;
  List<VNews> videoNews = [];
  List<VData> videoData = [];

  getVideo(offset) async {
    setState(() {
      isLoading = true;
    });
    try {
      videoNewsObj = ApiFuture().videoNews(ApiUrl.AllVideo,offset);
      await videoNewsObj.then((value) async {
        videoNews.addAll(value.data.news);
        videoData.add(value.data);
      });
      setState(() {
        isLoading = false;
      });
    } on SocketException {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "Internet Connection Problem",backgroundColor: PurpleColor,textColor: Colors.white);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
    setState(() {});
  }
}

class VideoWidget extends StatefulWidget {

  final bool play;
  final String url;

  var vNews;
  List<VTag> vTags;
  VideoWidget({Key key, @required this.url, @required this.play,this.vNews,this.vTags}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}


class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController videoPlayerController ;
  Future<void> _initializeVideoPlayerFuture;
  bool isLoading;
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      videoPlayerController.play();
      videoPlayerController.setLooping(true);
      setState(() {});
    });
  } // This closing tag was missing

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        videoPlayerController.value.isInitialized ? Center(
          child: InkWell(
            onTap: videoPlayerController.pause,
            onDoubleTap: videoPlayerController.play,
            child: Container(
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height / videoPlayerController.value.aspectRatio,
              child: AspectRatio(
                  aspectRatio: videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(videoPlayerController)
              ),
            ),
          ),
        ) : const Center(child: CircularProgressIndicator(color: Colors.white70,)) ,
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: VideoBottomMenu(
                    title: widget.vNews.title,
                    desc: widget.vNews.description,
                    date: widget.vNews.startedAt,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: VideoSideBar(
                    title: widget.vNews.title,
                    videourl: widget.vNews.videoUrls,
                  ),
                ),
              ],
            )
          ],
        ),
        Positioned(
          right: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
            child: InkWell(
              onTap: (){
                videoPlayerController.pause();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeVideoNewsDetails(
                  vnews: widget.vNews,
                  vtags: widget.vNews.tags,
                )));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),color: Colors.white
                ),
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                child: Text("Read News  >>",style: TextStyle(color: RedColor.withOpacity(0.8),fontSize: 12,fontFamily: FontType.AnekGujaratiSemiBold),),
              ),
            ),
          ),
        ),
      ],
    );
    /*return videoPlayerController.value.isInitialized ? InkWell(
      onTap: videoPlayerController.pause,
      onDoubleTap: videoPlayerController.play,
      onLongPress: (){},
      child: Container(
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height / videoPlayerController.value.aspectRatio,
        child: AspectRatio(
            aspectRatio: videoPlayerController.value.aspectRatio,
            child: VideoPlayer(videoPlayerController)
        ),
      ),
    ) : const Center(child: CircularProgressIndicator(color: Colors.white70));*/
  }
}