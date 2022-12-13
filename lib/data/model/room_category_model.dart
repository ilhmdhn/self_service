class RoomCategoryResult {
  bool? state = false;
  String? message = '';
  List<RoomCategory>? category = List.empty();

  RoomCategoryResult({
    this.state,
    this.message,
    this.category,
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
    this.roomCategoryName,
    this.roomCategoryCode,
    this.roomCategoryCapacity,
    this.roomCategoryImage,
  });

  factory RoomCategory.fromJson(Map<String, dynamic> json) => RoomCategory(
        roomCategoryName: json['category_name'],
        roomCategoryCode: json['category_code'],
        roomCategoryCapacity: json['capacity'],
        roomCategoryImage: json['category_image'],
      );
}
