class AllCategoryResponse {
  String? message;
  int? statusCode;
  List<AllCategoryData>? data;

  AllCategoryResponse({this.message, this.statusCode, this.data});

  AllCategoryResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <AllCategoryData>[];
      json['data'].forEach((v) {
        data!.add(new AllCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllCategoryData {
  int? id;
  String? title;
  String? icon;
  String? color;

  AllCategoryData({this.id, this.title, this.icon, this.color});

  AllCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    icon = json['icon'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['color'] = this.color;
    return data;
  }
}
