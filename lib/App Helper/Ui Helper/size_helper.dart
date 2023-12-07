
//@dart=2.9
import 'package:flutter/material.dart';

class DrawerMenuSizeHelper{
 BuildContext context;
 DrawerMenuSizeHelper(this.context) : assert (context != null);

 get MainImageH => MediaQuery.of(context).size.height / 3.5;
 get MainImageW => MediaQuery.of(context).size.width;

 get MainTextContainerH => MediaQuery.of(context).size.height / 3.5;
 get MainTextContainerW => MediaQuery.of(context).size.width;

 get SubContainerH => MediaQuery.of(context).size.height / 8.6;
 get SubContainerW => MediaQuery.of(context).size.width;

 get SubImageH => MediaQuery.of(context).size.height / 9.5;
 get SubImageW => MediaQuery.of(context).size.width / 2.85;

 get SubTextContainerW => MediaQuery.of(context).size.width / 1.7;
 get SubTextHeaderW => MediaQuery.of(context).size.width / 1.8;
 get SubTextFottorW => MediaQuery.of(context).size.width / 1.8;
}