class RoomCategoryResult {
  bool? state;
  String? message;
  List<RoomCategory>? category;

  RoomCategoryResult({
    required this.state,
    required this.message,
    required this.category,
  });

  factory RoomCategoryResult.fromJson(Map<String, dynamic> json) =>
      RoomCategoryResult(
          state: json['state'],
          message: json['message'],
          category: List<RoomCategory>.from(
              (json['data'] as List).map((x) => RoomCategory.fromJson(x))));
}

class RoomCategory {
  String? roomCategoryName;
  String? roomCategoryCode;
  int? roomCategoryCapacity;
  String? roomCategoryImage;

  RoomCategory({
    required this.roomCategoryName,
    required this.roomCategoryCode,
    required this.roomCategoryCapacity,
    required this.roomCategoryImage,
  });

  factory RoomCategory.fromJson(Map<String, dynamic> json) => RoomCategory(
        roomCategoryName: json['category_name'],
        roomCategoryCode: json['category_code'],
        roomCategoryCapacity: json['capacity'],
        roomCategoryImage: json['category_image'],
      );
}
