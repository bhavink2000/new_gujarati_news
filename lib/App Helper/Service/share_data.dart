import 'dart:developer';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
// class ShareData{
//
//   void shareData(title, link)async{
//     Share.share("$title $link").then((value){
//       log('share value then -');
//     }).onError((error, stackTrace){
//       log('error->$error');
//       log('error->$stackTrace');
//     }).catchError(onError){
//       log('on ->$onError');
//
//     };
//   }
//
//   Future share(SocialMedia socialPlatform,var title,var newsUrl)async{
//     final urlShare = {
//       SocialMedia.facebook:
//       "https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeFull(newsUrl)}&quote=${Uri.encodeFull(title)}",
//       SocialMedia.linkedin:
//       "https://www.linkedin.com/shareArticle?mini=true&url=${Uri.encodeFull(newsUrl)}&title=${Uri.encodeFull(title)}",
//       SocialMedia.whatsapp:
//       "https://api.whatsapp.com/send?text=$title ${Uri.encodeFull(newsUrl)}",
//       SocialMedia.twitter:
//       "https://twitter.com/intent/tweet?text=$title ${Uri.encodeFull(newsUrl)}",
//       SocialMedia.telegram:
//           "https://telegram.me/share/url?text=$title ${Uri.encodeFull(newsUrl)}"
//     };
//
//     log('urlShare ----->${urlShare[socialPlatform]}');
//     //final url = urlShare[socialPlatform];
//     final url = 'https://pub.dev/packages/url_launcher';
//
//     if (await canLaunch(url)) {
//       log('Launching URL: $url');
//       await launch(
//         url,
//         forceWebView: false,
//         forceSafariVC: false,
//       );
//     } else {
//       log('Cannot launch URL: $url');
//     }
//
//   }
//
// }


class ShareData {
  void shareData(String? title, String? link) async {
    try {
      await Share.share("$title $link");
      log('Share successful');
    } catch (error, stackTrace) {
      log('Share failed: $error\n$stackTrace');
    }
  }

  // Future<void> share(SocialMedia? socialPlatform, String? title, String? newsUrl) async {
  //   final urlShare = {
  //     SocialMedia.facebook: "https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeFull(newsUrl!)}&quote=${Uri.encodeFull(title!)}",
  //     SocialMedia.linkedin: "https://www.linkedin.com/shareArticle?mini=true&url=${Uri.encodeFull(newsUrl)}&title=${Uri.encodeFull(title)}",
  //     SocialMedia.whatsapp: "https://api.whatsapp.com/send?text=$title ${Uri.encodeFull(newsUrl)}",
  //     SocialMedia.twitter: "https://twitter.com/intent/tweet?text=$title ${Uri.encodeFull(newsUrl)}",
  //     SocialMedia.telegram: "https://telegram.me/share/url?text=$title ${Uri.encodeFull(newsUrl)}"
  //   };
  //
  //   final url = urlShare[socialPlatform];
  //
  //   if (url == null) {
  //     log('Invalid social platform or missing URL');
  //     return;
  //   }
  //
  //   try {
  //     if (await canLaunch(url)) {
  //       log('Launching URL: $url');
  //       await launch(
  //         url,
  //         forceWebView: false,
  //         forceSafariVC: false,
  //       );
  //     } else {
  //       log('Cannot launch URL: $url');
  //     }
  //   } catch (error, stackTrace) {
  //     log('URL launch failed: $error\n$stackTrace');
  //   }
  // }
}
