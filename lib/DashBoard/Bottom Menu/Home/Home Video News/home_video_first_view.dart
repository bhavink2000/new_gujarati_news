//@dart=2.9
// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:new_gujarati_news/App%20Helper/Ui%20Helper/color_and_font_helper.dart';
import 'package:video_player/video_player.dart';
import '../../../../App Helper/Model/video_news_model.dart';
import 'Home Video Helper/home_video_bottom.dart';
import 'Home Video Helper/home_video_side_bar.dart';
import 'home_video_news_details.dart';

class HomeVideoFirst extends StatefulWidget {
  List<VNews> vNews;
  var vindex;
  HomeVideoFirst({Key key,this.vNews,this.vindex}) : super(key: key);

  @override
  State<HomeVideoFirst> createState() => _HomeVideoFirstState();
}

class _HomeVideoFirstState extends State<HomeVideoFirst> {
  PageController controller;
  VideoPlayerController videoPlayerController;
  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.vindex);
  }

  @override
  void dispose() {
    controller.dispose();
    videoPlayerController.dispose().then((value){
      print("call dispose method of HomeVideoFirst");
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child: PageView.builder(
              controller: controller,
              scrollDirection: Axis.vertical,
              itemCount: widget.vNews.length,
              itemBuilder: (context, index){
                return HomeVideoWidget(
                  url: widget.vNews[index].videoUrls,
                  play: true,
                  vNews: widget.vNews[index],
                  vTag: widget.vNews[index].tags,
                );
              },
            )
        ),
      ),
    );
  }
}

class HomeVideoWidget extends StatefulWidget {
  final bool play;
  final String url;
  var vNews;
  List<VTag> vTag;
  HomeVideoWidget({Key key,this.play,this.url,this.vNews,this.vTag}) : super(key: key);

  @override
  State<HomeVideoWidget> createState() => _HomeVideoWidgetState();
}

class _HomeVideoWidgetState extends State<HomeVideoWidget> {
  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    videoPlayerController =  VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      videoPlayerController.play();
      videoPlayerController.setLooping(true);
      setState(() {});
    });
  } // This closing tag was missing
  @override
  void dispose() {
    print("call dispose method of HomeVideoWidget");
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
                  child: HomeVideoBottom(
                    title: widget.vNews.title,
                    desc: widget.vNews.description,
                    date: widget.vNews.startedAt,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HomeVideoSideBar(
                    title: widget.vNews.title,
                    newslink: widget.vNews.videoUrls,
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
  }

}
