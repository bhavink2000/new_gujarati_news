//@dart=2.9
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:new_gujarati_news/App%20Helper/Model/general_news_model.dart';
import '../../../../App Helper/Api Future/api_future.dart';
import '../../../../App Helper/Api Urls/api_url.dart';
import '../../../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../../../../App Helper/Ui Helper/image_error_helper.dart';
import '../../../../App Helper/Ui Helper/loading_helper.dart';
import '../news_details_page.dart';


class WorldN extends StatefulWidget {
  const WorldN({Key key}) : super(key: key);

  @override
  State<WorldN> createState() => _WorldNState();
}

class _WorldNState extends State<WorldN> {
  bool isLoading;
  bool isLoadingMore = false;
  final scrollController = ScrollController();
  int offset = 0;
  @override
  void initState() {
    super.initState();
    getWorldNews(8,offset);
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
    return worldNewsSData.length == 0 ? Container() : Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.96,
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      //color: Colors.green,
      child: Card(
        elevation: 6,
        shadowColor: PurpleColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: Row(
                children: [
                  Container(width: 1,height: 15,color: RedColor,),
                  const SizedBox(width: 5,),
                  Text("World".toUpperCase(),style: TextStyle(fontFamily: FontType.PoppinsMedium,fontSize: 18,color: PurpleColor),)
                ],
              ),
            ),
            //Spacer(),
            Container(
              width: MediaQuery.of(context).size.width ,
              height: MediaQuery.of(context).size.height / 2.3,
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              //color: Colors.teal,
              child: isLoading == false ? ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                itemCount: isLoadingMore == false ? worldNews.length + 1 : worldNews.length,
                itemBuilder: (context, index){
                  if(index < worldNews.length){
                    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
                    var formattedDate = format.parse(worldNews[index].startedAt.toString());
                    var mDate = DateFormat.yMMMd().format(formattedDate);
                    var time = DateFormat.jm().format(formattedDate);
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsPage(
                          categorynm: worldNews[index].categoryName,
                          categoryid: worldNews[index].categoryId,
                          title: worldNews[index].title,
                          en_title: worldNews[index].enTitle,
                          news_image: worldNews[index].newsImage,
                          banner_description: worldNews[index].bannerDescription,
                          description: worldNews[index].description,
                          slug: worldNews[index].slug,
                          started_at: worldNews[index].startedAt,
                          ended_at: worldNews[index].endedAt,
                          status: "${worldNews[index].status}",
                          author_id: "${worldNews[index].authorId}",
                          author_image: worldNews[index].authorImage,
                          name: worldNews[index].name,
                          image: worldNews[index].authorImage,
                          tags: worldNewsSData[index].tags,
                        )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 2.31,
                          child: CachedNetworkImage(
                            imageUrl: worldNews[index].newsImage,
                            imageBuilder: (context, imageProvider) => Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: MediaQuery.of(context).size.height / 2.32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)
                                ),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.black12,
                                        Colors.black.withOpacity(0.8)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                                      child: Text(
                                        worldNews[index].title ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontFamily: FontType.AnekGujaratiSemiBold,color: Colors.white),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                      child: Text("$mDate $time" ?? "",style: const TextStyle(color: Colors.white),),
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
                    );
                  }
                  else{
                    return Center(
                      child: CircularProgressIndicator(
                        color: RedColor
                      ),
                    );
                  }
                },
              ) : const LoadingHelper(),
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
      await getWorldNews(8,offset);
      setState((){
        isLoadingMore = false;
      });
    }
    else{
      print("don't call");
    }
  }
  Future<GeneralNewsModel> worldNewsOBJ;
  List<GNews> worldNewsSData = [];
  List<GData> worldNewsMData = [];
  List<GNews> worldNews;
  getWorldNews(cateId,offset) async {
    setState(() {
      isLoading = true;
    });
    try {
      worldNewsOBJ = ApiFuture().categoryWiseNews(ApiUrl.AllNews,cateId,offset);
      await worldNewsOBJ.then((value) async {
        worldNewsSData.addAll(value.data.news);
        worldNewsMData.add(value.data);
      });
      setState(() {
        Set<int> uniqueNews = Set<int>.from(worldNewsSData.map((e) => e.id));
        worldNews = uniqueNews.map((id) => worldNewsSData.firstWhere((element) => element.id == id)).toList();
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
      print(e);
    }
    setState(() {});
  }
}
