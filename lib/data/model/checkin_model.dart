class CheckinData {
  CheckinInfo? checkinInfo;
  FnBInfo? fnbInfo;
  PromoInfo? promoInfo;
}

class CheckinInfo {
  String? memberCode;
  String? memberName;
  String? roomCode;
  String? roomDuration;
  String? roomType;
  String? pax;
  String? chusr;
  String? shift;
  String? uangMuka;
  String? keterangan;
  String? idPayment;
  String? uangVoucher;
  String? reservation;
  String? statusPromo;
  String? invoiceTransfer;

  CheckinInfo(
      {this.memberCode,
      this.memberName,
      this.roomCode,
      this.roomDuration,
      this.roomType,
      this.pax,
      this.chusr,
      this.shift,
      this.uangMuka,
      this.keterangan,
      this.idPayment,
      this.uangVoucher,
      this.reservation,
      this.statusPromo,
      this.invoiceTransfer});
}

class FnBInfo {
  bool state = false;
  List<DataOrder>? dataOrder;

  FnBInfo({this.state = false, this.dataOrder});
}

class DataOrder {
  String? inventory;
  int? quantity;
  String? notes;

  DataOrder({this.inventory, this.quantity, this.notes});
}

class PromoInfo {
  bool state = false;
  PromoRoom? promoRoom;
  PromoFnB? promoFnB;

  PromoInfo({this.state = false, this.promoRoom, this.promoFnB});
}

class PromoRoom {
  bool state = false;
  String? promoName;

  PromoRoom({this.state = false, this.promoName});
}

class PromoFnB {
  bool state = false;
  String? promoName;

  PromoFnB({this.state = false, this.promoName});
}

class VoucherInfo {
  bool state = false;
  String? voucherCode;

  VoucherInfo({this.state = false, this.voucherCode});
}
