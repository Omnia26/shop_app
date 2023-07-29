// ignore_for_file: file_names

class FavouriteModel {
  bool? status;
  Data? data;

  FavouriteModel({this.status, this.data});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  int currentPage;
  List<DataVersion2>? data;
  Data({
    required this.currentPage,
    this.data,
  });
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      currentPage: json['current_page'],
      data: List<DataVersion2>.from(
          json['data'].map((data) => DataVersion2.fromJson(data))),
      //  json['data'].forEach((element) {
      //   data!.add(DataVersion2.fromJson(element));
      // }),
    );
  }
}

class DataVersion2 {
  int id;
  Product product;

  DataVersion2({required this.id, required this.product});
  factory DataVersion2.fromJson(Map<String, dynamic> json) {
    return DataVersion2(
      id: json['id'],
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  int id;
  double price;
  double oldPrice;
  int discount;
  String image;
  String name;
  String description;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      description: json['description'],
      price: json['price'].toDouble(),///
      oldPrice: json['old_price'].toDouble(),///
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
    );
  }
}
