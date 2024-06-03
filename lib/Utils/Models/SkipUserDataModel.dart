class SkipUserDataModel {
  int? status;
  String? message;
  int? userId;
  String? fcmId;
  String? device;
  String? token;

  SkipUserDataModel(
      {this.status,
      this.message,
      this.userId,
      this.fcmId,
      this.device,
      this.token});

  SkipUserDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userId = json['user_id'];
    fcmId = json['fcm_id'];
    device = json['device'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['fcm_id'] = this.fcmId;
    data['device'] = this.device;
    data['token'] = this.token;
    return data;
  }
}
