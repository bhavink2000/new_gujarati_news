import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:new_gujarati_news/App%20Helper/Model/LiveWire%20News%20Models/live_wire_news_details_model.dart';
import 'package:new_gujarati_news/App%20Helper/Model/LiveWire%20News%20Models/live_wire_news_model.dart';
import 'package:new_gujarati_news/App%20Helper/Model/video_news_model.dart';
import '../Model/categorys_model.dart';
import '../Model/general_news_model.dart';

class ApiFuture{

  Future<GeneralNewsModel?> generalNews(String url, var offset) async {
    try {
      final response = await http.post(Uri.parse(url), body: {
        'offset': '$offset',
      }).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("All News--> $data");
        return GeneralNewsModel.fromJson(data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Failed to load data $e");
    }
  }

  Future<GeneralNewsModel?> tagsNews(String url,tagid,var offset) async {
    try {
      final response = await http.post(Uri.parse(url), body: {
        'offset': '$offset',
        'tag_id': tagid.toString()
      }).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("All News--> $data");
        return GeneralNewsModel.fromJson(data);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Failed to load data $e");
    }
  }

  Future<GeneralNewsModel?> eNews(String url,var offset) async {
    final response = await http.post(Uri.parse(url), body: {
      'offset': '$offset',
      'featured_status': '1'
    }).timeout(const Duration(seconds: 30));
    var data = jsonDecode(response.body.toString());
    print("E News-->$data");
    if (response.statusCode == 200) {
      return GeneralNewsModel.fromJson(data);
    } else {
      return GeneralNewsModel.fromJson(data);
    }
  }

  Future<CategoryModel?> categoryName(String url) async {
    final response = await http.get(Uri.parse(url),).timeout(const Duration(seconds: 30));
    var data = jsonDecode(response.body.toString());
    print("Categorys-->$data");
    if (response.statusCode == 200) {
      return CategoryModel.fromJson(data);
    } else {
      return CategoryModel.fromJson(data);
    }
  }
  Future<GeneralNewsModel?> categoryWiseNews(String url, cateid,var offset) async {
    final response = await http.post(Uri.parse(url), body: {
      'offset': '$offset',
      'category_id': cateid.toString()
    }).timeout(const Duration(seconds: 30));
    var data = jsonDecode(response.body.toString());
    print("Category Wise News-->$data");
    if (response.statusCode == 200) {
      return GeneralNewsModel.fromJson(data);
    } else {
      return GeneralNewsModel.fromJson(data);
    }
  }

  Future<VideoNewsModel?> videoNews(String url,var offset) async {
    final response = await http.post(Uri.parse(url), body: {
      'offset': '$offset',
    }).timeout(const Duration(seconds: 30));
    var data = jsonDecode(response.body.toString());
    print("Video News-->$data");
    if (response.statusCode == 200) {
      return VideoNewsModel.fromJson(data);
    } else {
      return VideoNewsModel.fromJson(data);
    }
  }
  Future<VideoNewsModel?> tagVideoNews(String url,var tagid,var offset) async {
    final response = await http.post(Uri.parse(url), body: {
      'offset': '$offset',
      'tag_id': tagid.toString(),
    }).timeout(const Duration(seconds: 30));
    var data = jsonDecode(response.body.toString());
    print("Video News-->$data");
    if (response.statusCode == 200) {
      return VideoNewsModel.fromJson(data);
    } else {
      return VideoNewsModel.fromJson(data);
    }
  }

  Future<LiveWireNewsModel?> liveWireNews(String url) async {
    final response = await http.post(Uri.parse(url),).timeout(const Duration(seconds: 30));
    var data = jsonDecode(response.body.toString());
    print("Threads-->$data");
    if (response.statusCode == 200) {
      return LiveWireNewsModel.fromJson(data);
    } else {
      return LiveWireNewsModel.fromJson(data);
    }
  }

  Future<LiveWireDetailsModel?> liveWireDetails(String url, var id) async {
    final response = await http.post(Uri.parse(url), body: {
      'id': id.toString(),
    }).timeout(const Duration(seconds: 30));
    var data = jsonDecode(response.body.toString());
    print("Threads Details-->$data");
    if (response.statusCode == 200) {
      return LiveWireDetailsModel.fromJson(data);
    } else {
      return LiveWireDetailsModel.fromJson(data);
    }
  }
}