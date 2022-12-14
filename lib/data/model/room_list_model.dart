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
  String? roomName;
  String? roomCode;
  String? roomType;
  num? roomCapacity;
  String? roomImage;
  num? roomPrice;
  num? roomIsReady;

  RoomList(
      {this.roomName,
      this.roomCode,
      this.roomType,
      this.roomCapacity,
      this.roomImage,
      this.roomPrice,
      this.roomIsReady});

  factory RoomList.fromJson(Map<String, dynamic> json) => RoomList(
      roomName: json['room_name'],
      roomCode: json['room_code'],
      roomType: json['type_room'],
      roomCapacity: json['capacity'],
      roomImage: json['room_image'],
      roomPrice: json['price'],
      roomIsReady: json['room_ready']);
}
