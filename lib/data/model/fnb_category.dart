class FnBCategoryResult {
  bool isLoading;
  bool? state;
  String? message;
  List<FnBCategoryData>? data;

  FnBCategoryResult(
      {this.isLoading = true, this.state, this.message, this.data});

  factory FnBCategoryResult.fromJson(Map<String, dynamic> json) {
    if (json['state'] == false) {
      throw json['message'];
    }
    return FnBCategoryResult(
        isLoading: false,
        state: true,
        message: json['message'],
        data: List<FnBCategoryData>.from(
            (json['data'] as List).map((x) => FnBCategoryData.fromJson(x))));
  }
}

class FnBCategoryData {
  String? categoryName;

  FnBCategoryData({this.categoryName});

  factory FnBCategoryData.fromJson(Map<String, dynamic> json) =>
      FnBCategoryData(categoryName: json['category']);
}
