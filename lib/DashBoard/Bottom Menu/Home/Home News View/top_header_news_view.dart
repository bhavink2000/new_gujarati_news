//@dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../App Helper/Model/general_news_model.dart';
import '../../../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../../../../App Helper/Ui Helper/image_error_helper.dart';
import '../news_details_page.dart';

class TopHeaderNewsView extends StatefulWidget {
  List<GNews> allNews;
  bool isLoading;
  TopHeaderNewsView({Key key,this.allNews,this.isLoading}) : super(key: key);

  @override
  State<TopHeaderNewsView> createState() => _TopHeaderNewsViewState();
}

class _TopHeaderNewsViewState extends State<TopHeaderNewsView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsPage(
            categorynm: widget.allNews[0].categoryName,
            categoryid: widget.allNews[0].categoryId,
            title: widget.allNews[0].title,
            en_title: widget.allNews[0].enTitle,
            news_image: widget.allNews[0].newsImage,
            banner_description: widget.allNews[0].bannerDescription,
            description: widget.allNews[0].description,
            slug: widget.allNews[0].slug,
            started_at: widget.allNews[0].startedAt,
            ended_at: widget.allNews[0].endedAt,
            status: "${widget.allNews[0].status}",
            author_id: "${widget.allNews[0].authorId}",
            author_image: widget.allNews[0].authorImage,
            name: widget.allNews[0].name,
            image: widget.allNews[0].authorImage,
            tags: widget.allNews[0].tags,
          )));
        },
        child: Container(
          height: MediaQuery.of(context).size.height / 3.5,
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
          child: Stack(
            children: [
              widget.allNews[0].newsImage != null ? CachedNetworkImage(
                imageUrl: widget.allNews[0].newsImage,
                imageBuilder: (context, imageprovider) => Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),
                      image: DecorationImage(
                          image: imageprovider,
                          fit: BoxFit.cover,
                          colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)
                      )
                  ),
                ),
                placeholder: (context, url) => Center(child: CircularProgressIndicator(color: RedColor,strokeWidth: 3.0)),
                errorWidget: (context, url, error) => const ImageMainErrorHelper(),
              ) : const ImageMainErrorHelper(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  gradient: LinearGradient(
                      colors: [
                        Colors.black12,
                        Colors.black.withOpacity(0.8)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                child: Column(
                  children: [
                    const Spacer(),
                    widget.allNews[0].tags != null ? Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: RedColor.withOpacity(0.5)),
                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                      child: Text(
                        widget.allNews[0].tags[0].name ?? "",
                        style: const TextStyle(fontFamily: FontType.PoppinsMedium,color: Colors.white,letterSpacing: 0.5),
                      ),
                    ) : Container(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                      child: Text(
                        widget.allNews[0].title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontFamily: FontType.AnekGujaratiSemiBold,letterSpacing: 1,color: Colors.white,fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
