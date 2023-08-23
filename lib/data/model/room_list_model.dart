class RoomListResult {
  bool isLoading;
  bool? state;
  String? message;
  List<RoomList>? room;

  RoomListResult({this.isLoading = true, this.state, this.message, this.room});

  factory RoomListResult.fromJson(Map<String, dynamic> json) {
    if (json['state'] == false) {
      throw json['message'];
    }
    return RoomListResult(
        isLoading: false,
        state: json['state'],
        message: json['message'],
        room: List<RoomList>.from(
            (json['data'] as List).map((x) => RoomList.fromJson(x))));
  }
}

class RoomList {
  String? roomCode;
  String? roomImage;
  String? roomCategory;
  bool? roomReady;

  RoomList({this.roomCode, this.roomImage, this.roomCategory, this.roomReady});

  factory RoomList.fromJson(Map<String, dynamic> json) => RoomList(
      roomCode: json['room_code'],
      roomImage: json['room_image'],
      roomCategory: json['room_category'],
      roomReady: json['room_ready']);
}
