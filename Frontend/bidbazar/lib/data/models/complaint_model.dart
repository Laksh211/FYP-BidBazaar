import 'package:bidbazar/data/models/user_model.dart';

class ComplainModel {
  String? sId;
  userModel? buyer;
  String? reason;
  String? explanation;

  ComplainModel({this.sId, this.buyer, this.reason, this.explanation});

  ComplainModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    buyer = json['buyer'] != null ?  userModel.fromJson(json['buyer']) : null;
    reason = json['reason'];
    explanation = json['explanation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.buyer != null) {
      data['buyer'] = this.buyer!.toJson();
    }
    data['reason'] = this.reason;
    data['explanation'] = this.explanation;
    return data;
  }
}