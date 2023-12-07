//@dart=2.9
import 'package:flutter/material.dart';
import 'package:new_gujarati_news/DashBoard/app_bar_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../drawer_menus.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenus(),
      appBar: AppBarHomePage(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Icon(Icons.location_on_outlined,color: RedColor,size: 20,),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(
                            "Office Address",
                            style: TextStyle(
                                fontFamily: FontType.AnekGujaratiBold,
                                color: PurpleColor,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Text(
                        "Westgate Block-D, 20th Floor,\nSarkhej - Gandhinagar Hwy, \nnear YMCA Club, Makarba, \nAhmedabad, Gujarat 380015",
                      style: TextStyle(fontFamily: FontType.NotoSansGujarati,letterSpacing: 0.5,color: Colors.black87),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Icon(Icons.mail_outline_sharp,color: RedColor,size: 20,),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(
                            "Email :",
                            style: TextStyle(
                                fontFamily: FontType.AnekGujaratiBold,
                                color: PurpleColor,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            launch("mailto:info@newgujarati.news");
                          },
                          child: const Text(
                              "info@newgujarati.news",
                              style: TextStyle(
                                  fontFamily: FontType.NotoSansGujarati,
                                  letterSpacing: 0.5,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text("For Advertisement",style: TextStyle(fontFamily: FontType.NotoSansGujarati,letterSpacing: 0.5,fontSize: 12)),
                        InkWell(
                          onTap: (){
                            launch("mailto:ad@newgujarati%20news");
                          },
                          child: const Text(
                              "ad@newgujarati news",
                              style: TextStyle(
                                  fontFamily: FontType.NotoSansGujarati,
                                  letterSpacing: 0.5,
                                  fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        ),
                      ],
                    )
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Icon(Icons.follow_the_signs_rounded,color: RedColor,size: 20,),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(
                            "Follow Us :",
                            style: TextStyle(
                                fontFamily: FontType.AnekGujaratiBold,
                                color: PurpleColor,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: InkWell(
                            onTap: (){
                              launch("https://www.facebook.com/newgujaratinews/");
                            },
                            child: const Image(image: AssetImage("Assets/images/drawer color/facebook.png"),width: 25,)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: InkWell(
                            onTap: (){
                              launch("https://www.newgujarati.news/index.php");
                            },
                            child: const Image(image: AssetImage("Assets/images/drawer color/web.png"),width: 25,)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: InkWell(
                            onTap: (){
                              launch("https://www.youtube.com/channel/UCPl8a34Uh_A3B0tpVa2422g");
                            },
                            child: const Image(image: AssetImage("Assets/images/drawer color/youtube.png"),width: 25,)
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
