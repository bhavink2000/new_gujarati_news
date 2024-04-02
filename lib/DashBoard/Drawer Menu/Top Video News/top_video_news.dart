import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_gujarati_news/App%20Helper/Api%20Urls/api_url.dart';
import 'package:new_gujarati_news/App%20Helper/Ui%20Helper/data_helper.dart';
import '../../../App Helper/Api Future/api_future.dart';
import '../../../App Helper/Model/video_news_model.dart';
import '../../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../../../App Helper/Ui Helper/image_error_helper.dart';
import '../../../App Helper/Ui Helper/loading_helper.dart';
import '../../Bottom Menu/Home/Home Video News/home_video_first_view.dart';
import '../../app_bar_view.dart';
import '../drawer_menus.dart';
import 'top_video_news_details.dart';

class TopVideoNews extends StatefulWidget {
  const TopVideoNews({Key? key}) : super(key: key);

  @override
  State<TopVideoNews> createState() => _TopVideoNewsState();
}

class _TopVideoNewsState extends State<TopVideoNews> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerMenus(),
      appBar: AppBarHomePage(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
              child: Row(
                children: [
                  Container(height: 15,width: 2,color: RedColor,),
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("News Videos",
                      style: TextStyle(
                          fontFamily: FontType.PoppinsRegular,letterSpacing: 1,fontSize: 20,fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: isLoading == false ? videoNews.isEmpty ? const ServerHelper() : AnimationLimiter(
                    child: videoNews.isNotEmpty ? ListView.builder(
                      controller: scrollController,
                      itemCount: isLoadingMore == false ? videoNews.length + 1 : videoNews.length,
                      itemBuilder: (context, index){
                        if(index < videoNews.length){
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 1000),
                            child: SlideAnimation(
                              verticalOffset: 75.0,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeVideoFirst(
                                      vNews: videoNews,
                                      vindex: index,
                                    )));
                                  },
                                  child: FadeInAnimation(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width / 2,
                                      height: MediaQuery.of(context).size.height / 4,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          gradient: LinearGradient(
                                              colors: [
                                                RedColor.withOpacity(0.7),
                                                PurpleColor.withOpacity(0.9)
                                              ],begin: Alignment.topLeft,end: Alignment.bottomRight
                                          )
                                      ),
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: videoNews[index].imageUrl,
                                            imageBuilder: (context, imageprovider) => Container(
                                              height: MediaQuery.of(context).size.height / 3.5,
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                      image: imageprovider,
                                                      fit: BoxFit.cover,
                                                      colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)
                                                  )
                                              ),
                                            ),
                                            placeholder: (context, url) => Center(child: CircularProgressIndicator(color: RedColor,strokeWidth: 3.0)),
                                            errorWidget: (context, url, error) => const ImageMainErrorHelper(),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height / 3.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Colors.black12,
                                                    Colors.black.withOpacity(0.8)
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter
                                              ),
                                            ),
                                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Spacer(),
                                                const Center(child: Image(image: AssetImage("Assets/images/image_icon/play_circle.png"),color: Colors.white70)),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    videoNews[index].title ?? "",
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(fontFamily: FontType.PoppinsMedium,letterSpacing: 1,color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                                  child: Container(
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: RedColor.withOpacity(0.5)),
                                                    padding: const EdgeInsets.all(5),
                                                    child: Text(
                                                      videoNews[index].categoryName ?? "UnTitle",
                                                      style: const TextStyle(fontFamily: FontType.PoppinsMedium,color: Colors.white,letterSpacing: 0.5,fontSize: 10),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                    ) : const UpdateingSoon(),
                  ) : const LoadingHelper(),
                ),
              ),
            )
          ],
        ),
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
  Future<VideoNewsModel?>? videoObj;
  List<VNews> videoNews = [];
  List<VData> videoData = [];

  getVideo(offset) async {
    setState(() {
      isLoading = true;
    });
    try {
      videoObj = ApiFuture().videoNews(ApiUrl.AllVideo,offset);
      await videoObj!.then((value) async {
        videoNews.addAll(value!.data.news);
        videoData.add(value.data);
      });
      setState(() {});
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
      Fluttertoast.showToast(msg: "Please Try Again",backgroundColor: PurpleColor,textColor: Colors.white);
      print(e);
    }
    setState(() {});
  }
}
