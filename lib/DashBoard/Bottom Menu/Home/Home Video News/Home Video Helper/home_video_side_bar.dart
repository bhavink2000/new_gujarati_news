//@dart=2.9
import 'package:flutter/material.dart';

import '../../../../../App Helper/Service/share_data.dart';
import '../../../../../App Helper/Ui Helper/image_helper.dart';
import '../../../../../main.dart';

class HomeVideoSideBar extends StatefulWidget {

  var title,newslink;
  HomeVideoSideBar({Key key,this.title,this.newslink}) : super(key: key);

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
    );
  }
}
