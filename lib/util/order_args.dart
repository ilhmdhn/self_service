import 'package:self_service/data/model/room_price_model.dart';

class OrderArgs {
  String roomCategory = '';
  String roomCode = '';
  String memberCode = '';
  String memberName = '';
  String memberPhone = '';
  String memberEmail = '';
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
  String? icon;
  String? name;
  num? fee;

  PaymentMethodArgs(
      {this.paymentMethod,
      this.paymentChannel,
      this.name,
      this.fee,
      this.icon});
}

class GenerateJsonParams {
  
  Map<String, dynamic> convert(CheckinArgs dataCheckin) {
    List<Map<String, dynamic>> listFnb = [];
    List<Map<String, dynamic>> listRoomPrice = [];

    if ((dataCheckin.orderArgs?.fnb.fnbList??[]).isNotEmpty) {
      for (var element in dataCheckin.orderArgs!.fnb.fnbList) {
        listFnb.add({
          'id_global': element.idGlobal,
          'id_local': element.idLocal,
          'item_name': element.itemName,
          'note': element.note,
          'location': element.location,
          'qty': element.qty,
          'price': element.price,
        });
      }
    }
    if ((dataCheckin.roomPrice?.detail ?? []).isNotEmpty) {
      dataCheckin.roomPrice?.detail?.forEach((element) {
        listRoomPrice.add({
          'room': element.room,
          'day': element.day,
          'start_time': element.startTime,
          'finish_time': element.finishTime,
          'price': element.price,
          'price_per_minute': element.pricePerMinute,
          'used_minute': element.usedMinute,
          'room_total': element.roomTotal,
          'price_total': element.priceTotal
        });
      });
    }

    final Map<String, dynamic> bodyParams = {
      'member_code': dataCheckin.orderArgs?.memberCode,
      'member_name': dataCheckin.orderArgs?.memberName,
      'pax': dataCheckin.orderArgs?.pax,
      'room_category': dataCheckin.orderArgs?.roomCategory,
      'room_code': dataCheckin.orderArgs?.roomCode,
      'checkin_duration': dataCheckin.orderArgs?.checkinDuration,
      'room_price': dataCheckin.roomPrice?.roomPrice,
      'room_service': dataCheckin.roomPrice?.serviceRoom,
      'room_tax': dataCheckin.roomPrice?.taxRoom,
      'room_total': dataCheckin.roomPrice?.priceTotal,
      'room_detail': listRoomPrice,
      'fnb_price': dataCheckin.orderArgs?.fnb.fnbTotal,
      'fnb_service': dataCheckin.orderArgs?.fnb.fnbService,
      'fnb_tax': dataCheckin.orderArgs?.fnb.fnbTax,
      'fnb_total': dataCheckin.orderArgs?.fnb.totalAll,
      'fnb_detail': listFnb,
      'payment_method': dataCheckin.payment?.paymentMethod,
      'payment_channel': dataCheckin.payment?.paymentChannel
    };
    return bodyParams;
  }
}
