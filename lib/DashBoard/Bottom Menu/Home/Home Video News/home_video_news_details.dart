import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:new_gujarati_news/DashBoard/Bottom%20Menu/Home/Tags/video_tags_news.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../../../../App Helper/Model/video_news_model.dart';
import '../../../../App Helper/Service/share_data.dart';
import '../../../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../../../../App Helper/Ui Helper/image_error_helper.dart';
import '../../../../App Helper/Ui Helper/image_helper.dart';
import '../../../../main.dart';
import '../../../app_bar_view.dart';

class HomeVideoNewsDetails extends StatefulWidget {
  var vnews,title,videoUrls;
  List<VTag> vtags;
  VideoPlayerController? videoPlayerController;
  HomeVideoNewsDetails({
    Key? key,this.vnews,
    required this.vtags,this.title,this.videoUrls
  }) : super(key: key);

  @override
  State<HomeVideoNewsDetails> createState() => _HomeVideoNewsDetailsState();
}

class _HomeVideoNewsDetailsState extends State<HomeVideoNewsDetails> {
  VideoPlayerController? _Controller;
  ChewieController? _chewieController;
  bool _isPlaying = false;
  bool? isLoading;
  @override
  void initState() {
    _Controller =  VideoPlayerController.network(widget.vnews.videoUrls)
      ..addListener(() {
        final bool isPlaying = _Controller!.value.isPlaying;
        if(isPlaying != _isPlaying){
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((value){
        setState(() {
        });
      });
    _chewieController = ChewieController(
      videoPlayerController: _Controller!,
      autoPlay: true,
      looping: true,
    );
    super.initState();
  }
  @override
  void dispose() {
    _Controller!.dispose();
    _chewieController!.dispose();
    widget.videoPlayerController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
    var formattedDate = format.parse(widget.vnews.startedAt.toString());
    var mDate = DateFormat.yMMMd().format(formattedDate);
    var time = DateFormat.jm().format(formattedDate);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDetailsPage(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: widget.vnews.videoUrls != null ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3.8,
                      child: _Controller!.value.isInitialized
                          ? Chewie(controller: _chewieController!)
                          : const Center(child: CircularProgressIndicator(color: Colors.red)),
                    ) : const ImageMainErrorHelper(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Text("${widget.vnews.title}" ?? "",style: const TextStyle(fontFamily: FontType.AnekGujaratiSemiBold,fontSize: 20),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      //height: MediaQuery.of(context).size.height / 15,
                      //color: Colors.green,
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
                                  child: Text("${widget.vnews.name ?? "Unknown"}".toUpperCase(),style: const TextStyle(fontFamily: FontType.PoppinsLight),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text("$mDate, $time" ?? "",style: const TextStyle(fontFamily: FontType.PoppinsLight,fontSize: 12),),
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
                                      launch('https://www.linkedin.com/shareArticle?mini=true&url=${Uri.encodeFull(widget.videoUrls)}&title=${Uri.encodeFull(widget.title)}');
                                      //ShareData().share(SocialMedia.linkedin, widget.title ?? "", widget.newsLink ?? "");
                                    },
                                    child: Image(image: AppImageIcons().IndeedImageIcon,width: 30)
                                ),
                                InkWell(
                                    onTap: (){
                                      launch('https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeFull(widget.videoUrls!)}&quote=${Uri.encodeFull(widget.title!)}');
                                      //ShareData().share(SocialMedia.facebook, widget.title ?? "", widget.newsLink ?? "");
                                    },
                                    child: Image(image: AppImageIcons().FacebookImageIcon,width: 30)
                                ),
                                InkWell(
                                    onTap: (){
                                      launch('https://twitter.com/intent/tweet?text=${widget.title} ${Uri.encodeFull(widget.videoUrls)}');
                                      //ShareData().share(SocialMedia.twitter, widget.title ?? "", widget.newsLink ?? "");
                                    },
                                    child: Image(image: AppImageIcons().TwitterImageIcon,width: 30)
                                ),
                                InkWell(
                                    onTap: (){
                                      launch('https://telegram.me/share/url?text=${widget.title} ${Uri.encodeFull(widget.videoUrls)}');
                                      //ShareData().share(SocialMedia.telegram, widget.title ?? "", widget.newsLink ?? "");
                                    },
                                    child: Image(image: AppImageIcons().ShareIcon,width: 30)
                                ),
                                InkWell(
                                    onTap: (){
                                      launch("https://api.whatsapp.com/send?text=${widget.title} ${Uri.encodeFull(widget.videoUrls)}");
                                      //ShareData().share(SocialMedia.whatsapp, widget.title ?? "", widget.newsLink ?? "");
                                    },
                                    child: Image(image: AppImageIcons().WhatsappImageIcon,width: 30)
                                ),
                              ],
                              // [
                              //   InkWell(
                              //       onTap: (){
                              //         ShareData().share(SocialMedia.linkedin, widget.vnews.title ?? "", widget.vnews.videoUrls ?? "");
                              //       },
                              //       child: Image(image: AppImageIcons().IndeedImageIcon,width: 30)
                              //   ),
                              //   InkWell(
                              //       onTap: (){
                              //         ShareData().share(SocialMedia.facebook, widget.vnews.title ?? "", widget.vnews.videoUrls ?? "");
                              //       },
                              //       child: Image(image: AppImageIcons().FacebookImageIcon,width: 30)
                              //   ),
                              //   InkWell(
                              //       onTap: (){
                              //         ShareData().share(SocialMedia.twitter, widget.vnews.title ?? "", widget.vnews.videoUrls ?? "");
                              //       },
                              //       child: Image(image: AppImageIcons().TwitterImageIcon,width: 30)
                              //   ),
                              //   InkWell(
                              //       onTap: (){
                              //         ShareData().share(SocialMedia.telegram, widget.vnews.title ?? "", widget.vnews.videoUrls ?? "");
                              //       },
                              //       child: Image(image: AppImageIcons().ShareIcon,width: 30)
                              //   ),
                              //   InkWell(
                              //       onTap: (){
                              //         ShareData().share(SocialMedia.whatsapp, widget.vnews.title ?? "", widget.vnews.videoUrls ?? "");
                              //       },
                              //       child: Image(image: AppImageIcons().WhatsappImageIcon,width: 30)
                              //   ),
                              // ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.vnews.slug != ""
                      ? Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                    child: Text("${widget.vnews.slug}" ?? "",style: const TextStyle(fontFamily: FontType.PoppinsRegular,fontSize: 15),),
                  )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                    child: HtmlWidget(
                      widget.vnews.description ?? "",
                      onErrorBuilder: (context, element, error) => Text('$element error: $error'),
                      onLoadingBuilder: (context, element, loadingProgress) => Center(child: CircularProgressIndicator(color: RedColor,)),
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
                                itemCount: widget.vtags.length,
                                itemBuilder: (context, index){
                                  var vtag = widget.vtags[index];
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoTagNews(
                                            tagid: vtag.id,
                                            tagnm: vtag.name,
                                          )));
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              color: const Color(0xffD9D9D9),
                                            ),
                                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                            child: Text(
                                              vtag.name ?? "",
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  openImage(authImage) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Image.network(authImage)
            ),
          );
        }
    );
  }
}
