//@dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stories/flutter_stories.dart';

class WebStoriesShow extends StatefulWidget {
  const WebStoriesShow({Key key}) : super(key: key);

  @override
  State<WebStoriesShow> createState() => _WebStoriesShowState();
}

class _WebStoriesShowState extends State<WebStoriesShow> {
  final _momentDuration = const Duration(seconds: 5);

  final stories = [
    Image.asset("Assets/images/images_ads.png"),
    Image.asset("Assets/images/webstories.jpg"),
    Image.asset("Assets/images/images_ads.png"),
    Image.asset("Assets/images/webstories.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: CupertinoPageScaffold(
          backgroundColor: Colors.black87,
          child: Story(
            onFlashForward: Navigator.of(context).pop,
            onFlashBack: Navigator.of(context).pop,
            momentCount: stories.length,
            momentDurationGetter: (idx) => _momentDuration,
            momentBuilder: (context, idx){
              return SafeArea(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  color: Colors.black45,
                  child: stories[idx]
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
