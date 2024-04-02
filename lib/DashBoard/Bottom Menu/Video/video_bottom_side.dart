// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../App Helper/Ui Helper/color_and_font_helper.dart';

class VideoBottomMenu extends StatefulWidget {
  var title,slug,desc,videourl,date;
  VideoBottomMenu({Key? key,this.title,this.slug,this.desc,this.videourl,this.date}) : super(key: key);

  @override
  State<VideoBottomMenu> createState() => _VideoBottomMenuState();
}

class _VideoBottomMenuState extends State<VideoBottomMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.green,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      width: MediaQuery.of(context).size.width / 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Text(
              widget.title ?? "",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white,fontFamily: FontType.AnekGujaratiBold,fontSize: 14),),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
            child: HtmlWidget(
              widget.desc ?? "",
              textStyle: const TextStyle(color: Colors.white70,fontFamily: FontType.AnekGujaratiSemiBold,letterSpacing: 0.5,fontSize: 10),
              onErrorBuilder: (context, element, error) => Text('$element error: $error'),
              onLoadingBuilder: (context, element, loadingProgress) => Center(child: CircularProgressIndicator(color: RedColor,)),
            ),
          ),
        ],
      ),
    );
  }
}
