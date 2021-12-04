// class CategoryModel {
//   CategoryModel({
//     required this.status,
//
//     required this.data,
//   });
//   late final bool status;
//
//   late final CategoryModelData data;
//
//   CategoryModel.fromJson(Map<String, dynamic> json){
//     status = json['status'];
//
//     data = CategoryModelData.fromJson(json['data']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//
//     _data['data'] = data.toJson();
//     return _data;
//   }
// }
//
// class CategoryModelData {
//   CategoryModelData({
//     required this.currentPage,
//     required this.data,
//     required this.firstPageUrl,
//     required this.from,
//     required this.lastPage,
//     required this.lastPageUrl,
//     this.nextPageUrl,
//     required this.path,
//     required this.perPage,
//     this.prevPageUrl,
//     required this.to,
//     required this.total,
//   });
//   late final int currentPage;
//   late final List<CategoryModelData> data;
//   late final String firstPageUrl;
//   late final int from;
//   late final int lastPage;
//   late final String lastPageUrl;
//   late final Null nextPageUrl;
//   late final String path;
//   late final int perPage;
//   late final Null prevPageUrl;
//   late final int to;
//   late final int total;
//
//   CategoryModelData.fromJson(Map<String, dynamic> json){
//     currentPage = json['current_page'];
//     data = List.from(json['data']).map((e)=>CategoryModelData.fromJson(e)).toList();
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     nextPageUrl = null;
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = null;
//     to = json['to'];
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['current_page'] = currentPage;
//     _data['data'] = data.map((e)=>e.toJson()).toList();
//     _data['first_page_url'] = firstPageUrl;
//     _data['from'] = from;
//     _data['last_page'] = lastPage;
//     _data['last_page_url'] = lastPageUrl;
//     _data['next_page_url'] = nextPageUrl;
//     _data['path'] = path;
//     _data['per_page'] = perPage;
//     _data['prev_page_url'] = prevPageUrl;
//     _data['to'] = to;
//     _data['total'] = total;
//     return _data;
//   }
// }
class CategoriesModel
{
  bool status;
  CategoriesDataModel data;

  CategoriesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel
{
  int currentPage;
  final List<DataModel> data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json,)
  {
    currentPage = json['current_page'];
    json['data'].forEach((element)
    {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel
{
  int id;
  String name;
  String image;

  DataModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}