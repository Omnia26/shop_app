// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names, file_names, avoid_web_libraries_in_flutter, unused_import

class CategoriesModel {
  bool status;
   ListCategoriesData data;
  CategoriesModel({
   required this.status,
    required this.data,
  });
 factory CategoriesModel.fromJson(Map<String, dynamic> json) {
  return CategoriesModel(
    status : json['status'],
    data : ListCategoriesData.fromJson(json['data']),
    // data : json['data'].forEach((category){
    //   data.add(ListCategoriesData.fromJson(json['data']));
    // }),
    );
  }
}
class ListCategoriesData {
  int? currentPage;
  List<CategoriesData> lOCData = [];
  ListCategoriesData({
    required this.currentPage,
    required this.lOCData,
   });
  ListCategoriesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      lOCData.add(CategoriesData.fromJson(element));
    });
  }
}

class CategoriesData {
   int id;
   String image;
   String name;
   CategoriesData({
    required this.id,
    required this.image,
    required this.name,
   });
   factory
  CategoriesData.fromJson(Map<String, dynamic> json) {
    return CategoriesData(
      id : json['id'],
    name : json['name'],
    image : json['image'],
    );
  }
}
