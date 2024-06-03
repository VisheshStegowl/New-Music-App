class PlayListDataModel {
  int? status;
  String? message;
  List<Data>? data;

  PlayListDataModel({this.status, this.message, this.data});

  PlayListDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? playlistId;
  int? userId;
  String? playlistName;
  String? createdAt;

  Data({this.playlistId, this.userId, this.playlistName, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    playlistId = json['playlist_id'];
    userId = json['user_id'];
    playlistName = json['playlist_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playlist_id'] = this.playlistId;
    data['user_id'] = this.userId;
    data['playlist_name'] = this.playlistName;
    data['created_at'] = this.createdAt;
    return data;
  }
}
