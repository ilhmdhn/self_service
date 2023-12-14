import 'package:self_service/data/model/promo_food_model.dart';
import 'package:self_service/data/model/promo_room_model.dart';
import 'package:self_service/data/model/room_price_model.dart';
import 'package:self_service/data/model/voucher_model.dart';

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
  num fnbPromoResult;
  num fnbVoucherResult;
  num fnbServiceResult;
  num fnbTaxResult;
  num totalAll;

  num taxPercent;
  num servicePercent;
  List<FnBDetail> fnbList = [];

  FnBOrder({
    this.fnbList = const [],
    this.fnbTotal = 0,
    this.fnbServiceResult = 0,
    this.fnbTaxResult = 0,
    this.fnbPromoResult = 0,
    this.fnbVoucherResult = 0,
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
  num pricePromo;
  num priceTotal;
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
      this.pricePromo = 0,
      this.priceTotal = 0,
      this.isService,
      this.isTax,
      this.category = '',
      this.image = ''});
}

class CheckinArgs {
  OrderArgs? orderArgs;
  RoomPriceData? roomPrice;
  PaymentMethodArgs? payment;
  VoucherData? voucher;
  PromoRoomData? promoRoom;
  PromoFoodData? promoFood;

  CheckinArgs(
      {this.orderArgs,
      this.roomPrice,
      this.payment,
      this.voucher,
      this.promoRoom,
      this.promoFood});
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
    Map<String, dynamic>? voucher;
    Map<String, dynamic>? promoRoom;
    Map<String, dynamic>? promoFood;
    Map<String, dynamic>? payment;

/*

  String? idGlobal = '';
  String? idLocal = '';
  String? itemName = '';
  String? note = '';
  num? location = 0;
  num qty;
  num price;
  num pricePromo;
  num priceTotal;
  num? isService;
  num? isTax;
  String category = '';
  String image = '';

 */

