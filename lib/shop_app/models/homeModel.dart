// ignore_for_file: public_member_api_docs, sort_constructors_first, empty_constructor_bodies, file_names
class HomeModel {
  bool status;
  BPModel data;
  HomeModel({
    required this.status,
    required this.data,
  });
  factory
  HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      status : json['status'],
    data : BPModel.fromJson(json['data']),//?????????????????????????
    );
  }
}

class BPModel {
  List<Banners> banners = [];
  List<Products> products = [];
  BPModel({
    required this.banners,
    required this.products,
  });
  BPModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(Banners.fromJson(element));
    });
    json['products'].forEach((element2) {
      products.add(Products.fromJson(element2));
    });
  }
}
class Banners {
  int id;
  String image;
  Banners({
    required this.id,
    required this.image,
  });
  factory
  Banners.fromJson(Map<String, dynamic> json) {
    return Banners(
      id : json['id'],
    image : json['image'],
     );
  }
}

class Products {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  bool inFavourite;
  bool incard;
  Products({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
     this.inFavourite=false,//
     this.incard=false,//
  });
  factory
  Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id : json['id'],
    price : json['price'],
    oldPrice : json['old_price'],
    discount : json['discount'],
    image : json['image'],
    name : json['name'],
    inFavourite : json['in_favorites'],
    incard : json['in_cart'],
    );
  }
}
