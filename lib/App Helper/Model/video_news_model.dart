import 'dart:convert';

VideoNewsModel videoNewsModelFromJson(String str) => VideoNewsModel.fromJson(json.decode(str));

String videoNewsModelToJson(VideoNewsModel data) => json.encode(data.toJson());

class VideoNewsModel {
  VideoNewsModel({
    required this.message,
    required this.success,
    required this.data,
    required this.status,
  });

  String message;
  int success;
  VData data;
  int status;

  factory VideoNewsModel.fromJson(Map<String, dynamic> json) => VideoNewsModel(
    message: json["message"],
    success: json["success"],
    data: VData.fromJson(json["data"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": data.toJson(),
    "status": status,
  };
}

class VData {
  VData({
    required this.news,
  });

  List<VNews> news;

  factory VData.fromJson(Map<String, dynamic> json) => VData(
    news: List<VNews>.from(json["news"].map((x) => VNews.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "news": List<dynamic>.from(news.map((x) => x.toJson())),
  };
}

class VNews {
  VNews({
    required this.id,
    required this.categoryName,
    required this.categoryId,
    required this.title,
    required this.enTitle,
    required this.videoFiles,
    required this.imageFiles,
    required this.description,
    required this.slug,
    required this.startedAt,
    required this.endedAt,
    required this.status,
    required this.authorId,
    required this.name,
    required this.videoUrls,
    required this.imageUrl,
    required this.authorImage,
    required this.tags,
  });

  int id;
  String categoryName;
  int categoryId;
  String title;
  String enTitle;
  String videoFiles;
  String imageFiles;
  String description;
  String slug;
  String startedAt;
  String endedAt;
  int status;
  dynamic authorId;
  String name;
  String videoUrls;
  String imageUrl;
  String authorImage;
  List<VTag> tags;

  factory VNews.fromJson(Map<String, dynamic> json) => VNews(
    id: json["id"],
    categoryName: json["category_name"],
    categoryId: json["category_id"],
    title: json["title"],
    enTitle: json["en_title"],
    videoFiles: json["video_files"],
    imageFiles: json["image_files"],
    description: json["description"],
    slug: json["slug"],
    startedAt: json["started_at"],
    endedAt: json["ended_at"],
    status: json["status"],
    authorId: json["author_id"],
    name: json["name"],
    videoUrls: json["video_urls"],
    imageUrl: json["image_url"],
    authorImage: json["author_image"],
    tags: List<VTag>.from(json["tags"].map((x) => VTag.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "category_id": categoryId,
    "title": title,
    "en_title": enTitle,
    "video_files": videoFiles,
    "image_files": imageFiles,
    "description": description,
    "slug": slug,
    "started_at": startedAt,
    "ended_at": endedAt,
    "status": status,
    "author_id": authorId,
    "name": name,
    "video_urls": videoUrls,
    "image_url": imageUrl,
    "author_image": authorImage,
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
  };
}

class VTag {
  VTag({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory VTag.fromJson(Map<String, dynamic> json) => VTag(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}