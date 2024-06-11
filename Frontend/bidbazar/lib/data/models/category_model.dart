class categoryModel {
  String? sId;
  String? title;
  String? description;

  categoryModel({this.sId, this.title, this.description});

  categoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
