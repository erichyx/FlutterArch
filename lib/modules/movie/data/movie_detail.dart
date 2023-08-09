import 'package:json_annotation/json_annotation.dart';

import 'movie_list.dart';

part 'movie_detail.g.dart';

// 电影详情
@JsonSerializable()
class MovieDetail {
  Rating? rating;
  @JsonKey(name: "lineticket_url")
  String? lineTicketUrl;
  @JsonKey(name: "rate_info")
  String? rateInfo;
  @JsonKey(name: "controversy_reason")
  String? controversyReason;
  @JsonKey(name: "pubdate")
  List<String> pubDate = const [];
  @JsonKey(name: "last_episode_number")
  dynamic lastEpisodeNumber;
  @JsonKey(name: "interest_control_info")
  dynamic interestControlInfo;
  Pic? pic;
  String? year;
  @JsonKey(name: "vendor_count")
  int? vendorCount;
  @JsonKey(name: "body_bg_color")
  String? bodyBgColor;
  @JsonKey(name: "is_tv")
  bool? isTv;
  @JsonKey(name: "head_info")
  dynamic headInfo;
  @JsonKey(name: "album_no_interact")
  bool? albumNoInteract;
  @JsonKey(name: "ticket_price_info")
  String? ticketPriceInfo;
  @JsonKey(name: "vendor_icons")
  List<String>? vendorIcons;
  @JsonKey(name: "can_rate")
  bool? canRate;
  @JsonKey(name: "card_subtitle")
  String? cardSubtitle;
  @JsonKey(name: "forum_info")
  dynamic forumInfo;
  dynamic webisode;
  String? id;
  @JsonKey(name: "is_restrictive")
  bool? isRestrictive;
  @JsonKey(name: "gallery_topic_count")
  int? galleryTopicCount;
  List<String>? languages;
  List<String> genres = const [];
  @JsonKey(name: "review_count")
  int? reviewCount;
  String title = "";
  String intro = "";
  @JsonKey(name: "interest_cmt_earlier_tip_title")
  String? interestCmtEarlierTipTitle;
  @JsonKey(name: "has_linewatch")
  bool? hasLineWatch;
  @JsonKey(name: "ugc_tabs")
  List<UgcTab>? ugcTabs;
  @JsonKey(name: "forum_topic_count")
  int? forumTopicCount;
  @JsonKey(name: "ticket_promo_text")
  String? ticketPromoText;
  @JsonKey(name: "webview_info")
  dynamic webViewInfo;
  @JsonKey(name: "is_released")
  bool? isReleased;
  List<dynamic>? vendors;
  List<PersonName>? actors;
  dynamic interest;
  @JsonKey(name: "episodes_count")
  int? episodesCount;
  @JsonKey(name: "color_scheme")
  ColorScheme? colorScheme;
  String? type;
  @JsonKey(name: "linewatches")
  List<dynamic>? lineWatches;
  @JsonKey(name: "info_url")
  String? infoUrl;
  List<String>? tags;
  List<String> durations = const [];
  @JsonKey(name: "comment_count")
  int? commentCount;
  Cover? cover;
  @JsonKey(name: "cover_url")
  String coverUrl = "";
  @JsonKey(name: "restrictive_icon_url")
  String? restrictiveIconUrl;
  @JsonKey(name: "header_bg_color")
  String headerBgColor = "";
  @JsonKey(name: "is_douban_intro")
  bool? isDoubanIntro;
  @JsonKey(name: "ticket_vendor_icons")
  List<String>? ticketVendorIcons;
  @JsonKey(name: "honor_infos")
  List<HonorInfo> honorInfos = const [];
  Trailer? trailer;
  @JsonKey(name: "sharing_url")
  String? sharingUrl;
  @JsonKey(name: "subject_collections")
  List<SubjectCollection>? subjectCollections;
  @JsonKey(name: "wechat_timeline_share")
  String? wechatTimelineShare;
  List<String> countries = const [];
  String? url;
  @JsonKey(name: "release_date")
  String? releaseDate;
  @JsonKey(name: "original_title")
  String? originalTitle;
  String? uri;
  @JsonKey(name: "pre_playable_date")
  String? prePlayableDate;
  @JsonKey(name: "episodes_info")
  String? episodesInfo;
  String? subtype;
  List<PersonName>? directors;
  @JsonKey(name: "is_show")
  bool? isShow;
  @JsonKey(name: "in_blacklist")
  bool? inBlacklist;
  @JsonKey(name: "pre_release_desc")
  String? preReleaseDesc;
  dynamic video;
  List<String>? aka;
  @JsonKey(name: "webisode_count")
  int? webisodeCount;
  @JsonKey(name: "null_rating_reason")
  String? nullRatingReason;
  @JsonKey(name: "interest_cmt_earlier_tip_desc")
  String? interestCmtEarlierTipDesc;

