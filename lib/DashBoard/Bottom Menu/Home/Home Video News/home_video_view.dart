import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_gujarati_news/App%20Helper/Model/video_news_model.dart';
import '../../../../App Helper/Api Future/api_future.dart';
import '../../../../App Helper/Api Urls/api_url.dart';
import '../../../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../../../../App Helper/Ui Helper/image_error_helper.dart';
import '../../../../App Helper/Ui Helper/loading_helper.dart';
import 'home_video_first_view.dart';

class HomeVideoNews extends StatefulWidget {
  const HomeVideoNews({Key? key}) : super(key: key);

  @override
  State<HomeVideoNews> createState() => _HomeVideoNewsState();
}

class _HomeVideoNewsState extends State<HomeVideoNews> {
  bool? isLoading;
  bool isLoadingMore = false;
  final scrollController = ScrollController();
  int offset = 0;
  @override
  void initState() {
    super.initState();
    getVideo(offset);
    scrollController.addListener(_scrollListner);
    isLoading = true;
  }
  @override
  void dispose() {
    scrollController.removeListener(_scrollListner);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return allVideoSData.length == 0 ? Container() : Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.5,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Row(
              children: [
                Container(
                  width: 1,
                  height: 15,color: RedColor,
                ),
                const SizedBox(width: 5,),
                Text("Top Video".toUpperCase(),style: const TextStyle(fontFamily: FontType.PoppinsRegular,fontSize: 18,letterSpacing: 0.5,color: Colors.white),),
              ],
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              child: isLoading == false ? ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                controller: scrollController,
                itemCount: isLoadingMore == false ? allVideoSData.length + 1 : allVideoSData.length,
                itemBuilder: (context, index){
                  if(index < allVideoSData.length){
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeVideoFirst(
                            vNews: allVideoSData,
                            vindex: index,
                          )));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 3.3,
                            child: CachedNetworkImage(
                              imageUrl: allVideoSData[index].imageUrl,
                              imageBuilder: (context, imageProvider) => Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 4.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    //colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.black12,
                                          Colors.black.withOpacity(0.7)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      const Spacer(),
                                      const Center(
                                        child: Image(image: AssetImage("Assets/images/image_icon/play_circle.png"),color: Colors.white70),
                                      ),
                                      const SizedBox(height: 50),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                                        child: Text(
                                          allVideoSData[index].title ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 14,fontFamily: FontType.AnekGujaratiSemiBold,letterSpacing: 0.5,color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Center(child: CircularProgressIndicator(color: RedColor,strokeWidth: 3.0,)),
                              errorWidget: (context, url, error) => ImageMainErrorHelper(),
                            ),
                          ),
                        ),
                      ),
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
              ) : const LoadingHelper()
          ),
        ],
      ),
    );
  }
  Future<void> _scrollListner()async{
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      setState((){
        isLoadingMore = true;
      });
      offset = offset + 1;
      await getVideo(offset);
      setState((){
        isLoadingMore = false;
      });
    }
    else{
      //print("don't call");
    }
  }

  Future<VideoNewsModel?>? allVideoOBJ;
  List<VNews> allVideoSData = [];
  List<VData> allVideoMData = [];
  getVideo(offset) async {
    setState(() {
      isLoading = true;
    });
    try {
      allVideoOBJ = ApiFuture().videoNews(ApiUrl.AllVideo,offset);
      await allVideoOBJ!.then((value) async {
        allVideoSData.addAll(value!.data.news);
        allVideoMData.add(value.data);
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
      //Fluttertoast.showToast(msg: "Please Try Again Video",backgroundColor: PurpleColor,textColor: Colors.white);
      print(e);
    }
    setState(() {});
  }
}
