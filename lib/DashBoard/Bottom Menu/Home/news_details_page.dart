//@dart=2.9
// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, must_be_immutable

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:new_gujarati_news/App%20Helper/Ui%20Helper/data_helper.dart';
import '../../../App Helper/Api Future/api_future.dart';
import '../../../App Helper/Api Urls/api_url.dart';
import '../../../App Helper/Model/general_news_model.dart';
import '../../../App Helper/Service/share_data.dart';
import '../../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../../../App Helper/Ui Helper/image_error_helper.dart';
import '../../../App Helper/Ui Helper/image_helper.dart';
import '../../../App Helper/Ui Helper/loading_helper.dart';
import '../../../main.dart';
import '../../app_bar_view.dart';
import 'Tags/tags_news.dart';

class NewsDetailsPage extends StatefulWidget {
  var categorynm,categoryid,
      title,en_title,news_image,banner_description,description,
      slug,started_at,ended_at,status,author_id,author_image,name,image,
      newslink;
  List<GTag> tags;
  NewsDetailsPage({
    Key key,this.categorynm,this.categoryid,
    this.title,this.en_title,this.news_image,this.banner_description,this.description,
    this.slug,this.started_at,this.ended_at,this.status,this.author_id,this.author_image,this.name,this.image,
    this.tags,
    this.newslink
  }) : super(key: key);

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {

  bool isLoading;
  bool isLoadingMore = false;
  final scrollController = ScrollController();
  int offset = 0;
  @override
  void initState() {
    super.initState();
    getRelatedNews(widget.categoryid,offset);
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
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
    var formattedDate = format.parse(widget.started_at);
    var mDate = DateFormat.yMMMd().format(formattedDate);
    var time = DateFormat.jm().format(formattedDate);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDetailsPage(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: widget.news_image != null ? CachedNetworkImage(
                  imageUrl: widget.news_image,
                  imageBuilder: (context, imageProvider) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Center(child: CircularProgressIndicator(color: RedColor,strokeWidth: 3.0,)),
                  errorWidget: (context, url, error) => ImageMainErrorHelper(),
                ) : const ImageMainErrorHelper()
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text("${widget.title}" ?? "",style: const TextStyle(fontFamily: FontType.AnekGujaratiBold,fontSize: 22),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.height / 18,
                      //color: Colors.yellow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              "${widget.name ?? "-"}".toUpperCase(),
                              maxLines: 1,
                              style: const TextStyle(fontFamily: FontType.AnekGujaratiSemiBold,fontSize: 12),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text("$mDate $time" ?? "",style: const TextStyle(fontFamily: FontType.PoppinsLight,fontSize: 12),),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: (){
                              ShareData().share(SocialMedia.linkedin, widget.title ?? "", widget.newslink ?? "");
                            },
                            child: Image(image: AppImageIcons().IndeedImageIcon,width: 30)
                          ),
                          InkWell(
                            onTap: (){
                              ShareData().share(SocialMedia.facebook, widget.title ?? "", widget.newslink ?? "");
                            },
                            child: Image(image: AppImageIcons().FacebookImageIcon,width: 30)
                          ),
                          InkWell(
                            onTap: (){
                              ShareData().share(SocialMedia.twitter, widget.title ?? "", widget.newslink ?? "");
                            },
                            child: Image(image: AppImageIcons().TwitterImageIcon,width: 30)
                          ),
                          InkWell(
                            onTap: (){
                              ShareData().share(SocialMedia.telegram, widget.title ?? "", widget.newslink ?? "");
                            },
                            child: Image(image: AppImageIcons().ShareIcon,width: 30)
                          ),
                          InkWell(
                            onTap: (){
                              ShareData().share(SocialMedia.whatsapp, widget.title ?? "", widget.newslink ?? "");
                            },
                            child: Image(image: AppImageIcons().WhatsappImageIcon,width: 30)
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            widget.banner_description != ""
              ? Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
              child: Text("${widget.banner_description}" ?? "",style: const TextStyle(fontSize: 15,fontFamily: FontType.AnekGujaratiSemiBold),),
            )
              : Container(),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
              child: HtmlWidget(
                widget.description ?? "",
                onErrorBuilder: (context, element, error) => Text('$element error: $error'),
                onLoadingBuilder: (context, element, loadingProgress) => Center(child: CircularProgressIndicator(color: RedColor,)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 7,
                child: const Image(
                  fit: BoxFit.cover,
                  image: AssetImage("Assets/images/images_ads.png"),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                      child: Text("Tags",style: TextStyle(fontFamily: FontType.PoppinsMedium,color: RedColor,),),
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 20,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.tags.length,
                          itemBuilder: (context, index){
                            var tag = widget.tags[index];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: InkWell(
                                  onTap: (){
                                    print("tagid->${tag.id} / tagnm->${tag.name}");
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TagsNews(
                                      tagid: tag.id,
                                      tagnm: tag.name,
                                    )));
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: const Color(0xffD9D9D9),
                                      ),
                                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      child: Text(
                                        tag.name ?? "",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontFamily: FontType.PoppinsMedium),
                                      )
                                  )
                              ),
                            );
                          },
                        )
                    ),
                  ],
                )
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 6.5,
              color: const Color(0xffD9D9D9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text("Related News",style: TextStyle(fontFamily: FontType.PoppinsMedium,color: RedColor),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                      width: MediaQuery.of(context).size.width,
                      child: isLoading == false ? relatedNewsSData.isNotEmpty ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        controller: scrollController,
                        itemCount: isLoadingMore == false ? relatedNewsSData.length + 1 : relatedNewsSData.length,
                        itemBuilder: (context, index){
                          if(index < relatedNewsSData.length){
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsPage(
                                    categorynm: relatedNewsSData[index].categoryName,
                                    categoryid: relatedNewsSData[index].categoryId,
                                    title: relatedNewsSData[index].title,
                                    en_title: relatedNewsSData[index].enTitle,
                                    news_image: relatedNewsSData[index].newsImage,
                                    banner_description: relatedNewsSData[index].bannerDescription,
                                    description: relatedNewsSData[index].description,
                                    slug: relatedNewsSData[index].slug,
                                    started_at: relatedNewsSData[index].startedAt,
                                    ended_at: relatedNewsSData[index].endedAt,
                                    status: "${relatedNewsSData[index].status}",
                                    author_id: "${relatedNewsSData[index].authorId}",
                                    author_image: relatedNewsSData[index].authorImage,
                                    name: relatedNewsSData[index].name,
                                    image: relatedNewsSData[index].authorImage,
                                    tags: relatedNewsSData[index].tags,
                                  )));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 1.1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        //color: Colors.yellow,
                                        width: MediaQuery.of(context).size.width / 2.8,
                                        height: MediaQuery.of(context).size.height / 11,
                                        child: relatedNewsSData[index].newsImage != null ? CachedNetworkImage(
                                          imageUrl: relatedNewsSData[index].newsImage,
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
                                      Container(
                                        width: MediaQuery.of(context).size.width / 1.85,
                                        height: MediaQuery.of(context).size.height / 11,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                          child: Text(
                                              relatedNewsSData[index].title ?? "",
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontFamily: FontType.AnekGujaratiSemiBold,fontSize: 13,color: Color(0xff010101))
                                          ),
                                        ),
                                      )
                                    ],
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
                      ) : DataHelper() : const LoadingHelper(),
                    ),
                  )
                ],
              ),
            ),
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
      await getRelatedNews(widget.categoryid,offset);
      setState((){
        isLoadingMore = false;
      });
    }
    else{
      print("don't call");
    }
  }

  Future<GeneralNewsModel> relatedNewsOBJ;
  List<GNews> relatedNewsSData = [];
  List<GData> relatedNewsMData = [];

  getRelatedNews(cateId,offset) async {
    setState(() {
      isLoading = true;
    });
    try {
      relatedNewsOBJ = ApiFuture().categoryWiseNews(ApiUrl.AllNews,cateId,offset);
      await relatedNewsOBJ.then((value) async {
        relatedNewsSData.addAll(value.data.news);
        relatedNewsMData.add(value.data);
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