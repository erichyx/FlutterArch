import 'package:json_annotation/json_annotation.dart';

part 'movie_list.g.dart';

@JsonSerializable()
class MoviePagingEntity {
  int count = 0;
  int start = 0;
  int total = 0;
  @JsonKey(name: "sharing_info")
  SharingInfo? sharingInfo;
  List<MovieItem> items = [];

  MoviePagingEntity();

  factory MoviePagingEntity.fromJson(Map<String, dynamic> json) =>
      _$MoviePagingEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MoviePagingEntityToJson(this);
}

@JsonSerializable()
class SharingInfo {
  @JsonKey(name: "sharing_url")
  String? sharingUrl;
  String? title;
  @JsonKey(name: "screenshot_title")
  String? screenshotTitle;
  @JsonKey(name: "screenshot_url")
  String? screenshotUrl;
  @JsonKey(name: "screenshot_type")
  String? screenshotType;
  @JsonKey(name: "wechat_timeline_share")
  String? wechatTimelineShare;

  SharingInfo();

  factory SharingInfo.fromJson(Map<String, dynamic> json) =>
      _$SharingInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SharingInfoToJson(this);
}

@JsonSerializable()
class MovieItem {
  String comment = "";
  Rating? rating;
  @JsonKey(name: "lineticket_url")
  String? lineTicketUrl;
  @JsonKey(name: "has_linewatch")
  bool hasLineWatch = false;
  Pic? pic;
  @JsonKey(name: "honor_infos")
  List<HonorInfo> honorInfos = [];
  String? uri;
  List<String> photos = [];
  @JsonKey(name: "vendor_icons")
  List<String>? vendorIcons;
  dynamic interest;
  String year = "";
  @JsonKey(name: "card_subtitle")
  String cardSubtitle = "";
  String title = "";
  String? type;
  String id = "";
  List<String>? tags;

  MovieItem();

  factory MovieItem.fromJson(Map<String, dynamic> json) =>
      _$MovieItemFromJson(json);

  Map<String, dynamic> toJson() => _$MovieItemToJson(this);
}

@JsonSerializable()
class HonorInfo {
  String? kind;
  String? uri;
  int rank = 0;
  String? title;

  HonorInfo();

  factory HonorInfo.fromJson(Map<String, dynamic> json) =>
      _$HonorInfoFromJson(json);

  Map<String, dynamic> toJson() => _$HonorInfoToJson(this);
}

@JsonSerializable()
class Rating {
  int count = 0;
  int max = 0;
  @JsonKey(name: "star_count")
  double starCount = 0;
  double value = 0;

  Rating();

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);
}

@JsonSerializable()
class Pic {
  String large = "";
  String normal = "";

  Pic();

  factory Pic.fromJson(Map<String, dynamic> json) => _$PicFromJson(json);

  Map<String, dynamic> toJson() => _$PicToJson(this);
}
