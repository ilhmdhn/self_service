class FnBCategoryResult {
  bool? state;
  String? message;
  List<FnBCategory>? category;

  FnBCategoryResult({this.state, this.message, this.category});

  factory FnBCategoryResult.fromJson(Map<String, dynamic> json) =>
      FnBCategoryResult(
          state: json['state'],
          message: json['message'],
          category: List<FnBCategory>.from(
              (json['data'] as List).map((x) => FnBCategory.fromJson(x))));
}

class FnBCategory {
  int? fnbCategoryCode;
  String? fnbCategoryName;
  String? fnbCategoryImage;

  FnBCategory(
      {this.fnbCategoryCode, this.fnbCategoryName, this.fnbCategoryImage});

  factory FnBCategory.fromJson(Map<String, dynamic> json) => FnBCategory(
        fnbCategoryCode: json['code'],
        fnbCategoryName: json['category_name'],
        fnbCategoryImage: json['image_url'],
      );
}
