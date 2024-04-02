
import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../DashBoard/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SharedPreferences? loginData;
  String? deviceId;
  AppUpdateInfo? _updateInfo;

  @override
  void initState() {
    super.initState();
    checkForUpdates();
    Future.delayed(const Duration(seconds: 1),(){
      setState(() {
        checkDeviceId();
      });
    });
  }

  void checkDeviceId() async {
    loginData = await SharedPreferences.getInstance();
    loginData!.setBool('login', false);
    setState(() {
      deviceId = loginData!.getString('device_id');
    });
    if(deviceId == null){
      getDeviceId();
    }
    else{
      Timer(const Duration(seconds: 3), ()=>Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>const DashboardView())));
    }
  }

  Future<String?> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      await prefs.setString('device_id', androidDeviceInfo.androidId);
      deviceId = androidDeviceInfo.androidId;
      Timer(const Duration(seconds: 3), ()=>Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>const DashboardView())));
      return androidDeviceInfo.androidId;

    } else if (Platform.isIOS) {
      final IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      await prefs.setString('device_id', iosDeviceInfo.identifierForVendor);
      deviceId = iosDeviceInfo.identifierForVendor;
      Timer(const Duration(seconds: 3), ()=>Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>const DashboardView())));
      return iosDeviceInfo.identifierForVendor; // returns the iOS device ID
    }
    return null;
  }

  Future<void> checkForUpdates() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
        if (_updateInfo!.updateAvailability == UpdateAvailability.updateAvailable) {
          if (currentVersion != _updateInfo!.availableVersionCode) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Update Available'),
                  content: const Text('A new version of the app is available. Do you want to update?'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: const Text('Update'),
                      onPressed: () async {
                        await launch("https://play.google.com/store/apps/details?id=com.new_gujarati_news.ngnfinal");
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimationLimiter(
                  child: AnimationConfiguration.staggeredList(
                      position: 1,
                      duration: Duration(milliseconds: 1000),
                      child: SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                              child: Image(image: AssetImage("Assets/images/splashscreen/logo_1.png"),width: 40)
                          )
                      )
                  )
              ),
              SizedBox(width: 5),
              Column(
                children: [
                  AnimationLimiter(
                      child: AnimationConfiguration.staggeredList(
                          position: 5,
                          duration: Duration(milliseconds: 1000),
                          child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                  child: Image(image: AssetImage("Assets/images/splashscreen/logo_2.png"),width: 100)
                              )
                          )
                      )
                  ),
                  SizedBox(height: 5),
                  AnimationLimiter(
                      child: AnimationConfiguration.staggeredList(
                          position: 9,
                          duration: Duration(milliseconds: 1000),
                          child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                  child: Image(image: AssetImage("Assets/images/splashscreen/logo_3.png"),width: 100)
                              )
                          )
                      )
                  ),
                ],
              )
            ],
          )
        ],
      )
    );
  }
}
