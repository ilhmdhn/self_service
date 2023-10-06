class NewListRoomModel {
  bool isLoading;
  bool? state;
  String? message;
  ListRoomData? data;

  NewListRoomModel({
    this.isLoading = true,
    this.state,
    this.message,
    this.data,
  });

  factory NewListRoomModel.fromJson(Map<String, dynamic> json) {
    return NewListRoomModel(
      isLoading: false,
      state: json['state'],
      message: json['message'],
      data: json['data'] != null
          ? ListRoomData.fromJson(json['data'])
          : ListRoomData(),
    );
  }
}

class ListRoomData {
  List<RoomList> room;
  List<RoomCategory> category;

  ListRoomData({
    this.room = const [],
    this.category = const [],
  });

  factory ListRoomData.fromJson(Map<String, dynamic> json) {
    return ListRoomData(
      room: (json['room'] as List).map((x) => RoomList.fromJson(x)).toList(),
      category: (json['category'] as List)
          .map((x) => RoomCategory.fromJson(x))
          .toList(),
    );
  }
}

class RoomList {
  String? roomCode;
  String? roomImage;
  String? roomCategory;
  bool? roomReady;

  RoomList({
    this.roomCode,
    this.roomImage,
    this.roomCategory,
    this.roomReady,
  });

  factory RoomList.fromJson(Map<String, dynamic> json) => RoomList(
        roomCode: json['room_code'],
        roomImage: json['room_image'],
        roomCategory: json['room_category'],
        roomReady: json['room_ready'],
      );
}

class RoomCategory {
  String? roomCategoryName;
  String? roomCategoryTv;
  int? roomCategoryCapacity;
  bool? isToilet;
  num? price;

  RoomCategory({
    this.roomCategoryName,
    this.roomCategoryTv,
    this.roomCategoryCapacity,
    this.isToilet,
    this.price,
  });

  factory RoomCategory.fromJson(Map<String, dynamic> json) => RoomCategory(
        roomCategoryName: json['category_name'],
        roomCategoryTv: json['tv_detail'],
        roomCategoryCapacity: json['pax'],
        isToilet: json['toilet'],
        price: json['price'],
      );
}
