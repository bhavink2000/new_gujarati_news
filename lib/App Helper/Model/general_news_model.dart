import 'dart:convert';

GeneralNewsModel generalNewsModelFromJson(String str) => GeneralNewsModel.fromJson(json.decode(str));

String generalNewsModelToJson(GeneralNewsModel data) => json.encode(data.toJson());

class GeneralNewsModel {
  GeneralNewsModel({
    required this.message,
    required this.success,
    required this.data,
    required this.status,
  });

  String message;
  int success;
  GData data;
  int status;

  factory GeneralNewsModel.fromJson(Map<String, dynamic> json) => GeneralNewsModel(
    message: json["message"],
    success: json["success"],
    data: GData.fromJson(json["data"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": data.toJson(),
    "status": status,
  };
}

class GData {
  GData({
    required this.news,
  });

  List<GNews> news;

  factory GData.fromJson(Map<String, dynamic> json) => GData(
    news: List<GNews>.from(json["news"].map((x) => GNews.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "news": List<dynamic>.from(news.map((x) => x.toJson())),
  };
}

class GNews {
  GNews({
    required this.id,
    required this.categoryName,
    required this.categoryId,
    required this.title,
    required this.enTitle,
    required this.bannerDescription,
    required this.description,
    required this.categoryDescription,
    required this.slug,
    required this.startedAt,
    required this.endedAt,
    required this.status,
    required this.authorId,
    required this.name,
    required this.featuredStatus,
    required this.newsImage,
    required this.bannerFile,
    required this.newsLink,
    required this.authorImage,
    required this.tags,
  });

  int id;
  String categoryName;
  int categoryId;
  String title;
  String enTitle;
  String bannerDescription;
  String description;
  String categoryDescription;
  String slug;
  String startedAt;
  String endedAt;
  int status;
  dynamic authorId;
  String name;
  dynamic featuredStatus;
  String newsImage;
  String bannerFile;
  String newsLink;
  String authorImage;
  List<GTag> tags;

  factory GNews.fromJson(Map<String, dynamic> json) => GNews(
    id: json["id"],
    categoryName: json["category_name"]!,
    categoryId: json["category_id"],
    title: json["title"],
    enTitle: json["en_title"],
    bannerDescription: json["banner_description"],
    description: json["description"],
    categoryDescription: json["category_description"],
    slug: json["slug"],
    startedAt: json["started_at"],
    endedAt: json["ended_at"],
    status: json["status"],
    authorId: json["author_id"],
    name: json["name"]!,
    featuredStatus: json["featured_status"],
    newsImage: json["news_image"],
    bannerFile: json["banner_file"],
    newsLink: json["news_link"],
    authorImage: json["author_image"],
    tags: List<GTag>.from(json["tags"].map((x) => GTag.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryNameValues.reverse[categoryName],
    "category_id": categoryId,
    "title": title,
    "en_title": enTitle,
    "banner_description": bannerDescription,
    "description": description,
    "category_description": categoryDescription,
    "slug": slug,
    "started_at": startedAt,
    "ended_at": endedAt,
    "status": status,
    "author_id": authorId,
    "name": nameValues.reverse[name],
    "featured_status": featuredStatus,
    "news_image": newsImage,
    "banner_file": bannerFile,
    "news_link": newsLink,
    "author_image": authorImage,
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
  };
}

enum CategoryName { POLITICS, RAJYA, WORLD, ENTERTAINMENT, CRIME, LAW, NGN_SPECIAL, BUSINESS, SPORTS }

final categoryNameValues = EnumValues({
  "Business": CategoryName.BUSINESS,
  "Crime": CategoryName.CRIME,
  "Entertainment": CategoryName.ENTERTAINMENT,
  "Law": CategoryName.LAW,
  "NGN Special": CategoryName.NGN_SPECIAL,
  "Politics": CategoryName.POLITICS,
  "Rajya": CategoryName.RAJYA,
  "Sports": CategoryName.SPORTS,
  "World": CategoryName.WORLD
});

enum Name { DHRUTI_MISTRY, SANJAY_DAVE, NGN_REPORTER, BHAVIN_BAROT, ANVI_TRIVEDI, EMPTY, REPORTER_NGN }

final nameValues = EnumValues({
  "Anvi Trivedi": Name.ANVI_TRIVEDI,
  "Bhavin barot": Name.BHAVIN_BAROT,
  "Dhruti Mistry": Name.DHRUTI_MISTRY,
  "": Name.EMPTY,
  "NGN Reporter": Name.NGN_REPORTER,
  "Reporter@NGN": Name.REPORTER_NGN,
  "Sanjay Dave": Name.SANJAY_DAVE
});

class GTag {
  GTag({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory GTag.fromJson(Map<String, dynamic> json) => GTag(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}