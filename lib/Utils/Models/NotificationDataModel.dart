class NotificationDataModel {
  int? status;
  String? message;
  List<Data>? data;
  int? perPage;
  int? currentPage;
  int? lastPage;

  NotificationDataModel(
      {this.status,
      this.message,
      this.data,
      this.perPage,
      this.currentPage,
      this.lastPage});

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
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
  int? notificationsId;
  String? title;
  String? message;
  String? createdAt;

  Data({this.notificationsId, this.title, this.message, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    notificationsId = json['notifications_id'];
    title = json['title'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notifications_id'] = this.notificationsId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    return data;
  }
}
