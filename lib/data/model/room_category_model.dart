class RoomCategoryResult {
  bool isLoading;
  bool? state;
  String? message;
  List<RoomCategory>? category = List.empty();

  RoomCategoryResult({
    this.isLoading = true,
    this.state,
    this.message,
    this.category,
  });

  factory RoomCategoryResult.fromJson(Map<String, dynamic> json) {
    if (json['state'] == false) {
      throw json['message'];
    }
    return RoomCategoryResult(
        isLoading: false,
        state: json['state'],
        message: json['message'],
        category: List<RoomCategory>.from(
            (json['data'] as List).map((x) => RoomCategory.fromJson(x))));
  }
}

class RoomCategory {
  String? roomCategoryName;
  String? roomCategoryTv;
  int? roomCategoryCapacity;
  bool? isToilet;
  num? price;

  RoomCategory(
      {this.roomCategoryName,
      this.roomCategoryTv,
      this.roomCategoryCapacity,
      this.isToilet,
      this.price});

  factory RoomCategory.fromJson(Map<String, dynamic> json) => RoomCategory(
        roomCategoryName: json['category_name'],
        roomCategoryTv: json['tv_detail'],
        roomCategoryCapacity: json['pax'],
        isToilet: json['toilet'],
        price: json['price'],
      );
}
