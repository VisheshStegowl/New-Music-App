class MerchandiseDataModel {
  int? status;
  String? message;
  String? link;
  String? url;

  MerchandiseDataModel({this.status, this.message, this.link, this.url});

  MerchandiseDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    link = json['link'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['link'] = this.link;
    data['url'] = this.url;
    return data;
  }
}
