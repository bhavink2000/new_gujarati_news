//@dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../App Helper/Model/general_news_model.dart';
import '../../../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../../../../App Helper/Ui Helper/image_error_helper.dart';
import '../../../../App Helper/Ui Helper/loading_helper.dart';
import '../news_details_page.dart';

class HomeExclusiveNews extends StatefulWidget {
  List<GNews> eNewsSData;
  bool isLoading;
  HomeExclusiveNews({Key key,this.eNewsSData,this.isLoading}) : super(key: key);

  @override
  State<HomeExclusiveNews> createState() => _HomeExclusiveNewsState();
}

class _HomeExclusiveNewsState extends State<HomeExclusiveNews> {

  bool isLoading;
  void initState() {
    super.initState();
    isLoading = widget.isLoading;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.3,
      child: widget.isLoading == false ? ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.eNewsSData.length,
        itemBuilder: (context, index){
          DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
          var formattedDate = format.parse(widget.eNewsSData[index].startedAt.toString());
          var mDate = DateFormat.yMMMd().format(formattedDate);
          var time = DateFormat.jm().format(formattedDate);
          return Padding(
            padding: const EdgeInsets.all(5),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsPage(
                  categorynm: widget.eNewsSData[index].categoryName,
                  categoryid: widget.eNewsSData[index].categoryId,
                  title: widget.eNewsSData[index].title,
                  en_title: widget.eNewsSData[index].enTitle,
                  news_image: widget.eNewsSData[index].newsImage,
                  banner_description: widget.eNewsSData[index].bannerDescription,
                  description: widget.eNewsSData[index].description,
                  slug: widget.eNewsSData[index].slug,
                  started_at: widget.eNewsSData[index].startedAt,
                  ended_at: widget.eNewsSData[index].endedAt,
                  status: "${widget.eNewsSData[index].status}",
                  author_id: "${widget.eNewsSData[index].authorId}",
                  author_image: widget.eNewsSData[index].authorImage,
                  name: widget.eNewsSData[index].name,
                  image: widget.eNewsSData[index].authorImage,
                  tags: widget.eNewsSData[index].tags,
                )));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height / 2.08,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors: [
                          RedColor.withOpacity(0.8),
                          PurpleColor.withOpacity(0.9)
                        ]
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.eNewsSData[index].newsImage != null ? CachedNetworkImage(
                      imageUrl: widget.eNewsSData[index].newsImage,
                      imageBuilder: (context, imageprovider) => Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: imageprovider,
                                  fit: BoxFit.fill,
                                  colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)
                              )
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Center(child: CircularProgressIndicator(color: RedColor,strokeWidth: 3.0)),
                      errorWidget: (context, url, error) => const ImageMainErrorHelper(),
                    ) : const ImageMainErrorHelper(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                      child: Text("$mDate $time",style: const TextStyle(color: Colors.white,fontSize: 10),),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                      child: Text(
                        widget.eNewsSData[index].title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white,fontSize: 18,fontFamily: FontType.AnekGujaratiBold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 14),
                      child: Text(
                        widget.eNewsSData[index].bannerDescription ?? "",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white,fontSize: 12,letterSpacing: 0.5),),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ) : const LoadingHelper(),
    );
  }
}
