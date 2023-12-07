//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../../../App Helper/Ui Helper/data_helper.dart';
import '../../app_bar_view.dart';
import '../drawer_menus.dart';
import 'web_stories_show.dart';

class WebStoriesView extends StatefulWidget {
  const WebStoriesView({Key key}) : super(key: key);

  @override
  State<WebStoriesView> createState() => _WebStoriesViewState();
}

class _WebStoriesViewState extends State<WebStoriesView> {

  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerMenus(),
      appBar: AppBarHomePage(),
      body: SafeArea(
        child: Column(
          children: [
            //const AppBarView(),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
              child: Row(
                children: [
                  Container(
                    height: 15,width: 2,color: RedColor,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("Web Stories",
                      style: TextStyle(
                        fontFamily: FontType.PoppinsRegular,letterSpacing: 1,fontSize: 20,fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                 // height: MediaQuery.of(context).size.height / 1.3,
                  child: show == false ? const UpdateingSoon() : AnimationLimiter(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.5 /2,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index){
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 1000),
                          columnCount: 9,
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const WebStoriesShow()));
                              },
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage("Assets/images/webstories.jpg")
                                      ),
                                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 1, blurRadius: 1)],
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: const [
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text("It is a long established fact that a reader will be content of a page when looking at its layout.",
                                            style: TextStyle(fontFamily: FontType.PoppinsRegular,fontSize: 13,color: Colors.black),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
