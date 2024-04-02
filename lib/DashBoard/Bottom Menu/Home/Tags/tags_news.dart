import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_gujarati_news/App%20Helper/Model/general_news_model.dart';
import 'package:new_gujarati_news/App%20Helper/Ui%20Helper/data_helper.dart';
import '../../../../App Helper/Api Future/api_future.dart';
import '../../../../App Helper/Api Urls/api_url.dart';
import '../../../../App Helper/Service/share_data.dart';
import '../../../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../../../../App Helper/Ui Helper/image_error_helper.dart';
import '../../../../App Helper/Ui Helper/image_helper.dart';
import '../../../../App Helper/Ui Helper/loading_helper.dart';
import '../../../Drawer Menu/drawer_menus.dart';
import '../../../app_bar_view.dart';
import '../news_details_page.dart';

class TagsNews extends StatefulWidget {
  var tagid,tagnm;
  TagsNews({Key? key,this.tagid,this.tagnm}) : super(key: key);

  @override
  State<TagsNews> createState() => _TagsNewsState();
}

class _TagsNewsState extends State<TagsNews> {
  bool? isLoading;
  bool isLoadingMore = false;
  final scrollController = ScrollController();
  int offset = 0;
  @override
  void initState() {
    super.initState();
    getNews(widget.tagid,offset);
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
      drawer: DrawerMenus(),
      appBar: AppBarDetailsPage(),
      backgroundColor: Colors.white,
      body: AnimationLimiter(
        child: isLoading == false
            ? allNews!.isNotEmpty ? ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          controller: scrollController,
          itemCount: isLoadingMore == false ? allNews!.length + 1 :allNews!.length,
          itemBuilder: (context, index){
            if(index < allNews!.length){
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 1000),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
                  child: SlideAnimation(
                    horizontalOffset: 75.0,
                    child: FadeInAnimation(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 8.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsPage(
                                    categoryNm: allNews?[index].categoryName,
                                    categoryId: allNews?[index].categoryId,
                                    title: allNews?[index].title,
                                    en_title: allNews?[index].enTitle,
                                    news_image: allNews?[index].newsImage,
                                    banner_description: allNews?[index].bannerDescription,
                                    description: allNews?[index].description,
                                    slug: allNews?[index].slug,
                                    started_at: allNews?[index].startedAt,
                                    ended_at: allNews?[index].endedAt,
                                    status: "${allNews?[index].status}",
                                    author_id: "${allNews?[index].authorId}",
                                    author_image: allNews?[index].authorImage,
                                    name: allNews?[index].name,
                                    image: allNews?[index].authorImage,
                                    tags: allNews![index].tags,
                                  )));
                                },
                                child: Container(
                                  //color: Colors.yellow,
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: MediaQuery.of(context).size.height / 8.8,
                                  child: allNews?[index].newsImage != null ? CachedNetworkImage(
                                    imageUrl: allNews![index].newsImage,
                                    imageBuilder: (context, imageProvider) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Center(child: CircularProgressIndicator(color: RedColor,strokeWidth: 3.0,)),
                                    errorWidget: (context, url, error) => ImageHomePageSubError(),
                                  ) : const ImageHomePageSubError(),
                                ),
                              ),
                            ),
                            Container(
                              //color: Colors.green,
                              width: MediaQuery.of(context).size.width / 1.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Text(
                                        "${allNews?[index].categoryName}",
                                        style: const TextStyle(fontFamily: FontType.PoppinsMedium,letterSpacing: 0.5,fontSize: 10,color: Colors.red),
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          //Image(image: AppImageIcons().BookmarkImageIcon,color: RedColor,width: 15),
                                          const SizedBox(width: 10),
                                          InkWell(
                                            onTap: (){
                                              ShareData().shareData(
                                                allNews?[index].title,
                                                allNews?[index].newsLink,
                                              );
                                            },
                                            child: Image(
                                              image: AppImageIcons().ShareImageIcon,
                                              color: RedColor,width: 20,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.7,
                                    //color: Colors.yellow,
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsPage(
                                          categoryNm: allNews?[index].categoryName,
                                          categoryId: allNews?[index].categoryId,
                                          title: allNews?[index].title,
                                          en_title: allNews?[index].enTitle,
                                          news_image: allNews?[index].newsImage,
                                          banner_description: allNews?[index].bannerDescription,
                                          description: allNews?[index].description,
                                          slug: allNews?[index].slug,
                                          started_at: allNews?[index].startedAt,
                                          ended_at: allNews?[index].endedAt,
                                          status: "${allNews?[index].status}",
                                          author_id: "${allNews?[index].authorId}",
                                          author_image: allNews?[index].authorImage,
                                          name: allNews?[index].name,
                                          image: allNews?[index].authorImage,
                                          tags: allNews![index].tags,
                                        )));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                        child: Text(
                                          allNews![index].title,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 14,fontFamily: FontType.AnekGujaratiSemiBold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            else{
              return allNews!.length == 25 ? Center(
                child: CircularProgressIndicator(
                  color: RedColor,
                ),
              ) : Container();
            }
          },
        )
            : const DataHelper()
            : const LoadingHelper(),
      ),
    );
  }

  Future<void> _scrollListner()async{
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      setState((){
        isLoadingMore = true;
      });
      offset = offset + 1;
      await getNews(widget.tagid,offset);
      setState((){
        isLoadingMore = false;
      });
    }
    else{
      print("don't call");
    }
  }

  Future<GeneralNewsModel?>? allNewsOBJ;
  List<GNews> allNewsSData = [];
  List<GData> allNewsMData = [];
  List<GNews>? allNews;

  getNews(var tagid,offset) async {
    setState(() {
      isLoading = true;
    });
    try {
      allNewsOBJ = ApiFuture().tagsNews(ApiUrl.AllNews,tagid,offset);
      await allNewsOBJ!.then((value) async {
        allNewsSData.addAll(value!.data.news);
        allNewsMData.add(value.data);
      });
      setState(() {
        Set<int> uniqueNews = Set<int>.from(allNewsSData.map((e) => e.id));
        allNews = uniqueNews.map((id) => allNewsSData.firstWhere((element) => element.id == id)).toList();
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
      Fluttertoast.showToast(msg: "Please Try Again",backgroundColor: PurpleColor,textColor: Colors.white);
      print("error $e");
    }
    setState(() {});
  }
}
