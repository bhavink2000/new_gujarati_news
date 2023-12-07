//@dart=2.9
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../App Helper/Service/notification_service.dart';
import '../App Helper/Ui Helper/image_helper.dart';
import 'Live Wire News/live_wire_page.dart';

class AppBarHomePage extends StatelessWidget with PreferredSizeWidget{
  var cindex;
  AppBarHomePage({ Key key,this.cindex}) : preferredSize = Size.fromHeight(cindex == 1 ? 0 :70), super(key: key);
  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return cindex == 1 ? Container() : AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 3,
      toolbarHeight: MediaQuery.of(context).size.height / 11,
      title: const Image(image: AssetImage("Assets/images/sitelogo.png"),width: 120),
      leading: InkWell(onTap: (){Scaffold.of(context).openDrawer();},child: const Icon(Icons.menu_rounded,color: Colors.black,size: 25,)),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
          child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveWirePage()));
              },
              child: Row(
                children: const [
                  Text("Live\nWire",style: TextStyle(fontSize: 10,color: Colors.black)),
                  SizedBox(width: 1),
                  Image(image: AssetImage("Assets/images/wifi_signal.gif"),width: 22,),
                ],
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
          child: InkWell(
              onTap: (){
                NotificationService().showNotification(title: 'NGN', body: 'NGN Notification');
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>CachedHomeMenu()));
              },
              child: Image(image: AppImageIcons().NotificationImageIcon,width: 25,color: Colors.black,)
          ),
        ),
      ],
    );
  }
}

class AppBarDetailsPage extends StatefulWidget with PreferredSizeWidget{
  AppBarDetailsPage({ Key key,}) : preferredSize = const Size.fromHeight(70), super(key: key);
  @override
  final Size preferredSize;

  @override
  State<AppBarDetailsPage> createState() => _AppBarDetailsPageState();
}

class _AppBarDetailsPageState extends State<AppBarDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 3,
      toolbarHeight: MediaQuery.of(context).size.height / 11,
      title: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 11,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Builder(
                builder: (context)=>
                    InkWell(
                      onTap: ()=> Navigator.pop(context),
                      child: Image(image: AppImageIcons().ArrowBackImageIcon,width: 25),
                    ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Image(
                width: 120,
                image: AssetImage("Assets/images/sitelogo.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: InkWell(
                  onTap: (){
                    NotificationService().showNotification(title: 'NGN', body: 'NGN Notification');
                  },
                  child: Image(image: AppImageIcons().NotificationImageIcon,width: 25)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
