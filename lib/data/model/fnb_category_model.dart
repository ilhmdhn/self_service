// class FnBCategoryResult {
//   bool isLoading;
//   bool? state;
//   String? message;
//   List<FnBCategory>? data;

//   FnBCategoryResult(
//       {this.isLoading = true, this.state, this.message, this.data});

//   factory FnBCategoryResult.fromJson(Map<String, dynamic> json) {
//     if (json['state'] == false) {
//       throw json['message'];
//     }
//     return FnBCategoryResult(
//         isLoading: false,
//         state: json['state'],
//         message: json['message'],
//         data: List<FnBCategory>.from(
//             (json['data'] as List).map((x) => FnBCategory.fromJson(x))));
//   }
// }

// class FnBCategory {
//   int? fnbCategoryCode;
//   String? fnbCategoryName;
//   String? fnbCategoryImage;

//   FnBCategory(
//       {this.fnbCategoryCode, this.fnbCategoryName, this.fnbCategoryImage});

//   factory FnBCategory.fromJson(Map<String, dynamic> json) => FnBCategory(
//         fnbCategoryCode: json['code'],
//         fnbCategoryName: json['category_name'],
//         fnbCategoryImage: json['image_url'],
//       );
// }
