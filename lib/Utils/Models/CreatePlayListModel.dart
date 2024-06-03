class CreatePlayListModel {
  int? status;
  String? message;
  int? playlistId;
  int? userId;
  String? playlistName;

  CreatePlayListModel(
      {this.status,
      this.message,
      this.playlistId,
      this.userId,
      this.playlistName});

  CreatePlayListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    playlistId = json['playlist_id'];
    userId = json['user_id'];
    playlistName = json['playlist_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['playlist_id'] = this.playlistId;
    data['user_id'] = this.userId;
    data['playlist_name'] = this.playlistName;
    return data;
  }
}
