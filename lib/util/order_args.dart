import 'package:self_service/data/model/room_price_model.dart';

class OrderArgs {
  String roomCategory = '';
  String roomCode = '';
  String memberCode = '';
  String memberName = '';
  int checkinDuration = 1;
  int pax = 1;
  FnBOrder fnb = FnBOrder();

  OrderArgs(
      {this.roomCategory = '',
      this.roomCode = '',
      FnBOrder? fnb,
      this.memberCode = '',
      this.checkinDuration = 1,
      this.pax = 1,
      this.memberName = ''})
      : fnb = fnb ?? FnBOrder();
}

class FnBOrder {
  num fnbTotal;
  num fnbService;
  num fnbTax;
  num totalAll;
  num servicePercent;
  num taxPercent;
  List<FnBDetail> fnbList = [];

  FnBOrder({
    this.fnbList = const [],
    this.fnbTotal = 0,
    this.fnbService = 0,
    this.fnbTax = 0,
    this.servicePercent = 0,
    this.taxPercent = 0,
    this.totalAll = 0,
  });
}

class FnBDetail {
  String? idGlobal = '';
  String? idLocal = '';
  String? itemName = '';
  String? note = '';
  num qty;
  num? location = 0;
  num price;
  num? isService;
  num? isTax;
  String category = '';
  String image = '';

  FnBDetail(
      {this.idGlobal,
      this.idLocal,
      this.location,
      this.itemName,
      this.note,
      this.qty = 0,
      this.price = 0,
      this.isService,
      this.isTax,
      this.category = '',
      this.image = ''});
}

class CheckinArgs {
  OrderArgs? orderArgs;
  RoomPriceData? roomPrice;
  PaymentMethodArgs? payment;
  CheckinArgs({this.orderArgs, this.roomPrice, this.payment});
}

class PaymentMethodArgs {
  String? paymentMethod;
  String? paymentChannel;
  String? name;
  num? fee;

  PaymentMethodArgs(
      {this.paymentMethod, this.paymentChannel, this.name, this.fee});
}