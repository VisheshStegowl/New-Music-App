import 'package:new_music_app/Utils/Models/HomeDataModel.dart';

class CategoriesSongDataModel {
  int? status;
  String? message;
  List<AssestsSong>? data;
  String? perPage;
  int? currentPage;
  int? lastPage;

  CategoriesSongDataModel(
      {this.status,
      this.message,
      this.data,
      this.perPage,
      this.currentPage,
      this.lastPage});

  CategoriesSongDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AssestsSong>[];
      json['data'].forEach((v) {
        data!.add(new AssestsSong.fromJson(v));
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    return data;
  }
}

class Data {
  int? songId;
  String? songName;
  String? songArtist;
  String? songImage;
  String? song;
  String? songDuration;
  int? likesCount;
  bool? likesStatus;
  int? favouritesCount;
  bool? favouritesStatus;
  int? totalPlayed;
  int? totalShared;
  String? createdAt;

  Data(
      {this.songId,
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

  Data.fromJson(Map<String, dynamic> json) {
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
    data['song_id'] = this.songId;
    data['song_name'] = this.songName;
    data['song_artist'] = this.songArtist;
    data['song_image'] = this.songImage;
    data['song'] = this.song;
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
