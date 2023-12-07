import 'package:flutter/material.dart';

import 'color_and_font_helper.dart';


class DataHelper extends StatelessWidget {
  const DataHelper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.error,size: 25,color: RedColor,),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("No More News",style: TextStyle(fontFamily: FontType.PoppinsLight,color: PurpleColor,letterSpacing: 1),),
        )
      ],
    );
  }
}

class VideoUpdateingSoon extends StatelessWidget {
  const VideoUpdateingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.upcoming,size: 25,color: Colors.white,),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Updating Soon",style: TextStyle(fontFamily: FontType.PoppinsRegular,color: Colors.white,letterSpacing: 1,fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }
}
class UpdateingSoon extends StatelessWidget {
  const UpdateingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.upcoming,size: 25,color: RedColor,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Updating Soon",style: TextStyle(fontFamily: FontType.AnekGujaratiBold,letterSpacing: 1,fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }
}

class ServerHelper extends StatelessWidget {
  const ServerHelper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.error,size: 25,color: RedColor,),
        ),
        Padding(
          padding: const EdgeInsets.all(1),
          child: Text("Server Error",style: TextStyle(fontFamily: FontType.PoppinsLight,color: PurpleColor,letterSpacing: 1),),
        ),
        Padding(
          padding: const EdgeInsets.all(1),
          child: Text("Try Again",style: TextStyle(fontFamily: FontType.PoppinsLight,color: PurpleColor,letterSpacing: 1),),
        ),
      ],
    );
  }
}

