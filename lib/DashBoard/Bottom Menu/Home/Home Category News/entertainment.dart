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


class EntertainmentN extends StatefulWidget {
  const EntertainmentN({Key key}) : super(key: key);

  @override
  State<EntertainmentN> createState() => _EntertainmentNState();
}

class _EntertainmentNState extends State<EntertainmentN> {
  bool isLoading;
  bool isLoadingMore = false;
  final scrollController = ScrollController();
  int offset = 0;

  @override
  void initState() {
    super.initState();
    getEntertainmentNews(6,offset);
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
    return entertainmentNewsSData.length == 0 ? Container() : Container(
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
                  Text("Entertainment".toUpperCase(),style: TextStyle(fontFamily: FontType.PoppinsMedium,fontSize: 18,color: PurpleColor),)
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width ,
              height: MediaQuery.of(context).size.height / 3,
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              //color: Colors.teal,
              child: isLoading == false ? ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                itemCount: isLoadingMore == false ? entertainmentNews.length + 1 : entertainmentNews.length,
                itemBuilder: (context, index){
                  if(index < entertainmentNews.length){
                    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
                    var formattedDate = format.parse(entertainmentNews[index].startedAt.toString());
                    var mDate = DateFormat.yMMMd().format(formattedDate);
                    var time = DateFormat.jm().format(formattedDate);
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsPage(
                          categorynm: entertainmentNews[index].categoryName,
                          categoryid: entertainmentNews[index].categoryId,
                          title: entertainmentNews[index].title,
                          en_title: entertainmentNews[index].enTitle,
                          news_image: entertainmentNews[index].newsImage,
                          banner_description: entertainmentNews[index].bannerDescription,
                          description: entertainmentNews[index].description,
                          slug: entertainmentNews[index].slug,
                          started_at: entertainmentNews[index].startedAt,
                          ended_at: entertainmentNews[index].endedAt,
                          status: "${entertainmentNews[index].status}",
                          author_id: "${entertainmentNews[index].authorId}",
                          author_image: entertainmentNews[index].authorImage,
                          name: entertainmentNews[index].name,
                          image: entertainmentNews[index].authorImage,
                          tags: entertainmentNewsSData[index].tags,
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
                                imageUrl: entertainmentNews[index].newsImage,
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
                                      entertainmentNews[index].title ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontFamily: FontType.AnekGujaratiSemiBold),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                                    child: Text("$mDate $time"),
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
      await getEntertainmentNews(6,offset);
      setState((){
        isLoadingMore = false;
      });
    }
    else{
      print("don't call");
    }
  }

  Future<GeneralNewsModel> entertainmentNewsOBJ;
  List<GNews> entertainmentNewsSData = [];
  List<GData> entertainmentNewsMData = [];
  List<GNews> entertainmentNews;

  getEntertainmentNews(cateId,offset) async {
    setState(() {
      isLoading = true;
    });
    try {
      entertainmentNewsOBJ = ApiFuture().categoryWiseNews(ApiUrl.AllNews,cateId,offset);
      await entertainmentNewsOBJ.then((value) async {
        entertainmentNewsSData.addAll(value.data.news);
        entertainmentNewsMData.add(value.data);
      });
      setState(() {
        Set<int> uniqueNews = Set<int>.from(entertainmentNewsSData.map((e) => e.id));
        entertainmentNews = uniqueNews.map((id) => entertainmentNewsSData.firstWhere((element) => element.id == id)).toList();
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
