//@dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../App Helper/Model/general_news_model.dart';
import '../../../../App Helper/Service/share_data.dart';
import '../../../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../../../../App Helper/Ui Helper/image_error_helper.dart';
import '../../../../App Helper/Ui Helper/image_helper.dart';
import '../news_details_page.dart';

class SubNewsView extends StatelessWidget {
  List<GNews> allNews;
  bool isLoading;
  var index;
  SubNewsView({Key key,this.allNews,this.isLoading,this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 8.8,
        //color: Colors.teal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsPage(
                    categorynm: allNews[index].categoryName,
                    categoryid: allNews[index].categoryId,
                    title: allNews[index].title,
                    en_title: allNews[index].enTitle,
                    news_image: allNews[index].newsImage,
                    banner_description: allNews[index].bannerDescription,
                    description: allNews[index].description,
                    slug: allNews[index].slug,
                    started_at: allNews[index].startedAt,
                    ended_at: allNews[index].endedAt,
                    status: "${allNews[index].status}",
                    author_id: "${allNews[index].authorId}",
                    author_image: allNews[index].authorImage,
                    name: allNews[index].name,
                    image: allNews[index].authorImage,
                    tags: allNews[index].tags,
                    newslink: allNews[index].newsLink,
                  )));
                },
                child: Container(
                  //color: Colors.yellow,
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 8.8,
                  child: allNews[index].newsImage != null ? CachedNetworkImage(
                    imageUrl: allNews[index].newsImage,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(child: CircularProgressIndicator(color: RedColor,strokeWidth: 3.0,)),
                    errorWidget: (context, url, error) => const ImageHomePageSubError(),
                  ) : const ImageHomePageSubError(),
                ),
              ),
            ),
            Container(
              //color: Colors.green,
              width: MediaQuery.of(context).size.width / 1.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        allNews[index].categoryName ?? "",
                        style: const TextStyle(fontFamily: FontType.PoppinsMedium,letterSpacing: 0.5,fontSize: 10,color: Colors.red),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          //Image(image: AppImageIcons().BookmarkImageIcon,color: RedColor,width: 15),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: (){
                              ShareData().shareData(
                                allNews[index].title,
                                allNews[index].newsLink,
                              );
                            },
                            child: Image(
                              image: AppImageIcons().ShareImageIcon,
                              color: RedColor,width: 20,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    //color: Colors.yellow,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsPage(
                          categorynm: allNews[index].categoryName,
                          categoryid: allNews[index].categoryId,
                          title: allNews[index].title,
                          en_title: allNews[index].enTitle,
                          news_image: allNews[index].newsImage,
                          banner_description: allNews[index].bannerDescription,
                          description: allNews[index].description,
                          slug: allNews[index].slug,
                          started_at: allNews[index].startedAt,
                          ended_at: allNews[index].endedAt,
                          status: "${allNews[index].status}",
                          author_id: "${allNews[index].authorId}",
                          author_image: allNews[index].authorImage,
                          name: allNews[index].name,
                          image: allNews[index].authorImage,
                          tags: allNews[index].tags,
                          newslink: allNews[index].newsLink,
                        )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Text(
                          allNews[index].title ?? "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14,fontFamily: FontType.AnekGujaratiSemiBold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
