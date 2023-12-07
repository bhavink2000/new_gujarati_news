//@dart=2.9
import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../../App Helper/Api Future/api_future.dart';
import '../../App Helper/Api Urls/api_url.dart';
import '../../App Helper/Model/general_news_model.dart';
import '../../App Helper/Service/share_data.dart';
import '../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../../App Helper/Ui Helper/data_helper.dart';
import '../../App Helper/Ui Helper/image_error_helper.dart';
import '../../App Helper/Ui Helper/image_helper.dart';
import '../../App Helper/Ui Helper/loading_helper.dart';
import '../../App Helper/Ui Helper/size_helper.dart';
import '../Bottom Menu/Home/news_details_page.dart';
import '../app_bar_view.dart';
import 'drawer_menus.dart';

class DrawerMenuDetails extends StatefulWidget {
  var id,name;
  DrawerMenuDetails({Key key,this.id,this.name}) : super(key: key);

  @override
  State<DrawerMenuDetails> createState() => _DrawerMenuDetailsState();
}

class _DrawerMenuDetailsState extends State<DrawerMenuDetails> {
  bool isLoading;
  bool isLoadingMore = false;
  final scrollController = ScrollController();
  int offset = 0;
  var cateID;
  @override
  void initState() {
    cateID = widget.id;
    super.initState();
    getCategoryNews(cateID,offset);
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: isLoading == false ? cateNews == null ? ServerHelper() : cateNews.isEmpty ? const DataHelper() : ListView.builder(
          physics: const BouncingScrollPhysics(),
          controller: scrollController,
          itemCount: isLoadingMore == false ? cateNews.length + 1 : cateNews.length,
          itemBuilder: (context, index){
            print("cateNews.length==>${cateNews.length}");
            print("index==>${index}");
            if(index < cateNews.length){
              DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
              var formattedDate = format.parse(cateNews[index].startedAt.toString());
              var mDate = DateFormat.yMMMd().format(formattedDate);
              var time = DateFormat.jm().format(formattedDate);
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                child: Container(
                  width: DrawerMenuSizeHelper(context).SubContainerW,
                  height: DrawerMenuSizeHelper(context).SubContainerH,
                  //color: Colors.green,
                  child: Row(
                    children: [
                      Container(
                        width: DrawerMenuSizeHelper(context).SubTextContainerW,
                        //color: Colors.teal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              //color: Colors.green,
                              width: DrawerMenuSizeHelper(context).SubTextHeaderW,
                              child: Row(
                                children: [
                                  Text(
                                    "$mDate $time" ?? "",
                                    style: const TextStyle(fontFamily: FontType.PoppinsRegular,letterSpacing: 0.5,fontSize: 10,color: Colors.black),
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
                                            cateNews[index].title,
                                            cateNews[index].newsLink,
                                          );
                                        },
                                        child: Image(
                                          image: AppImageIcons().ShareImageIcon,
                                          color: RedColor,width: 20,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 2),
                            Container(
                              width: DrawerMenuSizeHelper(context).SubTextFottorW,
                              //color: Colors.yellow,
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsPage(
                                    categorynm: cateNews[index].categoryName,
                                    categoryid: cateNews[index].categoryId,
                                    title: cateNews[index].title,
                                    en_title: cateNews[index].enTitle,
                                    news_image: cateNews[index].newsImage,
                                    banner_description: cateNews[index].bannerDescription,
                                    description: cateNews[index].description,
                                    slug: cateNews[index].slug,
                                    started_at: cateNews[index].startedAt,
                                    ended_at: cateNews[index].endedAt,
                                    status: "${cateNews[index].status}",
                                    author_id: "${cateNews[index].authorId}",
                                    author_image: cateNews[index].authorImage,
                                    name: cateNews[index].name,
                                    image: cateNews[index].authorImage,
                                    tags: cateNews[index].tags,
                                  )));
                                },
                                child: Text(
                                    cateNews[index].title ?? "",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14,fontFamily: FontType.AnekGujaratiSemiBold,color: Colors.black)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Container(
                            width: DrawerMenuSizeHelper(context).SubImageW,
                            height: DrawerMenuSizeHelper(context).SubImageH,
                            //color: Colors.teal,
                            //height: MediaQuery.of(context).size.height / 6,color: Colors.green,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsPage(
                                  categorynm: cateNews[index].categoryName,
                                  categoryid: cateNews[index].categoryId,
                                  title: cateNews[index].title,
                                  en_title: cateNews[index].enTitle,
                                  news_image: cateNews[index].newsImage,
                                  banner_description: cateNews[index].bannerDescription,
                                  description: cateNews[index].description,
                                  slug: cateNews[index].slug,
                                  started_at: cateNews[index].startedAt,
                                  ended_at: cateNews[index].endedAt,
                                  status: "${cateNews[index].status}",
                                  author_id: "${cateNews[index].authorId}",
                                  author_image: cateNews[index].authorImage,
                                  name: cateNews[index].name,
                                  image: cateNews[index].authorImage,
                                  tags: cateNews[index].tags,
                                )));
                              },
                              child: cateNews[index].newsImage != null ? CachedNetworkImage(
                                imageUrl: cateNews[index].newsImage,
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
                              ) : const ImageSubErrorHelper(),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            else{
              return cateNews.length == 25 ? Center(
                child: CircularProgressIndicator(
                  color: RedColor,
                ),
              ) : Container();
            }
          },
        ) : const LoadingHelper(),
      ),
    );
  }

  Future<void> _scrollListner()async{
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      setState((){
        isLoadingMore = true;
      });
      offset = offset + 1;
      await getCategoryNews(cateID,offset);
      setState((){
        isLoadingMore = false;
      });
    }
    else{
      //print("don't call");
    }
  }

  Future<GeneralNewsModel> categoryOBJ;
  List<GNews> cateNewsSData = [];
  List<GData> cateNewsMData = [];
  List<GNews> cateNews;

  getCategoryNews(cateId,offset) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await ApiFuture().categoryWiseNews(ApiUrl.AllNews,cateId,offset);
      final newsList = response.data.news;
      final uniqueNews = newsList.toSet();
      cateNews = uniqueNews.toList();
      setState(() {
        isLoading = false;
      });
    } on SocketException {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Internet Connection Problem",
        backgroundColor: PurpleColor,
        textColor: Colors.white,
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Please Try Again",
        backgroundColor: PurpleColor,
        textColor: Colors.white,
      );
      print("Error: $e");
    }
  }
}
