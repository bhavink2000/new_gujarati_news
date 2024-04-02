import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../../../App Helper/Model/video_news_model.dart';
import '../../../App Helper/Service/share_data.dart';
import '../../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../../../App Helper/Ui Helper/image_helper.dart';
import '../../../main.dart';
import '../../Bottom Menu/Home/Tags/video_tags_news.dart';
import '../../app_bar_view.dart';
import '../drawer_menus.dart';

class TopVideoNewsDetails extends StatefulWidget {
  var id,catenm,cateid,title,entitle,videourl,imageurl,desc,slug,startedat,endedat,status,authid,name,authimage;
  List<VTag> vtags;
  TopVideoNewsDetails({Key? key,
    this.id,this.cateid,this.catenm,this.title,this.entitle,this.videourl,this.imageurl,
    this.desc,this.slug,this.startedat,this.endedat,this.status,this.authid,this.name,this.authimage,required this.vtags}) : super(key: key);

  @override
  State<TopVideoNewsDetails> createState() => _TopVideoNewsDetailsState();
}

class _TopVideoNewsDetailsState extends State<TopVideoNewsDetails> {

  VideoPlayerController? _Controller;
  ChewieController? _chewieController;
  bool _isPlaying = false;
  bool? isLoading;
  @override
  void initState() {
    _Controller =  VideoPlayerController.network("${widget.videourl}")
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
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
    var formattedDate = format.parse(widget.startedat.toString());
    var mDate = DateFormat.yMMMd().format(formattedDate);
    var time = DateFormat.jm().format(formattedDate);
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerMenus(),
      appBar: AppBarHomePage(),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text("${widget.title}",style: const TextStyle(fontFamily: FontType.PoppinsMedium,fontSize: 20),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text("$mDate $time" ?? "",style: const TextStyle(fontFamily: FontType.PoppinsLight,fontSize: 12),),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: _Controller!.value.isInitialized
                        ? Chewie(controller: _chewieController!,)
                        : const Center(child: CircularProgressIndicator(color: Colors.red)),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(11, 5, 11, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onLongPress: (){
                          widget.authimage != null ? openImage(widget.authimage) : Fluttertoast.showToast(msg: "No Image");
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text("${widget.name ?? "-"}".toUpperCase(),style: const TextStyle(fontFamily: FontType.PoppinsLight),),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: (){
                                  launch('https://www.linkedin.com/shareArticle?mini=true&url=${Uri.encodeFull(widget.videourl)}&title=${Uri.encodeFull(widget.title)}');
                                  //ShareData().share(SocialMedia.linkedin, widget.title ?? "", widget.newsLink ?? "");
                                },
                                child: Image(image: AppImageIcons().IndeedImageIcon,width: 30)
                            ),
                            InkWell(
                                onTap: (){
                                  launch('https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeFull(widget.videourl!)}&quote=${Uri.encodeFull(widget.title!)}');
                                  //ShareData().share(SocialMedia.facebook, widget.title ?? "", widget.newsLink ?? "");
                                },
                                child: Image(image: AppImageIcons().FacebookImageIcon,width: 30)
                            ),
                            InkWell(
                                onTap: (){
                                  launch('https://twitter.com/intent/tweet?text=${widget.title} ${Uri.encodeFull(widget.videourl)}');
                                  //ShareData().share(SocialMedia.twitter, widget.title ?? "", widget.newsLink ?? "");
                                },
                                child: Image(image: AppImageIcons().TwitterImageIcon,width: 30)
                            ),
                            InkWell(
                                onTap: (){
                                  launch('https://telegram.me/share/url?text=${widget.title} ${Uri.encodeFull(widget.videourl)}');
                                  //ShareData().share(SocialMedia.telegram, widget.title ?? "", widget.newsLink ?? "");
                                },
                                child: Image(image: AppImageIcons().ShareIcon,width: 30)
                            ),
                            InkWell(
                                onTap: (){
                                  launch("https://api.whatsapp.com/send?text=${widget.title} ${Uri.encodeFull(widget.videourl)}");
                                  //ShareData().share(SocialMedia.whatsapp, widget.title ?? "", widget.newsLink ?? "");
                                },
                                child: Image(image: AppImageIcons().WhatsappImageIcon,width: 30)
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                widget.slug != ""
                    ? Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                  child: Text("${widget.slug}",style: const TextStyle(fontFamily: FontType.PoppinsRegular,fontSize: 15),),
                )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: HtmlWidget(
                    widget.desc ?? "",
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
          )
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
