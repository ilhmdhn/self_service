class RoomDetailResult {
  bool isLoading;
  bool? state;
  String? message;
  RoomDetail? data;

  RoomDetailResult(
      {this.isLoading = true, this.state, this.message, this.data});

  factory RoomDetailResult.fromJson(Map<String, dynamic> json) {
    if (json['state'] == false) {
      throw json['message'];
    }
    return RoomDetailResult(
        isLoading: false,
        state: json['state'],
        message: json['message'],
        data: RoomDetail.fromJson(json['data']));
  }
}

class RoomDetail {
  String? roomCode;
  String? roomCategory;
  String? roomTvDetail;
  int? roomPax;
  bool? roomToilet;
  bool? roomReady;
  String? roomPrice;
  List<String>? roomImageList;

  RoomDetail(
      {this.roomCode,
      this.roomCategory,
      this.roomTvDetail,
      this.roomPax,
      this.roomToilet,
      this.roomReady,
      this.roomPrice,
      this.roomImageList});

  factory RoomDetail.fromJson(Map<String, dynamic> json) => RoomDetail(
      roomCode: json['room_code'],
      roomCategory: json['room_category'],
      roomTvDetail: json['tv_detail'],
      roomPax: json['pax'],
      roomToilet: json['toilet'],
      roomReady: json['room_ready'],
      roomPrice: json['price'],
      roomImageList: List<String>.from(json['room_galery']));
}
