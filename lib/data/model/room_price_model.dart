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
  num roomPrice;
  num roomPromo;
  num roomVoucher;
  num serviceRoom;
  num taxRoom;
  num totalAll;
  
  num servicePercent;
  num taxPercent;
  List<RoomPriceDetail>? detail;

  RoomPriceData({
    this.roomPrice = 0,
    this.roomPromo = 0,
    this.roomVoucher = 0,
    this.serviceRoom = 0,
    this.taxRoom = 0,
    this.totalAll = 0,
    this.servicePercent = 0,
    this.taxPercent = 0,
    this.detail = const [],
  });

  factory RoomPriceData.fromJson(Map<String, dynamic> json) {
    return RoomPriceData(
      roomPrice: json['room'].toDouble(),
      serviceRoom: json['service_room'].toDouble(),
      taxRoom: json['tax_room'].toDouble(),
      totalAll: json['price_total'].toDouble(),
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
  int? vcrMinute;
  int? reduceDuration;
  int? overpax;
  num? overpaxPrice;
  int? promoPercent;
  num? roomTotal;
  num? promoTotal;
  num? priceTotal;
  int? isExtend;

  RoomPriceDetail({
    this.room,
    this.day,
    this.startTime,
    this.finishTime,
    this.price,
    this.pricePerMinute,
    this.usedMinute,
    this.vcrMinute,
    this.reduceDuration,
    this.overpax,
    this.overpaxPrice,
    this.promoPercent,
    this.roomTotal,
    this.promoTotal,
    this.priceTotal,
    this.isExtend,
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
        vcrMinute: json['vcr_minute'],
        reduceDuration: json['reduce_duration'],
        overpax: json['overpax'],
        overpaxPrice: json['overpax_price'],
        promoPercent: json['promo_percent'],
        roomTotal: json['room_total'],
        promoTotal: json['promo_total'],
        priceTotal: json['price_total'],
        isExtend: json['is_extend']);
  }
}
