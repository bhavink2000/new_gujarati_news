//@dart=2.9
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:new_gujarati_news/App%20Helper/Model/general_news_model.dart';
import '../../../../App Helper/Api Future/api_future.dart';
import '../../../../App Helper/Api Urls/api_url.dart';
import '../../../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../news_details_page.dart';


class BusinessN extends StatefulWidget {
  const BusinessN({Key key}) : super(key: key);

  @override
  State<BusinessN> createState() => _BusinessNState();
}

class _BusinessNState extends State<BusinessN> {

  bool isLoading;
  bool isLoadingMore = false;
  final scrollController = ScrollController();
  int offset = 0;

  @override
  void initState() {
    super.initState();
    getBusinessNews(5,offset);
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
    return businessNewsSData.length == 0 ? Container() : Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: Row(
                children: [
                  Container(width: 1,height: 15,color: RedColor,),
                  const SizedBox(width: 5,),
                  Text("Business".toUpperCase(),style: TextStyle(fontFamily: FontType.PoppinsMedium,fontSize: 18,color: PurpleColor),)
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 5.5,
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) => const Divider(
                    color: Colors.black87, thickness: 0.5,indent: 20,endIndent: 20,
                  ),
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  itemCount: isLoadingMore == false ? businessNews.length + 1 : businessNews.length,
                  itemBuilder: (context, index){
                    if(index < businessNews.length){
                      DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
                      var formattedDate = format.parse(businessNews[index].startedAt.toString());
                      var mDate = DateFormat.yMMMd().format(formattedDate);
                      var time = DateFormat.jm().format(formattedDate);
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsPage(
                              categorynm: businessNews[index].categoryName,
                              categoryid: businessNews[index].categoryId,
                              title: businessNews[index].title,
                              en_title: businessNews[index].enTitle,
                              news_image: businessNews[index].newsImage,
                              banner_description: businessNews[index].bannerDescription,
                              description: businessNews[index].description,
                              slug: businessNews[index].slug,
                              started_at: businessNews[index].startedAt,
                              ended_at: businessNews[index].endedAt,
                              status: "${businessNews[index].status}",
                              author_id: "${businessNews[index].authorId}",
                              author_image: businessNews[index].authorImage,
                              name: businessNews[index].name,
                              image: businessNews[index].authorImage,
                              tags: businessNewsSData[index].tags,
                            )));
                          },
                          child: SizedBox(
                            //height: MediaQuery.of(context).size.height / 5.5,
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                        child: Text(
                                          businessNews[index].title ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontFamily: FontType.AnekGujaratiSemiBold,letterSpacing: 0.5,fontSize: 14),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(businessNews[index].name ?? "UNKNOWN",
                                              style: TextStyle(fontFamily: FontType.AnekGujaratiSemiBold,letterSpacing: 0.5,fontSize: 11),
                                            ),
                                            Text("$mDate $time" ?? "",style: TextStyle(color: Colors.black,fontSize: 10),)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    else{
                      return Center(
                        child: CircularProgressIndicator(color: RedColor),
                      );
                    }
                  },
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
      await getBusinessNews(5,offset);
      setState((){
        isLoadingMore = false;
      });
    }
    else{
      print("don't call");
    }
  }


  Future<GeneralNewsModel> businessNewsOBJ;
  List<GNews> businessNewsSData = [];
  List<GData> businessNewsMData = [];
  List<GNews> businessNews;

  getBusinessNews(cateId,offset) async {
    setState(() {
      isLoading = true;
    });
    try {
      businessNewsOBJ = ApiFuture().categoryWiseNews(ApiUrl.AllNews,cateId,offset);
      await businessNewsOBJ.then((value) async {
        businessNewsSData.addAll(value.data.news);
        businessNewsMData.add(value.data);
      });
      setState(() {
        Set<int> uniqueNews = Set<int>.from(businessNewsSData.map((e) => e.id));
        businessNews = uniqueNews.map((id) => businessNewsSData.firstWhere((element) => element.id == id)).toList();
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
