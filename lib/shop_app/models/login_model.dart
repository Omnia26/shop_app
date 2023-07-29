// ignore_for_file: public_member_api_docs, sort_constructors_first
class ShopLoginModel {
  bool status;
  String message;
  UserData data;
  ShopLoginModel({
    required this.status,
    required this.message,
    required this.data,
  });
factory
  ShopLoginModel.fromJson(Map<String,dynamic> json)
  {
    return ShopLoginModel(
      status:json['status'],
    message:json['message'],
    data:UserData.fromJson(json['data']),
    );
  }
}
class UserData {
  int id;
  int points;
  int credit;
  String name;
  String email;
  String phone;
  String image;
  String token;
  UserData({
    required this.credit,
    required this.email,
    required this.id,
    required this.points,
    required this.name,
    required this.image,
    required this.phone,
    required this.token});
    factory
  UserData.fromJson(Map<String, dynamic> json)
  {
    return UserData(
      id : json['id'],
    name : json['name'],
    email : json['email'],
    phone : json['phone'],
    image: json['image'],
    points : json['points'],
    credit : json['credit'],
    token : json['token'],
    );
  }
}
  