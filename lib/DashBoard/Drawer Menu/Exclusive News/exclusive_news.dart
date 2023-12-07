//@dart=2.9
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:new_gujarati_news/App%20Helper/Model/general_news_model.dart';
import 'package:new_gujarati_news/DashBoard/app_bar_view.dart';
import '../../../App Helper/Api Future/api_future.dart';
import '../../../App Helper/Api Urls/api_url.dart';
import '../../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../../../App Helper/Ui Helper/image_error_helper.dart';
import '../../../App Helper/Ui Helper/loading_helper.dart';
import '../../Bottom Menu/Home/news_details_page.dart';
import '../drawer_menus.dart';

class ExclusiveNews extends StatefulWidget {
  const ExclusiveNews({Key key}) : super(key: key);

  @override
  State<ExclusiveNews> createState() => _ExclusiveNewsState();
}

class _ExclusiveNewsState extends State<ExclusiveNews> {
  bool isLoading;
  int offset = 0;
  @override
  void initState() {
    super.initState();
    getENews(offset);
    isLoading = true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenus(),
      appBar: AppBarHomePage(),
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.04,
        child: isLoading == false ? ListView.builder(
          itemCount: eNewsSData.length,
          itemBuilder: (context, index){
            DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
            var formattedDate = format.parse(eNewsSData[index].startedAt.toString());
            var mDate = DateFormat.yMMMd().format(formattedDate);
            var time = DateFormat.jm().format(formattedDate);
            return Padding(
              padding: const EdgeInsets.all(5),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsPage(
                    categorynm: eNewsSData[index].categoryName,
                    categoryid: eNewsSData[index].categoryId,
                    title: eNewsSData[index].title,
                    en_title: eNewsSData[index].enTitle,
                    news_image: eNewsSData[index].newsImage,
                    banner_description: eNewsSData[index].bannerDescription,
                    description: eNewsSData[index].description,
                    slug: eNewsSData[index].slug,
                    started_at: eNewsSData[index].startedAt,
                    ended_at: eNewsSData[index].endedAt,
                    status: "${eNewsSData[index].status}",
                    author_id: "${eNewsSData[index].authorId}",
                    author_image: eNewsSData[index].authorImage,
                    name: eNewsSData[index].name,
                    image: eNewsSData[index].authorImage,
                    tags: eNewsSData[index].tags,
                  )));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          colors: [
                            RedColor.withOpacity(0.8),
                            PurpleColor.withOpacity(0.9)
                          ]
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      eNewsSData[index].newsImage != null ? CachedNetworkImage(
                        imageUrl: eNewsSData[index].newsImage,
                        imageBuilder: (context, imageprovider) => Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: imageprovider,
                                    fit: BoxFit.fill,
                                    colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)
                                )
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(child: CircularProgressIndicator(color: RedColor,strokeWidth: 3.0)),
                        errorWidget: (context, url, error) => const ImageMainErrorHelper(),
                      ) : const ImageMainErrorHelper(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                        child: Text("$mDate $time",style: const TextStyle(color: Colors.white,fontSize: 10),),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                        child: Text(eNewsSData[index].title ?? "",style: const TextStyle(color: Colors.white,fontSize: 18,fontFamily: FontType.AnekGujaratiBold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 14),
                        child: Text(eNewsSData[index].bannerDescription ?? "",style: const TextStyle(color: Colors.white,fontSize: 12,letterSpacing: 0.5),),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ) : const LoadingHelper(),
      ),
    );
  }
  Future<GeneralNewsModel> eNewsOBJ;
  List<GNews> eNewsSData = [];
  List<GData> eNewsMData = [];
  List<GNews> eNews;
  getENews(var offset) async {
    setState(() {
      isLoading = true;
    });
    try {
      eNewsOBJ = ApiFuture().eNews(ApiUrl.AllNews,offset);
      await eNewsOBJ.then((value) async {
        eNewsSData.addAll(value.data.news);
        eNewsMData.add(value.data);
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
