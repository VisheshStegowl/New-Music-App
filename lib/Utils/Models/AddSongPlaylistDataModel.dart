class AddSongPlaylistDataModel {
  int? status;
  String? message;
  int? playlistsongsId;
  int? playlistId;
  int? songId;

  AddSongPlaylistDataModel(
      {this.status,
      this.message,
      this.playlistsongsId,
      this.playlistId,
      this.songId});

  AddSongPlaylistDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    playlistsongsId = json['playlistsongs_id'];
    playlistId = json['playlist_id'];
    songId = json['song_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['playlistsongs_id'] = this.playlistsongsId;
    data['playlist_id'] = this.playlistId;
    data['song_id'] = this.songId;
    return data;
  }
}
