import 'dart:convert';

LiveWireDetailsModel liveWireDetailsModelFromJson(String str) => LiveWireDetailsModel.fromJson(json.decode(str));

String liveWireDetailsModelToJson(LiveWireDetailsModel data) => json.encode(data.toJson());

class LiveWireDetailsModel {
  LiveWireDetailsModel({
    required this.message,
    required this.success,
    required this.data,
    required this.status,
  });

  String message;
  int success;
  List<LiveWireData> data;
  int status;

  factory LiveWireDetailsModel.fromJson(Map<String, dynamic> json) => LiveWireDetailsModel(
    message: json["message"],
    success: json["success"],
    data: List<LiveWireData>.from(json["data"].map((x) => LiveWireData.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class LiveWireData {
  LiveWireData({
    required this.id,
    required this.parentId,
    required this.title,
    required this.description,
    required this.newsUrl,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  dynamic parentId;
  String title;
  String description;
  String newsUrl;
  String slug;
  int status;
  String createdAt;
  String updatedAt;

  factory LiveWireData.fromJson(Map<String, dynamic> json) => LiveWireData(
    id: json["id"],
    parentId: json["parent_id"],
    title: json["title"],
    description: json["description"],
    newsUrl: json["news_url"],
    slug: json["slug"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "title": title,
    "description": description,
    "news_url": newsUrl,
    "slug": slug,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}