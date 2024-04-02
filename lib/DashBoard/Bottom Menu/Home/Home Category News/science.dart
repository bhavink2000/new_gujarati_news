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


class ScienceN extends StatefulWidget {
  const ScienceN({Key? key}) : super(key: key);

  @override
  State<ScienceN> createState() => _ScienceNState();
}

class _ScienceNState extends State<ScienceN> {
  bool? isLoading;
  bool isLoadingMore = false;
  final scrollController = ScrollController();
  int offset = 0;
  @override
  void initState() {
    super.initState();
    getScienceNews(10,offset);
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
    return scienceNewsSData.length == 0 ? Container() : Container(
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
                  Text("Science".toUpperCase(),style: TextStyle(fontFamily: FontType.PoppinsMedium,fontSize: 18,color: PurpleColor),)
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
                itemCount: isLoadingMore == false ? scienceNews!.length + 1 : scienceNews!.length,
                itemBuilder: (context, index){
                  if(index < scienceNews!.length){
                    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
                    var formattedDate = format.parse(scienceNews![index].startedAt.toString());
                    var mDate = DateFormat.yMMMd().format(formattedDate);
                    var time = DateFormat.jm().format(formattedDate);
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsPage(
                          categoryNm: scienceNews?[index].categoryName,
                          categoryId: scienceNews?[index].categoryId,
                          title: scienceNews?[index].title,
                          en_title: scienceNews?[index].enTitle,
                          news_image: scienceNews?[index].newsImage,
                          banner_description: scienceNews?[index].bannerDescription,
                          description: scienceNews?[index].description,
                          slug: scienceNews?[index].slug,
                          started_at: scienceNews?[index].startedAt,
                          ended_at: scienceNews?[index].endedAt,
                          status: "${scienceNews?[index].status}",
                          author_id: "${scienceNews?[index].authorId}",
                          author_image: scienceNews?[index].authorImage,
                          name: scienceNews?[index].name,
                          image: scienceNews?[index].authorImage,
                          tags: scienceNewsSData[index].tags,
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
                                imageUrl: scienceNews![index].newsImage,
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
                                      scienceNews?[index].title ?? "",
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
      await getScienceNews(10,offset);
      setState((){
        isLoadingMore = false;
      });
    }
    else{
      print("don't call");
    }
  }

  Future<GeneralNewsModel?>? scienceNewsOBJ;
  List<GNews> scienceNewsSData = [];
  List<GData> scienceNewsMData = [];
  List<GNews>? scienceNews;
  getScienceNews(cateId,offset) async {
    setState(() {
      isLoading = true;
    });
    try {
      scienceNewsOBJ = ApiFuture().categoryWiseNews(ApiUrl.AllNews,cateId,offset);
      await scienceNewsOBJ!.then((value) async {
        scienceNewsSData.addAll(value!.data.news);
        scienceNewsMData.add(value.data);
      });
      setState(() {
        Set<int> uniqueNews = Set<int>.from(scienceNewsSData.map((e) => e.id));
        scienceNews = uniqueNews.map((id) => scienceNewsSData.firstWhere((element) => element.id == id)).toList();
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
