class CheckinData {
  CheckinInfo checkinInfo;
  FnBInfo fnbInfo;
  VoucherInfo voucherInfo;
  PromoInfo promoInfo;
  CheckinData(
      {required this.checkinInfo,
      required this.fnbInfo,
      required this.voucherInfo,
      required this.promoInfo});
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
  List<DataOrder>? dataOrder;
  FnBInfo({this.dataOrder});
}

class DataOrder {
  String? inventory;
  int? quantity;
  String? notes;

  DataOrder({this.inventory, this.quantity, this.notes});
}

class PromoInfo {
  dynamic promoRoom;
  dynamic promoFnB;

  PromoInfo({this.promoRoom = false, this.promoFnB = false});
}

class VoucherInfo {
  dynamic voucherCode;

  VoucherInfo({this.voucherCode = false});
}
