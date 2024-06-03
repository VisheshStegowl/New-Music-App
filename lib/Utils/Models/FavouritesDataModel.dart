class FavouritesDataModel {
  int? status;
  String? message;
  bool? favouritesStatus;
  int? favouritesCount;

  FavouritesDataModel(
      {this.status, this.message, this.favouritesStatus, this.favouritesCount});

  FavouritesDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    favouritesStatus = json['favourites_status'];
    favouritesCount = json['favourites_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['favourites_status'] = this.favouritesStatus;
    data['favourites_count'] = this.favouritesCount;
    return data;
  }
}
