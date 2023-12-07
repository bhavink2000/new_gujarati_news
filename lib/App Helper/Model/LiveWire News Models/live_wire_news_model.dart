import 'dart:convert';

LiveWireNewsModel liveWireNewsModelFromJson(String str) => LiveWireNewsModel.fromJson(json.decode(str));

String liveWireNewsModelToJson(LiveWireNewsModel data) => json.encode(data.toJson());

class LiveWireNewsModel {
  LiveWireNewsModel({
    required this.message,
    required this.success,
    required this.data,
    required this.status,
  });

  String message;
  int success;
  List<LiveData> data;
  int status;

  factory LiveWireNewsModel.fromJson(Map<String, dynamic> json) => LiveWireNewsModel(
    message: json["message"],
    success: json["success"],
    data: List<LiveData>.from(json["data"].map((x) => LiveData.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class LiveData {
  LiveData({
    required this.id,
    required this.title,
    required this.status,
    required this.createdAt,
  });

  int id;
  String title;
  int status;
  String createdAt;

  factory LiveData.fromJson(Map<String, dynamic> json) => LiveData(
    id: json["id"],
    title: json["title"],
    status: json["status"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "status": status,
    "created_at": createdAt,
  };
}
