class GeneralErrorModel {
  // bool? error;
  String? message;
  int? statusCode;

  GeneralErrorModel({this.message});

  GeneralErrorModel.fromJson(Map<String, dynamic> json) {
    // error = json['error'];
    // if (json["message"] is List) {
    message = json['message'];
    statusCode = json['status'];
    // } else {
    //   message = json['message'] ?? json["msg"] ?? "Something went wrong!";
    // }
  }
}
