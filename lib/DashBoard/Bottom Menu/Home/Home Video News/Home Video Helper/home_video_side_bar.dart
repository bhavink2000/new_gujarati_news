import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../App Helper/Service/share_data.dart';
import '../../../../../App Helper/Ui Helper/image_helper.dart';
import '../../../../../main.dart';

class HomeVideoSideBar extends StatefulWidget {

  var title,newslink;
  HomeVideoSideBar({Key? key,this.title,this.newslink}) : super(key: key);

  @override
  State<HomeVideoSideBar> createState() => _HomeVideoSideBarState();
}

class _HomeVideoSideBarState extends State<HomeVideoSideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      padding: const EdgeInsets.fromLTRB(0, 0, 5, 20),
      //color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: (){
                launch('https://www.linkedin.com/shareArticle?mini=true&url=${Uri.encodeFull(widget.newslink)}&title=${Uri.encodeFull(widget.title)}');
                //ShareData().share(SocialMedia.linkedin, widget.title ?? "", widget.newsLink ?? "");
              },
              child: Image(image: AppImageIcons().IndeedImageIcon,width: 30)
          ),
          InkWell(
              onTap: (){
                launch('https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeFull(widget.newslink!)}&quote=${Uri.encodeFull(widget.title!)}');
                //ShareData().share(SocialMedia.facebook, widget.title ?? "", widget.newsLink ?? "");
              },
              child: Image(image: AppImageIcons().FacebookImageIcon,width: 30)
          ),
          InkWell(
              onTap: (){
                launch('https://twitter.com/intent/tweet?text=${widget.title} ${Uri.encodeFull(widget.newslink)}');
                //ShareData().share(SocialMedia.twitter, widget.title ?? "", widget.newsLink ?? "");
              },
              child: Image(image: AppImageIcons().TwitterImageIcon,width: 30)
          ),
          InkWell(
              onTap: (){
                launch('https://telegram.me/share/url?text=${widget.title} ${Uri.encodeFull(widget.newslink)}');
                //ShareData().share(SocialMedia.telegram, widget.title ?? "", widget.newsLink ?? "");
              },
              child: Image(image: AppImageIcons().ShareIcon,width: 30)
          ),
          InkWell(
              onTap: (){
                launch("https://api.whatsapp.com/send?text=${widget.title} ${Uri.encodeFull(widget.newslink)}");
                //ShareData().share(SocialMedia.whatsapp, widget.title ?? "", widget.newsLink ?? "");
              },
              child: Image(image: AppImageIcons().WhatsappImageIcon,width: 30)
          ),
        ],
      ),
    );
  }
}
