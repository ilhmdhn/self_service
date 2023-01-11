class VoucherDataResult {
  bool isLoading;
  bool? state;
  String? message;
  List<VoucherData>? voucherData;

  VoucherDataResult(
      {this.isLoading = true, this.state, this.message, this.voucherData});

  factory VoucherDataResult.fromJson(Map<String, dynamic> json) {
    if (json['state'] == false) {
      throw json['message'];
    }
    return VoucherDataResult(
      isLoading: false,
      state: json['state'],
      message: json['message'],
      voucherData: List<VoucherData>.from(
        (json['data'] as List).map((x) =>VoucherData.fromJson(x))
      )
    );
  }
}

class VoucherData {
  String? voucherCode;
  String? voucherName;
  String? voucherHour;
  String? voucherRoomPrice;
  String? voucherRoomDiscount;
  String? conditionRoomType;
  String? conditionHour;
  String? conditionRoomPrice;
  String? conditionItemQty;
  String? conditionItemPrice;
  String? voucherFnbPrice;
  String? voucherFnbDiscount;
  String? conditionFnbDiscount;
  String? voucherPrice;
  String? conditionPrice;
  String? voucherDiscount;
  String? conditionDiscount;

  VoucherData(
      {this.voucherCode,
      this.voucherName,
      this.voucherHour,
      this.voucherRoomPrice,
      this.voucherRoomDiscount,
      this.conditionRoomType,
      this.conditionHour,
      this.conditionRoomPrice,
      this.conditionItemQty,
      this.conditionItemPrice,
      this.voucherFnbPrice,
      this.voucherFnbDiscount,
      this.conditionFnbDiscount,
      this.voucherPrice,
      this.conditionPrice,
      this.voucherDiscount,
      this.conditionDiscount});

  factory VoucherData.fromJson(Map<String, dynamic> json) => VoucherData(
        voucherCode: json['voucher_code'],
        voucherName: json['voucher_name'],
        voucherHour: json['voucher_hour'],
        voucherRoomPrice: json['voucher_room_price'],
        voucherRoomDiscount: json['voucher_room_discount'],
        conditionRoomType: json['condition_room_type'],
        conditionHour: json['condition_hour'],
        conditionRoomPrice: json['condition_room_price'],
        conditionItemQty: json['condition_item_qty'],
        conditionItemPrice: json['condition_item_price'],
        voucherFnbPrice: json['voucher_fnb_price'],
        voucherFnbDiscount: json['voucher_fnb_discount'],
        conditionFnbDiscount: json['condition_fnb_discount'],
        voucherPrice: json['voucher_price'],
        conditionPrice: json['condition_price'],
        voucherDiscount: json['voucher_discount'],
        conditionDiscount: json['condition_discount'],
      );
}
