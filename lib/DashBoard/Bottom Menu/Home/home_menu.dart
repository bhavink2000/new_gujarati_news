//@dart=2.9
// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:new_gujarati_news/App%20Helper/Model/general_news_model.dart';
import '../../../App Helper/Api Future/api_future.dart';
import '../../../App Helper/Api Urls/api_url.dart';
import '../../../App Helper/Service/share_data.dart';
import '../../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../../../App Helper/Ui Helper/data_helper.dart';
import '../../../App Helper/Ui Helper/image_error_helper.dart';
import '../../../App Helper/Ui Helper/image_helper.dart';
import '../../../App Helper/Ui Helper/loading_helper.dart';
import 'Home News View/exclusive_news_view.dart';
import 'Home News View/sub_news_view.dart';
import 'Home News View/top_header_news_view.dart';
import 'home_menu_categorys.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key key}) : super(key: key);
  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  bool isLoading;
  var finalDate;
  final scrollController = ScrollController();
  int offset = 0;
  @override
  void initState() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    finalDate = today.toString().split(" ")[0];
    super.initState();
    getNews(offset);
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        getENews(offset);
      });
    });
    isLoading = true;
  }

  Future refreshList() async {
    await Future.delayed(const Duration(seconds: 1));
    getNews(offset);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.2,
      child: RefreshIndicator(
        color: RedColor,
        backgroundColor: Colors.white,
        onRefresh: () async {
          await refreshList();
        },
        child: isLoading == false
            ? allNews == null ? const LoadingHelper() : allNews.isNotEmpty ? ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: 15,
          itemBuilder: (context, index){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                index == 0
                  ? eNewsSData.isEmpty
                    ? Container()
                    : eNewsSData[0].startedAt.toString().split(' ')[0] == finalDate
                      ? HomeExclusiveNews(eNewsSData: eNewsSData,isLoading: isLoading)
                      : Container()
                  : Container(),

                index == 0
                  ? eNewsSData.isEmpty
                    ? TopHeaderNewsView(allNews: allNews,isLoading: isLoading,)
                    : eNewsSData[0].startedAt.toString().split(' ')[0] == finalDate
                      ? Container()
                      : TopHeaderNewsView(allNews: allNews,isLoading: isLoading)
                  : Container(),
                index == 0 ? const SizedBox(height: 10) : Container(),

                SubNewsView(allNews: allNews,isLoading: isLoading,index: index+1),
                index == 14 ? const HomeMenuCategory() : Container(),
              ],
            );
          },
        ) : const DataHelper()
            : const LoadingHelper(),
      ),
    );
  }

  Widget SizeBox(){
    return const SizedBox(height: 10);
  }

  Future<GeneralNewsModel> allNewsOBJ;
  List<GNews> allNewsSData = [];
  List<GData> allNewsMData = [];
  List<GNews> allNews;

  getNews(var offset) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await ApiFuture().generalNews(ApiUrl.AllNews,offset);
      final newsList = response.data.news;
      final uniqueNews = newsList.toSet();
      allNews = uniqueNews.toList();
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

  Future<GeneralNewsModel> eNewsOBJ;
  List<GNews> eNewsSData = [];
  List<GData> eNewsMData = [];
  List<GNews> eNews;
  getENews(var offset) async

  {
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
      print("e $e");
    }
    setState(() {});
  }
}
