class PromoRoomResult {
  bool isLoading;
  bool? state;
  String? message;
  List<PromoRoomData>? promo;

  PromoRoomResult(
      {this.isLoading = true, this.state, this.message, this.promo});

  factory PromoRoomResult.fromJson(Map<String, dynamic> json) {
    if (json['state'] == false) {
      throw json['message'];
    }
    return PromoRoomResult(
        isLoading: false,
        state: json['state'],
        message: json['message'],
        promo: List<PromoRoomData>.from(
            (json['data'] as List).map((x) => PromoRoomData.fromJson(x))));
  }
}

class PromoRoomData {
  String? promoRoom;
  int? hari;
  String? room;
  int? dateStart;
  String? timeStart;
  int? dateFinish;
  String? timeFinish;
  num? diskonPersen;
  num? diskonRp;

  PromoRoomData(
      {this.promoRoom,
      this.hari,
      this.room,
      this.dateStart,
      this.timeStart,
      this.dateFinish,
      this.timeFinish,
      this.diskonPersen,
      this.diskonRp});

  factory PromoRoomData.fromJson(Map<String, dynamic> json) => PromoRoomData(
    promoRoom: json['Promo_Room'],
    hari: json['Hari'],
    room: json['Room'],
    dateStart: json['Date_Start'],
    timeStart: json['Time_Start'],
    dateFinish: json['Date_Finish'],
    timeFinish: json['Time_Finish'],
    diskonPersen: json['Diskon_Persen'],
    diskonRp: json['Diskon_Rp']
  );
}