  MovieDetail();

  factory MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailToJson(this);
}

@JsonSerializable()
class UgcTab {
  String? source;
  String? type;
  String? title;

  UgcTab();

  factory UgcTab.fromJson(Map<String, dynamic> json) => _$UgcTabFromJson(json);

  Map<String, dynamic> toJson() => _$UgcTabToJson(this);
}

@JsonSerializable()
class PersonName {
  String? name;

  PersonName();

  factory PersonName.fromJson(Map<String, dynamic> json) =>
      _$PersonNameFromJson(json);

  Map<String, dynamic> toJson() => _$PersonNameToJson(this);
}

@JsonSerializable()
class ColorScheme {
  @JsonKey(name: "is_dark")
  bool? isDark;
  @JsonKey(name: "primary_color_light")
  String? primaryColorLight;
  @JsonKey(name: "_base_color")
  List<double>? lBaseColor;
  @JsonKey(name: "secondary_color")
  String? secondaryColor;
  @JsonKey(name: "_avg_color")
  List<double>? lAvgColor;
  @JsonKey(name: "primary_color_dark")
  String? primaryColorDark;

  ColorScheme();

  factory ColorScheme.fromJson(Map<String, dynamic> json) =>
      _$ColorSchemeFromJson(json);

  Map<String, dynamic> toJson() => _$ColorSchemeToJson(this);
}

@JsonSerializable()
class SubjectCollection {
  @JsonKey(name: "is_follow")
  bool isFollow = false;
  String? title;
  String? id;
  String? uri;

  SubjectCollection();

  factory SubjectCollection.fromJson(Map<String, dynamic> json) =>
      _$SubjectCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectCollectionToJson(this);
}

@JsonSerializable()
class Cover {
  String? description;
  Author? author;
  String? url;
  MovieImage? image;
  String? uri;
  @JsonKey(name: "create_time")
  String? createTime;
  int? position;
  @JsonKey(name: "owner_uri")
  String? ownerUri;
  String? type;
  String? id;
  @JsonKey(name: "sharing_url")
  String? sharingUrl;

  Cover();

  factory Cover.fromJson(Map<String, dynamic> json) => _$CoverFromJson(json);

  Map<String, dynamic> toJson() => _$CoverToJson(this);
}

@JsonSerializable()
class Author {
  Loc? loc;
  String? kind;
  String? name;
  String? url;
  String? id;
  @JsonKey(name: "reg_time")
  String? regTime;
  String? uri;
  String? avatar;
  @JsonKey(name: "is_club")
  bool? isClub;
  String? type;
  @JsonKey(name: "avatar_side_icon")
  String? avatarSideIcon;
  String? uid;

  Author();

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}

@JsonSerializable()
class MovieImage {
  ImageMetaData? large;
  dynamic raw;
  ImageMetaData? small;
  @JsonKey(name: "is_animated")
  bool? isAnimated;
  ImageMetaData? normal;

  MovieImage();

  factory MovieImage.fromJson(Map<String, dynamic> json) =>
      _$MovieImageFromJson(json);

  Map<String, dynamic> toJson() => _$MovieImageToJson(this);
}

