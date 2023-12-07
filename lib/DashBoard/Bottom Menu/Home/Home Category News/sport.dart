//@dart=2.9
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:new_gujarati_news/App%20Helper/Model/general_news_model.dart';
import 'package:new_gujarati_news/App%20Helper/Ui%20Helper/image_error_helper.dart';

import '../../../../App Helper/Api Future/api_future.dart';
import '../../../../App Helper/Api Urls/api_url.dart';
import '../../../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../../../../App Helper/Ui Helper/loading_helper.dart';
import '../news_details_page.dart';


class SportN extends StatefulWidget {
  const SportN({Key key}) : super(key: key);

  @override
  State<SportN> createState() => _SportNState();
}

class _SportNState extends State<SportN> {
  bool isLoading;
  bool isLoadingMore = false;
  final scrollController = ScrollController();
  int offset = 0;
  @override
  void initState() {
    super.initState();
    getSportNews(7,offset);
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
    return sportNewsSData.length == 0 ? Container() : Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.43,
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
                  Text("Sport".toUpperCase(),style: TextStyle(fontFamily: FontType.PoppinsMedium,fontSize: 18,color: PurpleColor),)
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: isLoading == false ? ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                itemCount: isLoadingMore == false ? sportNews.length + 1  : sportNews.length,
                itemBuilder: (context, index){
                  if(index < sportNews.length){
                    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
                    var formattedDate = format.parse(sportNews[index].startedAt.toString());
                    var mDate = DateFormat.yMMMd().format(formattedDate);
                    var time = DateFormat.jm().format(formattedDate);
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsPage(
                          categorynm: sportNews[index].categoryName,
                          categoryid: sportNews[index].categoryId,
                          title: sportNews[index].title,
                          en_title: sportNews[index].enTitle,
                          news_image: sportNews[index].newsImage,
                          banner_description: sportNews[index].bannerDescription,
                          description: sportNews[index].description,
                          slug: sportNews[index].slug,
                          started_at: sportNews[index].startedAt,
                          ended_at: sportNews[index].endedAt,
                          status: "${sportNews[index].status}",
                          author_id: "${sportNews[index].authorId}",
                          author_image: sportNews[index].authorImage,
                          name: sportNews[index].name,
                          image: sportNews[index].authorImage,
                          tags: sportNewsSData[index].tags,
                        )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: MediaQuery.of(context).size.height / 4.2,
                              child: CachedNetworkImage(
                                imageUrl: sportNews[index].newsImage,
                                imageBuilder: (context, imageProvider) => Container(
                                  width: MediaQuery.of(context).size.width / 1.15,
                                  height: MediaQuery.of(context).size.height / 4.2,
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
                                errorWidget: (context, url, error) => ImageMainErrorHelper(),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                                    child: Text(
                                      sportNews[index].title ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontFamily: FontType.AnekGujaratiBold),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                                    child: Text("$mDate $time" ?? ""),
                                  )
                                ],
                              ),
                            )
                          ],
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
              ) : LoadingHelper(),
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
      await getSportNews(7,offset);
      setState((){
        isLoadingMore = false;
      });
    }
    else{
      print("don't call");

    }
  }
  Future<GeneralNewsModel> sportNewsOBJ;
  List<GNews> sportNewsSData = [];
  List<GData> sportNewsMData = [];
  List<GNews> sportNews;

  getSportNews(cateId,offset) async {
    setState(() {
      isLoading = true;
    });
    try {
      sportNewsOBJ = ApiFuture().categoryWiseNews(ApiUrl.AllNews,cateId,offset);
      await sportNewsOBJ.then((value) async {
        sportNewsSData.addAll(value.data.news);
        sportNewsMData.add(value.data);
      });
      setState(() {
        Set<int> uniqueNews = Set<int>.from(sportNewsSData.map((e) => e.id));
        sportNews = uniqueNews.map((id) => sportNewsSData.firstWhere((element) => element.id == id)).toList();
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
