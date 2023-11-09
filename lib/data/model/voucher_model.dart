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
            (json['data'] as List).map((x) => VoucherData.fromJson(x))));
  }
}

class VoucherData {
  String? voucherCode;
  String? voucherName;
  String? description;
  String? image;

  num? voucherFnbDiscount;
  num? voucherFnbPrice;
  String? itemCode;
  int? qty;

  int? voucherHour;
  num? voucherRoomPrice;
  num? voucherRoomDiscount;

  num? voucherPrice;
  num? voucherDiscount;

  num? conditionPrice;
  int? conditionHour;
  num? conditionRoomPrice;
  num? conditionItemPrice;
  int? conditionItemQty;
  int? conditionFnbPrice;
  String? conditionRoomType;

  String? conditionDiscount;
  String? conditionFnbDiscount;

  num? finalValue;

  VoucherData(
      {this.voucherCode,
      this.voucherName,
      this.description,
      this.image,
      this.voucherHour,
      this.qty,
      this.voucherRoomPrice,
      this.conditionFnbPrice,
      this.voucherRoomDiscount,
      this.conditionRoomType,
      this.conditionHour,
      this.conditionRoomPrice,
      this.conditionItemQty,
      this.itemCode,
      this.conditionItemPrice,
      this.voucherFnbPrice,
      this.voucherFnbDiscount,
      this.conditionFnbDiscount,
      this.voucherPrice,
      this.conditionPrice,
      this.voucherDiscount,
      this.finalValue,
      this.conditionDiscount});

  factory VoucherData.fromJson(Map<String, dynamic> json) => VoucherData(
      voucherCode: json['voucher_code'],
      voucherName: json['voucher_name'],
      description: json['description'],
      image: json['image'],
      voucherHour: json["voucher_hour"],
      voucherRoomPrice: json["voucher_room_price"],
      voucherRoomDiscount: json["voucher_room_discount"],
      conditionRoomType: json["condition_room_type"],
      conditionHour: json["condition_hour"],
      qty: json["voucher_qty"],
      conditionFnbPrice: json['condition_fnb_price'],
      conditionRoomPrice: json["condition_room_price"],
      conditionItemQty: json["condition_item_qty"],
      itemCode: json["item_code"],
      conditionItemPrice: json["condition_item_price"],
      voucherFnbPrice: json["voucher_fnb_price"],
      voucherFnbDiscount: json["voucher_fnb_discount"],
      conditionFnbDiscount: json["condition_fnb_discount"],
      voucherPrice: json["voucher_price"],
      conditionPrice: json["condition_price"],
      voucherDiscount: json["voucher_discount"],
      conditionDiscount: json["condition_discount"]);
}
