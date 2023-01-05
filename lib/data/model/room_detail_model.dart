class RoomDetailResult {
  bool isLoading;
  bool? state;
  String? message;
  RoomData? data;

  RoomDetailResult({
    this.isLoading = true,
    this.state,
    this.message,
    this.data,
  });

  factory RoomDetailResult.fromJson(Map<String, dynamic> json) {
    if (json['state'] == false) {
      throw json['message'];
    }
    return RoomDetailResult(
        isLoading: false,
        state: json['state'],
        message: json['message'],
        data: RoomData.fromJson(json['data']));
  }
}

class RoomData {
  RoomDetail? roomDetail;
  List<RoomGallery>? roomGallery = List.empty();

  RoomData({this.roomDetail, this.roomGallery});
  factory RoomData.fromJson(Map<String, dynamic> json) => RoomData(
      roomDetail: RoomDetail.fromJson(json['room_detail']),
      roomGallery: List<RoomGallery>.from(
          (json['room_gallery'] as List).map((x) => RoomGallery.fromJson(x))));
}

class RoomDetail {
  String? roomName;
  String? roomCode;
  String? roomType;
  num? roomCapacity;
  num? roomPrice;
  num? roomIsReady;

  RoomDetail(
      {this.roomName,
      this.roomCode,
      this.roomType,
      this.roomCapacity,
      this.roomPrice,
      this.roomIsReady});

  factory RoomDetail.fromJson(Map<String, dynamic> json) => RoomDetail(
      roomName: json['room_name'],
      roomCode: json['room_code'],
      roomType: json['type_room'],
      roomCapacity: json['capacity'],
      roomPrice: json['price'],
      roomIsReady: json['room_ready']);
}

class RoomGallery {
  String? imageUrl;

  RoomGallery({this.imageUrl});

  factory RoomGallery.fromJson(Map<String, dynamic> json) =>
      RoomGallery(imageUrl: json['image_url']);
}
