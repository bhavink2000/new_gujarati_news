import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'color_and_font_helper.dart';

class LoadingHelper extends StatelessWidget {
  const LoadingHelper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.discreteCircle(
        color: PurpleColor,
        secondRingColor: RedColor,
        thirdRingColor: PurpleColor,
        size: 25,
      ),
    );
  }
}

/*class LoadingHelper extends StatelessWidget {
  const LoadingHelper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 7,
      itemBuilder: (context, index) => NewsCardSkelton(),
      separatorBuilder: (context, index) => const SizedBox(height: defaultPadding),
    );
  }
}*/

