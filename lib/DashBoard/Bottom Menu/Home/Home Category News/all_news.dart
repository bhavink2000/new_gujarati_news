import 'package:flutter/material.dart';
import '../../../../App Helper/Ui Helper/view_more.dart';
import '../view_more_news.dart';

class AllNewsPage extends StatelessWidget {
  const AllNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const AllGeneralNews()));
          },
          child: ViewMore(),
        ),
      ),
    );
  }
}
