//@dart=2.9
import 'package:flutter/material.dart';

import 'Home Category News/all_news.dart';
import 'Home Category News/business.dart';
import 'Home Category News/entertainment.dart';
import 'Home Category News/sport.dart';
import 'Home Category News/world.dart';
import 'Home Video News/home_video_view.dart';

class HomeMenuCategory extends StatelessWidget {
  const HomeMenuCategory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AllNewsPage(),
        SizeBox(),
        const HomeVideoNews(),
        SizeBox(),
        const SportN(),
        SizeBox(),
        const EntertainmentN(),
        SizeBox(),
        const WorldN(),
        SizeBox(),
        const BusinessN(),
        SizeBox(),
      ],
    );
  }
  Widget SizeBox(){
    return const SizedBox(height: 10);
  }
}
