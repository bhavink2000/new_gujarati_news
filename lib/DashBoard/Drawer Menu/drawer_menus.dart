import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../App Helper/Api Urls/api_url.dart';
import '../../App Helper/Model/categorys_model.dart';
import '../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../dashboard.dart';
import 'Exclusive News/exclusive_news.dart';
import 'Top Video News/top_video_news.dart';
import 'Web Stories/web_stories_view.dart';
import 'app_details/contact_us.dart';
import 'drawer_menus_details.dart';


class DrawerMenus extends StatefulWidget {
  const DrawerMenus({Key? key}) : super(key: key);

  @override
  State<DrawerMenus> createState() => _DrawerMenusState();
}

class _DrawerMenusState extends State<DrawerMenus> {
  bool? isLoading;
  @override
  void initState() {
    super.initState();
    getCategoryName();
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.15,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                child: Image(image: AssetImage("Assets/images/sitelogo.png"),width: 130),
              ),
              Container(height: 0.5,color: Colors.grey.withOpacity(0.5),width: MediaQuery.of(context).size.width),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(15, 12, 10, 12),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const DashboardView()));
                  },
                  child: Row(
                    children: [
                      const Image(image: AssetImage("Assets/images/icons/home.png"),width: 15,color: Colors.black87,),
                      const SizedBox(width: 10),
                      Text(
                        'Home',
                        style: TextStyle(fontFamily: FontType.PoppinsRegular,letterSpacing: 0.5,color: PurpleColor,fontSize: 14,fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(15, 0, 10, 12),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const TopVideoNews()));
                  },
                  child: Row(
                    children: [
                      const Image(image: AssetImage("Assets/images/image_icon/play_circle.png"),width: 15,color: Colors.black87,),
                      const SizedBox(width: 10),
                      Text(
                        'Video',
                        style: TextStyle(fontFamily: FontType.PoppinsRegular,letterSpacing: 0.5,color: PurpleColor,fontSize: 14,fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(15, 0, 10, 12),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const WebStoriesView()));
                  },
                  child: Row(
                    children: [
                      const Image(image: AssetImage("Assets/images/image_icon/web_stories.png"),width: 15,color: Colors.black87,),
                      const SizedBox(width: 10),
                      Text(
                        'Web Stories',
                        style: TextStyle(fontFamily: FontType.PoppinsRegular,letterSpacing: 0.5,color: PurpleColor,fontSize: 14,fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),
              ),
              Container(height: 0.5,color: Colors.grey.withOpacity(0.2),width: MediaQuery.of(context).size.width),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ExclusiveNews()));
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                          "Exclusive News",
                          style: TextStyle(fontFamily: FontType.PoppinsRegular,letterSpacing: 0.5,color: PurpleColor,fontSize: 14,fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),
              ),
              Container(height: 0.5,color: Colors.grey.withOpacity(0.2),width: MediaQuery.of(context).size.width),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.62,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => Container(height: 0.5,color: Colors.grey.withOpacity(0.2),width: MediaQuery.of(context).size.width),
                  itemCount: categoryData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenuDetails(
                            id: categoryData[index].id,
                            name: categoryData[index].name,
                          )));
                        },
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Text(
                              categoryData[index].name ?? "",
                              style: TextStyle(fontFamily: FontType.PoppinsRegular,letterSpacing: 0.5,color: PurpleColor,fontSize: 14,fontWeight: FontWeight.bold)
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                color: PurpleColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ContactUs()));
                      },
                      child: const Text("Contact Us",style: TextStyle(fontFamily: FontType.PoppinsMedium,letterSpacing: 0.5,color: Colors.white)
                      )
                    ),
                    Container(width: 1,height: 12,color: Colors.white,),
                    InkWell(
                      onTap: (){
                        launch("https://www.newgujarati.news/privacy-policy");
                      },
                        child: const Text(
                            "Privacy Policy",
                            style: TextStyle(
                                fontFamily: FontType.PoppinsMedium,
                                letterSpacing: 0.5,
                                color: Colors.white
                            )
                        )
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<CategoryModel?>? categoryOBJ;
  List<CData> categoryData = [];
  getCategoryName() async {
    setState(() {
      isLoading = true;
    });
    try {
      categoryOBJ = categoryName(ApiUrl.CategoryNameID);
      await categoryOBJ?.then((value) async {
        categoryData.addAll(value!.data as Iterable<CData>);
      });
      setState(() {
        isLoading = false;
      });
    } on SocketException {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "Internet Connection Problem",backgroundColor: PurpleColor,textColor: Colors.white);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "Please Try Again",backgroundColor: PurpleColor,textColor: Colors.white);
      print("error $e");
    }
    setState(() {});
  }

  Future<CategoryModel> categoryName(String url) async {
    final cacheManager = DefaultCacheManager();
    final file = await cacheManager.getSingleFile(url);
    if (await file.exists()) {
      final response = await file.readAsString();
      var data = jsonDecode(response);
      return CategoryModel.fromJson(data);
    } else {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 30));
      var data = jsonDecode(response.body.toString());
      cacheManager.putFile(url, utf8.encode(response.body));
      return CategoryModel.fromJson(data);
    }
  }
}



