//@dart=2.9
import 'package:flutter/material.dart';

import '../../../App Helper/Service/share_data.dart';

class VideoSideBar extends StatefulWidget {
  var title,desc,date,videourl;
  VideoSideBar({Key key,this.title,this.desc,this.date,this.videourl}) : super(key: key);

  @override
  State<VideoSideBar> createState() => _VideoSideBarState();
}

class _VideoSideBarState extends State<VideoSideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      //color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
              onTap: (){
                ShareData().shareData(
                    widget.title,
                    widget.videourl,
                );
              },
              child: const Image(image: AssetImage("Assets/images/icons/share_outline.png"),width: 30)),
          const SizedBox(height: 20),
          //const Image(image: AssetImage("Assets/images/icons/bookmark_outline.png"),width: 20,),
          //const Image(image: AssetImage("Assets/images/icons/message_circle_outline.png"),width: 30),
        ],
      ),
    );
  }
}