@JsonSerializable()
class ImageMetaData {
  String? url;
  int? width;
  int? height;
  int? size;

  ImageMetaData();

  factory ImageMetaData.fromJson(Map<String, dynamic> json) =>
      _$ImageMetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$ImageMetaDataToJson(this);
}

@JsonSerializable()
class Loc {
  String? id;
  String? name;
  String? uid;

  Loc();

  factory Loc.fromJson(Map<String, dynamic> json) => _$LocFromJson(json);

  Map<String, dynamic> toJson() => _$LocToJson(this);
}

@JsonSerializable()
class Trailer {
  @JsonKey(name: "sharing_url")
  String? sharingUrl;
  @JsonKey(name: "video_url")
  String? videoUrl;
  String? title;
  String? uri;
  @JsonKey(name: "cover_url")
  String? coverUrl;
  @JsonKey(name: "term_num")
  int? termNum;
  @JsonKey(name: "n_comments")
  int? nComments;
  @JsonKey(name: "create_time")
  String? createTime;
  @JsonKey(name: "subject_title")
  String? subjectTitle;
  @JsonKey(name: "file_size")
  int? fileSize;
  String? runtime;
  String? type;
  String? id;
  String? desc;

  Trailer();

  factory Trailer.fromJson(Map<String, dynamic> json) =>
      _$TrailerFromJson(json);

  Map<String, dynamic> toJson() => _$TrailerToJson(this);
}

// 演职员

@JsonSerializable()
class MovieCredits {
  List<Director> directors = const [];
  int? total;
  List<Actor> actors = const [];

  MovieCredits();

  factory MovieCredits.fromJson(Map<String, dynamic> json) =>
      _$MovieCreditsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieCreditsToJson(this);
}

class SimpleCharacterInfo {
  String name = "";
  String character = "";
  Pic avatar = Pic();
  bool inDouban = false;

  SimpleCharacterInfo(this.name, this.character, this.avatar, this.inDouban);
}

@JsonSerializable()
class Director {
  String name = "";
  List<String>? roles;
  String? title;
  String? url;
  dynamic user;
  String character = "";
  String? uri;
  @JsonKey(name: "latin_name")
  String? latinName;
  @JsonKey(name: "sharing_url")
  String? sharingUrl;
  String? type;
  String? id;
  Pic avatar = Pic();

  Director();

  factory Director.fromJson(Map<String, dynamic> json) =>
      _$DirectorFromJson(json);

  Map<String, dynamic> toJson() => _$DirectorToJson(this);

  SimpleCharacterInfo toSimpleCharacterInfo() {
    return SimpleCharacterInfo(name, character, avatar, user != null);
  }
}

@JsonSerializable()
class Actor {
  String name = "";
  List<String>? roles;
  String? title;
  String? url;
  ActorUser? user;
  String character = "";
  String? uri;
  @JsonKey(name: "latin_name")
  String? latinName;
  @JsonKey(name: "sharing_url")
  String? sharingUrl;
  String? type;
  String? id;
  Pic avatar = Pic();

  Actor();

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);

  Map<String, dynamic> toJson() => _$ActorToJson(this);

  SimpleCharacterInfo toSimpleCharacterInfo() {
    return SimpleCharacterInfo(name, character, avatar, user != null);
  }
}

@JsonSerializable()
class ActorUser {
  Loc? loc;
  String? kind;
  String? name;
  String? url;
  @JsonKey(name: "verify_type")
  int? verifyType;
  String? id;
  @JsonKey(name: "reg_time")
  String? regTime;
  String? uri;
  String? avatar;
  @JsonKey(name: "is_club")
  bool isClub = false;
  String? type;
  @JsonKey(name: "avatar_side_icon")
  String? avatarSideIcon;
  String? uid;

  ActorUser();

  factory ActorUser.fromJson(Map<String, dynamic> json) =>
      _$ActorUserFromJson(json);

  Map<String, dynamic> toJson() => _$ActorUserToJson(this);
}

