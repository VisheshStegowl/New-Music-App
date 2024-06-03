class HomeDataModel {
  int? status;
  String? message;
  List<VideoData>? videoData;
  List<Data>? data;
  String? perPage;
  int? currentPage;
  int? lastPage;

  HomeDataModel(
      {this.status,
      this.message,
      this.videoData,
      this.data,
      this.perPage,
      this.currentPage,
      this.lastPage});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['video_data'] != null) {
      videoData = <VideoData>[];
      json['video_data'].forEach((v) {
        videoData!.add(new VideoData.fromJson(v));
      });
    }
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.videoData != null) {
      data['video_data'] = this.videoData!.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    return data;
  }
}

class VideoData {
  int? categoryId;
  String? categoryName;
  List<Assests>? assests;

  VideoData({this.categoryId, this.categoryName, this.assests});

  VideoData.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    if (json['assests'] != null) {
      assests = <Assests>[];
      json['assests'].forEach((v) {
        assests!.add(new Assests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    if (this.assests != null) {
      data['assests'] = this.assests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Assests {
  int? categoryId;
  int? videoId;
  int? menuId;
  String? videosImage;
  String? videosName;
  String? videosDescription;
  bool? imageStatus;
  String? createdAt;
  int? urlType;

  Assests(
      {this.categoryId,
      this.videoId,
      this.menuId,
      this.videosImage,
      this.videosName,
      this.videosDescription,
      this.imageStatus,
      this.createdAt,
      this.urlType});

  Assests.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    videoId = json['video_id'];
    menuId = json['menu_id'];
    videosImage = json['videos_image'];
    videosName = json['videos_name'];
    videosDescription = json['videos_description'];
    imageStatus = json['image_status'];
    createdAt = json['created_at'];
    urlType = json['url_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['video_id'] = this.videoId;
    data['menu_id'] = this.menuId;
    data['videos_image'] = this.videosImage;
    data['videos_name'] = this.videosName;
    data['videos_description'] = this.videosDescription;
    data['image_status'] = this.imageStatus;
    data['created_at'] = this.createdAt;
    data['url_type'] = this.urlType;
    return data;
  }
}

class Data {
  int? categoryId;
  String? type;
  String? name;
  List<AssestsSong>? assests;

  Data({this.categoryId, this.type, this.name, this.assests});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    type = json['type'];
    name = json['name'];
    if (json['assests'] != null) {
      assests = <AssestsSong>[];
      json['assests'].forEach((v) {
        assests!.add(new AssestsSong.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['type'] = this.type;
    data['name'] = this.name;
    if (this.assests != null) {
      data['assests'] = this.assests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssestsSong {
  var categoryId;
  int? menuId;
  int? songId;
  String? songName;
  String? songArtist;
  String? songImage;
  String? song;
  String? songDuration;
  String? categoryImage;
  String? categoryName;
  String? categoryFor;
  bool? imageStatus;
  int? likesCount;
  bool? likesStatus;
  int? favouritesCount;
  bool? favouritesStatus;
  int? totalPlayed;
  int? totalShared;
  String? createdAt;

  AssestsSong(
      {this.categoryId,
      this.categoryImage,
      this.categoryName,
      this.categoryFor,
      this.imageStatus,
      this.menuId,
      this.songId,
      this.songName,
      this.songArtist,
      this.songImage,
      this.song,
      this.songDuration,
      this.likesCount,
      this.likesStatus,
      this.favouritesCount,
      this.favouritesStatus,
      this.totalPlayed,
      this.totalShared,
      this.createdAt});

  AssestsSong.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    categoryFor = json['category_for'];
    imageStatus = json['image_status'];
    menuId = json['menu_id'];
    songId = json['song_id'];
    songName = json['song_name'];
    songArtist = json['song_artist'];
    songImage = json['song_image'];
    song = json['song'];
    songDuration = json['song_duration'];
    likesCount = json['likes_count'];
    likesStatus = json['likes_status'];
    favouritesCount = json['favourites_count'];
    favouritesStatus = json['favourites_status'];
    totalPlayed = json['total_played'];
    totalShared = json['total_shared'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['menu_id'] = this.menuId;
    data['song_id'] = this.songId;
    data['song_name'] = this.songName;
    data['song_artist'] = this.songArtist;
    data['song_image'] = this.songImage;
    data['song'] = this.song;
    data['category_name'] = this.categoryName;
    data['category_image'] = this.categoryImage;
    data['category_for'] = this.categoryFor;
    data['image_status'] = this.imageStatus;
    data['song_duration'] = this.songDuration;
    data['likes_count'] = this.likesCount;
    data['likes_status'] = this.likesStatus;
    data['favourites_count'] = this.favouritesCount;
    data['favourites_status'] = this.favouritesStatus;
    data['total_played'] = this.totalPlayed;
    data['total_shared'] = this.totalShared;
    data['created_at'] = this.createdAt;
    return data;
  }
}
