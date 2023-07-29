// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names

import 'package:api_projects/shop_app/models/homeModel.dart';

class ChangeFavouritesModel {
  bool status;
  String message;
  Dataa data;///
  ChangeFavouritesModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory
  ChangeFavouritesModel.fromJson(Map<String, dynamic> json) {
    return ChangeFavouritesModel(
      status : json['status'],
      message : json['message'],
      data:Dataa.fromJson(json['data']),
    );
  }
}
class Dataa {
 int id;
  Products product; //محطناش تفاصيل كلاس البرودكت عشان مش محتاجينها
  Dataa({
    required this.id,
    required this.product,
  });
  factory
  Dataa.fromJson(Map<String,dynamic>json){
    return Dataa(
      id:json['id'],
   product : Products.fromJson(json['product']),
  );
}
}