class SignInModel {
  int? status;
  String? message;
  List<Data>? data;
  String? token;

  SignInModel({this.status, this.message, this.data, this.token});

  SignInModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['token'] = this.token;
    return data;
  }
}

class Data {
  int? userId;
  String? image;
  String? name;
  String? username;
  String? email;
  String? phone;
  String? fcmId;
  String? device;

  Data(
      {this.userId,
      this.image,
      this.name,
      this.username,
      this.email,
      this.phone,
      this.fcmId,
      this.device});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    image = json['image'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    fcmId = json['fcm_id'];
    device = json['device'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['fcm_id'] = this.fcmId;
    data['device'] = this.device;
    return data;
  }
}
