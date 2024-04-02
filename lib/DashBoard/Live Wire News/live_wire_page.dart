import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:new_gujarati_news/App%20Helper/Model/LiveWire%20News%20Models/live_wire_news_model.dart';
import 'package:new_gujarati_news/App%20Helper/Ui%20Helper/data_helper.dart';
import '../../App Helper/Api Future/api_future.dart';
import '../../App Helper/Api Urls/api_url.dart';
import '../../App Helper/Ui Helper/color_and_font_helper.dart';
import '../../App Helper/Ui Helper/loading_helper.dart';
import '../app_bar_view.dart';
import 'live_wire_details_page.dart';

class LiveWirePage extends StatefulWidget {
  const LiveWirePage({Key? key}) : super(key: key);

  @override
  State<LiveWirePage> createState() => _LiveWirePageState();
}

class _LiveWirePageState extends State<LiveWirePage> {
  bool? isLoading;
  @override
  void initState() {
    super.initState();
    getLiveWire();
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
        //color: Colors.green,
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: isLoading == false ? liveWireMData.isEmpty ? const DataHelper() : ListView.builder(
          itemCount: liveWireMData.length,
          itemBuilder: (context, index){
            DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(liveWireMData[index].createdAt);
            var inputDate = DateTime.parse(parseDate.toString());
            var mDate = DateFormat.yMMMd().format(inputDate);
            var time = DateFormat.jm().format(inputDate);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveWireDetails(
                      id: liveWireMData[index].id,
                    )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                    child: Text(liveWireMData[index].title,style: const TextStyle(fontFamily: FontType.AnekGujaratiSemiBold,fontSize: 18),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                  child: Text("$mDate $time" ?? "",style: const TextStyle(fontSize: 12,color: Colors.grey),),
                ),
                Divider(color: Colors.grey.withOpacity(0.5),thickness: 0.5,),
              ],
            );
          },
        ) : const LoadingHelper(),
      ),
    );
  }

  Future<LiveWireNewsModel?>? liveWireObj;
  List<LiveData> liveWireMData = [];
  getLiveWire() async {
    setState(() {
      isLoading = true;
    });
    try {
      liveWireObj = ApiFuture().liveWireNews(ApiUrl.AllLiveWire);
      await liveWireObj!.then((value) async {
        liveWireMData.addAll(value!.data);
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
