import 'package:flutter/material.dart';

import 'color_and_font_helper.dart';

class ImageMainErrorHelper extends StatelessWidget {
  const ImageMainErrorHelper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: const EdgeInsets.all(75),
      child: Image(image: const AssetImage("Assets/images/sitelogo.png"),color: GreyColor,fit: BoxFit.contain,),
    );
  }
}

class ImageSubErrorHelper extends StatelessWidget {
  const ImageSubErrorHelper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 11,
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Image(image: const AssetImage("Assets/images/sitelogo.png"),color: GreyColor,fit: BoxFit.contain),
    );
  }
}

class ImageHomePageSubError extends StatelessWidget {
  const ImageHomePageSubError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.4,
      height: MediaQuery.of(context).size.height / 14,
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      child: Image(image: const AssetImage("Assets/images/sitelogo.png"),color: GreyColor,fit: BoxFit.contain),
    );
  }
}
