import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:new_gujarati_news/App%20Helper/Model/LiveWire%20News%20Models/live_wire_news_details_model.dart';
import 'package:new_gujarati_news/App%20Helper/Ui%20Helper/data_helper.dart';
import '../../App Helper/Api Future/api_future.dart';
import '../../App Helper/Api Urls/api_url.dart';
import '../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../../App Helper/Ui Helper/loading_helper.dart';
import '../app_bar_view.dart';

class LiveWireDetails extends StatefulWidget {
  var id;
  LiveWireDetails({Key? key,this.id}) : super(key: key);

  @override
  State<LiveWireDetails> createState() => _LiveWireDetailsState();
}

class _LiveWireDetailsState extends State<LiveWireDetails> {
  bool? isLoading;
  @override
  void initState() {
    super.initState();
    getLiveWireDetails(widget.id);
    isLoading = true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDetailsPage(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: isLoading == false ? liveWireDetails.isNotEmpty ? ListView.builder(
          itemCount: liveWireDetails.length,
          itemBuilder: (context, index){
            DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(liveWireDetails[index].createdAt);
            var inputDate = DateTime.parse(parseDate.toString());
            var mDate = DateFormat.yMMMd().format(inputDate);
            var time = DateFormat.jm().format(inputDate);
            return Row(
              children: [
                Container(
                  child: Column(
                    children: [
                      CircleAvatar(radius: 5,backgroundColor: RedColor,),
                      Container(height: 125,width: 1,color: PurpleColor,)
                    ],
                  ),
                ),
                Container(
                  //height: MediaQuery.of(context).size.height / 7,
                  width: MediaQuery.of(context).size.width / 1.08,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: Text(
                          liveWireDetails[index].title ?? "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontFamily: FontType.AnekGujaratiBold,fontSize: 16),),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                        child: Text(
                            liveWireDetails[index].description ?? "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontFamily: FontType.AnekGujaratiSemiBold,fontSize: 10,color: Colors.black87),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: Align(alignment: Alignment.bottomRight,child: Text("$mDate $time" ?? "",style: TextStyle(color: Colors.grey,fontSize: 12),)),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ) : DataHelper() : const LoadingHelper(),
      ),
    );
  }
  Future<LiveWireDetailsModel?>? liveWireDObj;
  List<LiveWireData> liveWireDetails = [];
  getLiveWireDetails(var id) async {
    setState(() {
      isLoading = true;
    });
    try {
      liveWireDObj = ApiFuture().liveWireDetails(ApiUrl.LiveWireDetails,id);
      await liveWireDObj?.then((value) async {
        liveWireDetails.addAll(value!.data);
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
}
