// ignore_for_file: file_names

class SearchModel {
  bool status;
  Dataa datae;

  SearchModel({required this.status, required this.datae});
  factory
  SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      status : json['status'],
    datae : Dataa.fromJson(json['data']),
    );
  }
}

class Dataa {
  int currentPage;
  List<Productt>? datas;
  Dataa({
    required this.currentPage,
    this.datas,
  });
  factory Dataa.fromJson(Map<String, dynamic> json) {
    return Dataa(
      currentPage: json['current_page'],
      datas: List<Productt>.from(
          json['data'].map((datas) => Productt.fromJson(datas))),
      //  json['data'].forEach((element) {
      //   data!.add(DataVersion2.fromJson(element));
      // }),دي مش بتنفع هنا عشان؟؟؟؟؟؟؟؟؟؟؟
    );
  }
}

class Productt {
  int id;
  double price;
  String image;
  String name;
  String description;

  Productt({
    required this.id,
    required this.price,
    required this.image,
    required this.name,
    required this.description,
  });
  factory Productt.fromJson(Map<String, dynamic> json) {
    return Productt(
      id: json['id'],
      price: json['price'].toDouble(),///
      image: json['image'],
      name: json['name'],
      description: json['description'],
    );
  }
}