// 剧照
@JsonSerializable()
class MoviePhotos {
  int? count;
  int? c;
  int? f;
  int? o;
  int? n;
  List<Photos>? photos;
  int? w;
  int? total;
  int? start;

  MoviePhotos();

  factory MoviePhotos.fromJson(Map<String, dynamic> json) =>
      _$MoviePhotosFromJson(json);

  Map<String, dynamic> toJson() => _$MoviePhotosToJson(this);
}

@JsonSerializable()
class Photos {
  @JsonKey(name: "read_count")
  int? readCount;
  MovieImage? image;
  @JsonKey(name: "create_time")
  String? createTime;
  @JsonKey(name: "collections_count")
  int? collectionsCount;
  @JsonKey(name: "reshares_count")
  int? resharesCount;
  String? id;
  Author? author;
  @JsonKey(name: "is_collected")
  bool? isCollected;
  String? subtype;
  String? type;
  @JsonKey(name: "owner_uri")
  String? ownerUri;
  dynamic status;
  @JsonKey(name: "reaction_type")
  int? reactionType;
  String? description;
  @JsonKey(name: "sharing_url")
  String? sharingUrl;
  String? url;
  @JsonKey(name: "reply_limit")
  String? replyLimit;
  String? uri;
  @JsonKey(name: "likers_count")
  int? likersCount;
  @JsonKey(name: "reactions_count")
  int? reactionsCount;
  @JsonKey(name: "comments_count")
  int? commentsCount;
  int? position;

  Photos();

  factory Photos.fromJson(Map<String, dynamic> json) => _$PhotosFromJson(json);

  Map<String, dynamic> toJson() => _$PhotosToJson(this);
}

// 相关影片

@JsonSerializable()
class RelatedItems {
  List<Subject> subjects = const [];
  String? uri;
  List<DouList> doulists = const [];

  RelatedItems();

  factory RelatedItems.fromJson(Map<String, dynamic> json) =>
      _$RelatedItemsFromJson(json);

  Map<String, dynamic> toJson() => _$RelatedItemsToJson(this);
}

@JsonSerializable()
class Subject {
  Rating? rating;
  @JsonKey(name: "alg_json")
  String? algJson;
  @JsonKey(name: "sharing_url")
  String? sharingUrl;
  String? title;
  String? url;
  Pic? pic;
  String? uri;
  dynamic interest;
  String? type;
  String? id;

  Subject();

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}

@JsonSerializable()
class DouList {
  String? category;
  @JsonKey(name: "alg_json")
  String? algJson;
  @JsonKey(name: "is_merged_cover")
  bool? isMergedCover;
  @JsonKey(name: "sharing_url")
  String? sharingUrl;
  String? title;
  String? url;
  @JsonKey(name: "syncing_note")
  dynamic syncingNote;
  String? uri;
  @JsonKey(name: "cover_url")
  String? coverUrl;
  @JsonKey(name: "followers_count")
  int? followersCount;
  @JsonKey(name: "items_count")
  int itemsCount = 0;
  @JsonKey(name: "is_subject_selection")
  bool? isSubjectSelection;
  @JsonKey(name: "list_type")
  String? listType;
  @JsonKey(name: "doulist_type")
  String? doulistType;
  Owner? owner;
  String? type;
  String? id;
  @JsonKey(name: "is_official", defaultValue: false)
  bool isOfficial = false;
  @JsonKey(name: "done_count")
  int doneCount = 0;
  @JsonKey(name: "icon_text")
  String iconText = "";

  DouList();

  factory DouList.fromJson(Map<String, dynamic> json) =>
      _$DouListFromJson(json);

  Map<String, dynamic> toJson() => _$DouListToJson(this);
}

@JsonSerializable()
class Owner {
  String? kind;
  String? name;
  String? url;
  String? uri;
  String? avatar;
  @JsonKey(name: "is_club")
  bool? isClub;
  String? type;
  String? id;
  String? uid;

  Owner();

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}