    if ((dataCheckin.orderArgs?.fnb.fnbList ?? []).isNotEmpty) {
      for (var element in dataCheckin.orderArgs!.fnb.fnbList) {
        listFnb.add({
          'id_global': element.idGlobal,
          'id_local': element.idLocal,
          'item_name': element.itemName,
          'note': element.note,
          'location': element.location,
          'price': element.price,
          'price_promo': element.pricePromo,
          'qty': element.qty,
          'price_total': element.priceTotal
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

    if (dataCheckin.voucher != null) {
      voucher = <String, dynamic>{
        'voucherCode': dataCheckin.voucher?.voucherCode,
        'voucherName': dataCheckin.voucher?.voucherName,
        'description': dataCheckin.voucher?.description,
        'image': dataCheckin.voucher?.image,
        'voucherHour': dataCheckin.voucher?.voucherHour,
        'qty': dataCheckin.voucher?.qty,
        'voucherRoomPrice': dataCheckin.voucher?.voucherRoomPrice,
        'conditionFnbPrice': dataCheckin.voucher?.conditionFnbPrice,
        'voucherRoomDiscount': dataCheckin.voucher?.voucherRoomDiscount,
        'conditionRoomType': dataCheckin.voucher?.conditionRoomType,
        'conditionHour': dataCheckin.voucher?.conditionHour,
        'conditionRoomPrice': dataCheckin.voucher?.conditionRoomPrice,
        'conditionItemQty': dataCheckin.voucher?.conditionItemQty,
        'itemCode': dataCheckin.voucher?.itemCode,
        'conditionItemPrice': dataCheckin.voucher?.conditionItemPrice,
        'voucherFnbPrice': dataCheckin.voucher?.voucherFnbPrice,
        'voucherFnbDiscount': dataCheckin.voucher?.voucherFnbDiscount,
        'conditionFnbDiscount': dataCheckin.voucher?.conditionFnbDiscount,
        'voucherPrice': dataCheckin.voucher?.voucherPrice,
        'conditionPrice': dataCheckin.voucher?.conditionPrice,
        'voucherDiscount': dataCheckin.voucher?.voucherDiscount,
        'finalValue': dataCheckin.voucher?.finalValue,
        'conditionDiscount': dataCheckin.voucher?.conditionDiscount
      };
    }

    if (dataCheckin.promoRoom != null) {
      promoRoom = <String, dynamic>{
        'promoRoom': dataCheckin.promoRoom?.promoRoom,
        'hari': dataCheckin.promoRoom?.hari,
        'room': dataCheckin.promoRoom?.room,
        'dateStart': dataCheckin.promoRoom?.dateStart,
        'timeStart': dataCheckin.promoRoom?.timeStart,
        'dateFinish': dataCheckin.promoRoom?.dateFinish,
        'timeFinish': dataCheckin.promoRoom?.timeFinish,
        'diskonPersen': dataCheckin.promoRoom?.diskonPersen,
        'diskonRp': dataCheckin.promoRoom?.diskonRp,
      };
    }

    if (dataCheckin.promoFood != null) {
      promoFood = <String, dynamic>{
        'promoFood': dataCheckin.promoFood?.promoFood,
        'syaratKamar': dataCheckin.promoFood?.syaratKamar,
        'kamar': dataCheckin.promoFood?.kamar,
        'syaratJeniskamar': dataCheckin.promoFood?.syaratJeniskamar,
        'jenisKamar': dataCheckin.promoFood?.jenisKamar,
        'syaratDurasi': dataCheckin.promoFood?.syaratDurasi,
        'durasi': dataCheckin.promoFood?.durasi,
        'syaratHari': dataCheckin.promoFood?.syaratHari,
        'hari': dataCheckin.promoFood?.hari,
        'syaratJam': dataCheckin.promoFood?.syaratJam,
        'dateStart': dataCheckin.promoFood?.dateStart,
        'timeStart': dataCheckin.promoFood?.timeStart,
        'dateFinish': dataCheckin.promoFood?.dateFinish,
        'timeFinish': dataCheckin.promoFood?.timeFinish,
        'syaratInventory': dataCheckin.promoFood?.syaratInventory,
        'inventory': dataCheckin.promoFood?.inventory,
        'syaratQuantity': dataCheckin.promoFood?.syaratQuantity,
        'quantity': dataCheckin.promoFood?.quantity,
        'diskonPersen': dataCheckin.promoFood?.diskonPersen,
        'diskonRp': dataCheckin.promoFood?.diskonRp,
      };
    }

    if(dataCheckin.payment != null){
      payment = <String, dynamic>{
      'payment_method': dataCheckin.payment?.paymentMethod,
      'payment_channel': dataCheckin.payment?.paymentChannel,
      'name': dataCheckin.payment?.name,
      'fee': dataCheckin.payment?.fee,
      };
    }

    final Map<String, dynamic> bodyParams = {
      'member_code': dataCheckin.orderArgs?.memberCode,
      'member_name': dataCheckin.orderArgs?.memberName,
      'pax': dataCheckin.orderArgs?.pax,

      'room_category': dataCheckin.orderArgs?.roomCategory,
      'room_code': dataCheckin.orderArgs?.roomCode,
      'checkin_duration': dataCheckin.orderArgs?.checkinDuration,

      'room_price': dataCheckin.roomPrice?.roomPrice,
      'room_promo': dataCheckin.roomPrice?.roomPromo,
      'room_voucher': dataCheckin.roomPrice?.roomVoucher,
      'room_service': dataCheckin.roomPrice?.serviceRoom,
      'room_tax': dataCheckin.roomPrice?.taxRoom,
      'room_total': dataCheckin.roomPrice?.totalAll,

      'fnb_price': dataCheckin.orderArgs?.fnb.fnbTotal,
      'fnb_promo': dataCheckin.orderArgs?.fnb.fnbPromoResult,
      'fnb_voucher': dataCheckin.orderArgs?.fnb.fnbVoucherResult,
      'fnb_service': dataCheckin.orderArgs?.fnb.fnbServiceResult,
      'fnb_tax': dataCheckin.orderArgs?.fnb.fnbTaxResult,
      'fnb_total': dataCheckin.orderArgs?.fnb.totalAll,

      'room_detail': listRoomPrice,
      'promo_room_detail': promoRoom,
      'promo_food_detail': promoFood,
      'voucher_detail': voucher,
      'fnb_detail': listFnb,
      'payment': payment
    };

    return bodyParams;
  }
}
