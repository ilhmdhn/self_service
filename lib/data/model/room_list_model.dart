class RoomListResult {
  bool state = false;
  String message = '';
  List<RoomList> room = List.empty();

  RoomListResult(
      {required this.state, required this.message, required this.room});

  factory RoomListResult.fromJson(Map<String, dynamic> json) => RoomListResult(
      state: json['state'],
      message: json['message'],
      room: List<RoomList>.from(
          (json['data'] as List).map((x) => RoomList.fromJson(x))));
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
      {required this.roomName,
      required this.roomCode,
      required this.roomType,
      required this.roomCapacity,
      required this.roomImage,
      required this.roomPrice,
      required this.roomIsReady});

  factory RoomList.fromJson(Map<String, dynamic> json) => RoomList(
      roomName: json['room_name'],
      roomCode: json['room_code'],
      roomType: json['type_room'],
      roomCapacity: json['capacity'],
      roomImage: json['room_image'],
      roomPrice: json['price'],
      roomIsReady: json['room_ready']);
}
