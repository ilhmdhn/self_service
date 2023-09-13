class FnBResultModel {
  bool isLoading;
  bool? state;
  String? message;
  List<FnB>? data = List.empty();

  FnBResultModel({this.isLoading = true, this.state, this.message, this.data});

  factory FnBResultModel.fromJson(Map<String, dynamic> json) {
    if (json['state'] != true) {
      throw json['message'];
    }
    return FnBResultModel(
        isLoading: false,
        state: true,
        message: json['message'],
        data:
            List<FnB>.from((json['data'] as List).map((x) => FnB.fromJson(x))));
  }
}

class FnB {
  String? fnbName;
  String? categoryFnb;
  String? idGlobal;
  String? image;
  num? priceFnb;

  FnB({
    this.fnbName,
    this.categoryFnb,
    this.idGlobal,
    this.image,
    this.priceFnb,
  });

  factory FnB.fromJson(Map<String, dynamic> json) => FnB(
        fnbName: json['fnb_name'],
        categoryFnb: json['category_name'],
        idGlobal: json['id_global'],
        image: json['image'],
        priceFnb: json['price'],
      );
}
