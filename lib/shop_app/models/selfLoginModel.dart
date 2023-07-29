// ignore_for_file: empty_constructor_bodies, file_names

class SelfShopLoginModel {
  bool? status;
  String? message;
  UserData? data;
  SelfShopLoginModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data']!=null ? UserData.fromJson(json['data']):null;
  }
}
class UserData {
  int? id;
  int? points;
  int? credit;
  String? name;
  String? email;
  String? image;
  String? token;
  String? phone;

UserData.fromJson(Map<String,dynamic> json){
  id=json['id'];
  points=json['points'];
  credit=json['credit'];
  name=json['name'];
  email=json['email'];
  image=json['image'];
  token=json['token'];
  phone=json['phone'];

}
}