class SlipCheckinResult {
  bool isLoading;
  bool? state;
  String? message;
  SlipCheckin? slipCheckinData;

  SlipCheckinResult({
    this.isLoading = true,
    this.state,
    this.message,
    this.slipCheckinData,
  });

  factory SlipCheckinResult.fromJson(Map<String, dynamic> json) {
    if (json['state'] == true) {
      throw json['message'];
    }
    return SlipCheckinResult(
        isLoading: false,
        state: json['state'],
        message: json['message'],
        slipCheckinData: SlipCheckin.fromJson(json['data']));
  }
}

class SlipCheckin {
  String? reservationCode;
  String? memberCode;
  String? memberName;
  String? reservationDate;
  String? reservationTime;
  String? roomType;
  String? reservationDuration;
  int? roomPrice;
  int? promo;
  int? roomTotalPrice;
  int? service;
  int? tax;
  int? downPayment;
  int? total;

  SlipCheckin(
      {this.reservationCode,
      this.memberCode,
      this.memberName,
      this.reservationDate,
      this.reservationTime,
      this.roomType,
      this.reservationDuration,
      this.roomPrice,
      this.promo,
      this.roomTotalPrice,
      this.service,
      this.tax,
      this.downPayment,
      this.total});

  factory SlipCheckin.fromJson(Map<String, dynamic> json) => SlipCheckin(
      reservationCode: json['reservation_code'],
      memberCode: json['member_code'],
      memberName: json['member_name'],
      reservationDate: json['reservation_date'],
      reservationTime: json['reservation_time'],
      roomType: json['room_type'],
      reservationDuration: json['reservation_duration'],
      roomPrice: json['room_price'],
      promo: json['promo'],
      roomTotalPrice: json['room_total_price'],
      service: json['service'],
      tax: json['tax'],
      downPayment: json['down_payment'],
      total: json['total']);
}
