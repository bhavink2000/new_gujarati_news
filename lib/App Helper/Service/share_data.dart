//@dart=2.9
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
class ShareData{

  void shareData(title, link)async{
    Share.share("$title $link");
  }

  Future share(SocialMedia socialPlatform,var title,var newsUrl)async{
    final urlShare = {
      SocialMedia.facebook:
      "https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeFull(newsUrl)}&quote=${Uri.encodeFull(title)}",
      SocialMedia.linkedin:
      "https://www.linkedin.com/shareArticle?mini=true&url=${Uri.encodeFull(newsUrl)}&title=${Uri.encodeFull(title)}",
      SocialMedia.whatsapp:
      "https://api.whatsapp.com/send?text=$title ${Uri.encodeFull(newsUrl)}",
      SocialMedia.twitter:
      "https://twitter.com/intent/tweet?text=$title ${Uri.encodeFull(newsUrl)}",
      SocialMedia.telegram:
          "https://telegram.me/share/url?text=$title ${Uri.encodeFull(newsUrl)}"
    };
    final url = urlShare[socialPlatform];

    if(await canLaunch(url)){
      await launch(url);
    }

  }

}
/*

class ShareData{
  void shareData(title, link, image)async{
    final urlImage = link;
    final url = Uri.parse(urlImage);
    final response = await http.get(url);
    final bytes = response.bodyBytes;

    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image.jpg';
    File(path).writeAsBytesSync(bytes);

    Share.share("$title $link");
    //Share.shareFiles([path]);
  }
}

*/
