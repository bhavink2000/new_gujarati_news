import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../App Helper/Ui Helper/color_and_font_helper.dart';
import 'Bottom Menu/Home/home_menu.dart';
import 'Bottom Menu/Search/search_menu.dart';
import 'Bottom Menu/Video/video_news.dart';
import 'Drawer Menu/drawer_menus.dart';
import 'app_bar_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  SharedPreferences? loginData;
  String? deviceId;

  @override
  void initState() {
    super.initState();
    intll();

  }
  void intll() async {
    loginData = await SharedPreferences.getInstance();
    loginData?.setBool('login', false);
    setState(() {
      deviceId = loginData?.getString('device_id');
    });
  }

  int _currentIndex = 0;
  final List _children = [
    const HomeMenu(),
    const VideoMenu(),
    const SearchMenu(),
  ];
  void onTapScreen(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: AlertDialog(
                  contentPadding: EdgeInsets.all(1),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  content: Container(
                    //height: MediaQuery.of(context).size.height / 3.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 5),
                        CircleAvatar(
                          maxRadius: 40.0,
                          backgroundColor: Colors.white,
                          child: Image.asset("Assets/images/sitelogo.png",width: 120),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                          child: Text(
                            "Do you really want to close the App?",
                            style: TextStyle(fontFamily: FontType.AnekGujaratiSemiBold,letterSpacing: 0.5,fontSize: 12,),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextButton(
                              child: Text("Stay",style: TextStyle(fontFamily: FontType.AnekGujaratiSemiBold,letterSpacing: 2,fontSize: 15,color: PurpleColor),),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              child: Text("Close",style: TextStyle(fontFamily: FontType.AnekGujaratiSemiBold,letterSpacing: 2,fontSize: 15,color: PurpleColor),),
                              onPressed: (){
                                exit(0);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 5)
                      ],
                    ),
                  ),
                ),
              );
            }
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const DrawerMenus(),
        appBar: AppBarHomePage(cindex: _currentIndex),
        body: _children[_currentIndex],
        bottomSheet: BottomNavigationBar(
            elevation: 0,
            currentIndex: _currentIndex,
            selectedItemColor: Colors.white,
            onTap: onTapScreen,
            backgroundColor: _currentIndex == 1 ? Colors.transparent : const Color(0xff4d114e),
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.white60,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image(image: const AssetImage("Assets/images/icons/home.png"),width: 20,color: _currentIndex == 0 ? Colors.white : Colors.white60),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image(image: const AssetImage("Assets/images/icons/video.png"),width: 20,color: _currentIndex == 1 ? Colors.white : Colors.white60),
                label: 'Video',
              ),
              BottomNavigationBarItem(
                icon: Image(image: const AssetImage("Assets/images/icons/search.png"),width: 20,color: _currentIndex == 2 ? Colors.white : Colors.white60),
                label: 'Search',
              ),
            ]
        ),
      ),
    );
  }
}
