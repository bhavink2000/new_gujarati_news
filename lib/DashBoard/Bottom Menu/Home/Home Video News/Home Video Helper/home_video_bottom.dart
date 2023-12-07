//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';

import '../../../../../App Helper/Ui Helper/color_and_font_helper.dart';


class HomeVideoBottom extends StatefulWidget {
  var title,desc,date;
  HomeVideoBottom({Key key,this.title,this.desc,this.date}) : super(key: key);

  @override
  State<HomeVideoBottom> createState() => _HomeVideoBottomState();
}

class _HomeVideoBottomState extends State<HomeVideoBottom> {
  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
    var formattedDate = format.parse(widget.date.toString());
    var mDate = DateFormat.yMMMd().format(formattedDate);
    var time = DateFormat.jm().format(formattedDate);
    return Container(
      //color: Colors.green,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      width: MediaQuery.of(context).size.width / 1.3,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Text(
              "$mDate, $time" ?? "",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white,fontFamily: FontType.AnekGujaratiSemiBold,fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
