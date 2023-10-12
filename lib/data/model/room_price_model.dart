class RoomPriceResult {
  bool isLoading;
  bool? state;
  String? message;
  RoomPriceData? data;

  RoomPriceResult({this.isLoading = true, this.state, this.message, this.data});

  factory RoomPriceResult.fromJson(Map<String, dynamic> json) {
    if (json['state'] == false) {
      throw json['message'];
    }
    return RoomPriceResult(
      isLoading: false,
      state: json['state'],
      message: json['message'],
      data: RoomPriceData.fromJson(json['data']),
    );
  }
}

class RoomPriceData {
  num? roomPrice;
  num? serviceRoom;
  num? taxRoom;
  num? priceTotal;
  num? servicePercent;
  num? taxPercent;
  List<RoomPriceDetail>? detail;

  RoomPriceData({
    this.roomPrice,
    this.serviceRoom,
    this.taxRoom,
    this.priceTotal,
    this.servicePercent,
    this.taxPercent,
    this.detail = const [],
  });

  factory RoomPriceData.fromJson(Map<String, dynamic> json) {
    return RoomPriceData(
      roomPrice: json['room'].toDouble(),
      serviceRoom: json['service_room'].toDouble(),
      taxRoom: json['tax_room'].toDouble(),
      priceTotal: json['price_total'].toDouble(),
      detail: List<RoomPriceDetail>.from(
          (json['detail'] as List).map((x) => RoomPriceDetail.fromJson(x))),
    );
  }
}

class RoomPriceDetail {
  String? room;
  int? day;
  String? startTime;
  String? finishTime;
  num? price;
  double? pricePerMinute;
  int? usedMinute;
  num? roomTotal;
  num? priceTotal;

  RoomPriceDetail({
    this.room,
    this.day,
    this.startTime,
    this.finishTime,
    this.price,
    this.pricePerMinute,
    this.usedMinute,
    this.roomTotal,
    this.priceTotal,
  });

  factory RoomPriceDetail.fromJson(Map<String, dynamic> json) {
    return RoomPriceDetail(
      room: json['room'],
      day: json['day'],
      startTime: json['start_time'],
      finishTime: json['finish_time'],
      price: json['price'],
      pricePerMinute: json['price_per_minute'].toDouble(),
      usedMinute: json['used_minute'],
      roomTotal: json['room_total'],
      priceTotal: json['price_total'],
    );
  }
}
