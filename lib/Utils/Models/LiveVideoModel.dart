class LiveVideoModel {
  int? status;
  String? message;
  List<Data>? data;
  int? planstatus;
  int? perPage;
  int? currentPage;
  int? lastPage;

  LiveVideoModel(
      {this.status,
      this.message,
      this.data,
      this.planstatus,
      this.perPage,
      this.currentPage,
      this.lastPage});

  LiveVideoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    planstatus = json['planstatus'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['planstatus'] = this.planstatus;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    return data;
  }
}

class Data {
  String? categoryitemsId;
  String? menuId;
  String? categoryId;
  int? videosId;
  String? videosImage;
  String? videosName;
  String? videosDescription;
  String? videosLink;
  String? livetvStatus;
  bool? videoLikeStatus;
  int? videoLikeCount;
  bool? popupVideoStatus;
  bool? favouritesStatus;
  int? favouritesCount;
  String? date;
  String? time;
  int? urlType;

  Data(
      {this.categoryitemsId,
      this.menuId,
      this.categoryId,
      this.videosId,
      this.videosImage,
      this.videosName,
      this.videosDescription,
      this.videosLink,
      this.livetvStatus,
      this.videoLikeStatus,
      this.videoLikeCount,
      this.popupVideoStatus,
      this.favouritesStatus,
      this.favouritesCount,
      this.date,
      this.time,
      this.urlType});

  Data.fromJson(Map<String, dynamic> json) {
    categoryitemsId = json['categoryitems_id'];
    menuId = json['menu_id'];
    categoryId = json['category_id'];
    videosId = json['videos_id'];
    videosImage = json['videos_image'];
    videosName = json['videos_name'];
    videosDescription = json['videos_description'];
    videosLink = json['videos_link'];
    livetvStatus = json['livetv_status'];
    videoLikeStatus = json['video_like_status'];
    videoLikeCount = json['video_like_count'];
    popupVideoStatus = json['popup_video_status'];
    favouritesStatus = json['favourites_status'];
    favouritesCount = json['favourites_count'];
    date = json['date'];
    time = json['time'];
    urlType = json['url_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryitems_id'] = this.categoryitemsId;
    data['menu_id'] = this.menuId;
    data['category_id'] = this.categoryId;
    data['videos_id'] = this.videosId;
    data['videos_image'] = this.videosImage;
    data['videos_name'] = this.videosName;
    data['videos_description'] = this.videosDescription;
    data['videos_link'] = this.videosLink;
    data['livetv_status'] = this.livetvStatus;
    data['video_like_status'] = this.videoLikeStatus;
    data['video_like_count'] = this.videoLikeCount;
    data['popup_video_status'] = this.popupVideoStatus;
    data['favourites_status'] = this.favouritesStatus;
    data['favourites_count'] = this.favouritesCount;
    data['date'] = this.date;
    data['time'] = this.time;
    data['url_type'] = this.urlType;
    return data;
  }
}
