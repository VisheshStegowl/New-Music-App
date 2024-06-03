class VideoCategoryDataModel {
  int? status;
  String? message;
  List<Data>? data;
  int? perPage;
  int? currentPage;
  int? lastPage;

  VideoCategoryDataModel(
      {this.status,
      this.message,
      this.data,
      this.perPage,
      this.currentPage,
      this.lastPage});

  VideoCategoryDataModel.fromJson(Map<String, dynamic> json) {
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
  int? categoryId;
  int? menuId;
  String? parentCategoryName;
  String? categoryImage;
  String? categoryName;
  String? categoryFor;
  bool? imageStatus;
  String? createdAt;

  Data(
      {this.categoryId,
      this.menuId,
      this.parentCategoryName,
      this.categoryImage,
      this.categoryName,
      this.categoryFor,
      this.imageStatus,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    menuId = json['menu_id'];
    parentCategoryName = json['parent_category_name'];
    categoryImage = json['category_image'];
    categoryName = json['category_name'];
    categoryFor = json['category_for'];
    imageStatus = json['image_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['menu_id'] = this.menuId;
    data['parent_category_name'] = this.parentCategoryName;
    data['category_image'] = this.categoryImage;
    data['category_name'] = this.categoryName;
    data['category_for'] = this.categoryFor;
    data['image_status'] = this.imageStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}
