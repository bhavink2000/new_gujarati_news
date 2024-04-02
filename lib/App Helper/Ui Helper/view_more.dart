import 'package:flutter/material.dart';
import 'color_and_font_helper.dart';

class ViewMore extends StatelessWidget {
  const ViewMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("View More".toUpperCase(),
              style: TextStyle(letterSpacing: 0.5,color: RedColor,fontFamily: FontType.PoppinsMedium,fontSize: 12,fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5),
            Icon(Icons.arrow_circle_right_outlined,color: RedColor,size: 15)
          ],
        ),
        SizedBox(height: 2),
        Container(width: 90,height: 0.5,color: Colors.grey.withOpacity(0.5),)
      ],
    );
  }
}
