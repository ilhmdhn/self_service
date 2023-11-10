import 'package:self_service/data/model/voucher_model.dart';
import 'package:self_service/util/order_args.dart';

CheckinArgs calculateOrder(CheckinArgs dataCheckin) {
  num roomPrice = 0;
  num serviceRoom = 0;
  num taxRoom = 0;
  num roomTotal = 0;

  num fnbPrice = 0;
  num serviceFnb = 0;
  num taxFnb = 0;
  num fnbTotal = 0;

  num realRoom;
  num finalVoucher = 0;

//voucher nilai
  num voucherPrice = dataCheckin.voucher?.voucherPrice ?? 0;
  finalVoucher = finalVoucher + voucherPrice;
// voucher room
  bool isVoucherHour = false;
  int vcrMinute = 0;
  num voucherRoomValue = 0;
  num vcrRoomPrice = (dataCheckin.voucher?.voucherRoomPrice ?? 0);
  num vcrRoomPercent = (dataCheckin.voucher?.voucherRoomDiscount ?? 0);
  num vcrRoomPercentResult = 0;

// voucher fnb

  num voucherFnbPercent = (dataCheckin.voucher?.voucherFnbDiscount ?? 0);
  num vcrFnbPercentResult = 0;
  num vcrFnbItemResult = 0;

  if ((dataCheckin.voucher?.voucherHour ?? 0) > 0) {
    isVoucherHour = true;
    vcrMinute = dataCheckin.voucher!.voucherHour! * 60;
  }

  VoucherData? dataVoucher = dataCheckin.voucher;
  List<String> itemCondition = (dataVoucher?.itemCode ?? '')
      .split('|')
      .map((item) => item.trim())
      .toList();

  dataCheckin.roomPrice?.detail?.forEach((element) {
    if (isVoucherHour && vcrMinute > 0) {
      int usedMinute = element.usedMinute ?? 0;
      int cutMinute = 0;
      if (vcrMinute <= usedMinute) {
        cutMinute = vcrMinute;
      } else if (vcrMinute > usedMinute) {
        cutMinute = usedMinute;
      }

      voucherRoomValue =
          voucherRoomValue + (cutMinute * (element.pricePerMinute ?? 0));
      vcrMinute = vcrMinute - cutMinute;
    }

    roomPrice = roomPrice + (element.roomTotal ?? 0);
  });

  if (dataCheckin.orderArgs?.fnb.fnbList != [] &&
      dataCheckin.orderArgs?.fnb.fnbList != null) {
    for (var element in dataCheckin.orderArgs!.fnb.fnbList) {
      num service = 0;
      if (element.isService == 1) {
        service = ((element.price * element.qty) *
            (dataCheckin.orderArgs?.fnb.servicePercent ?? 0) /
            100);
      }
      if (element.isTax == 1) {
        taxFnb = taxFnb +
            (((element.price * element.qty) + service) *
                (dataCheckin.orderArgs?.fnb.taxPercent ?? 0) /
                100);
      }

      serviceFnb = serviceFnb + service;
      fnbPrice = fnbPrice + (element.price * element.qty);
    }
  }

//olah voucher room
  realRoom = roomPrice;
  roomPrice = roomPrice - voucherRoomValue - vcrRoomPrice;
  finalVoucher = finalVoucher + voucherRoomValue + vcrRoomPrice;
  if (vcrRoomPercent > 0) {
    vcrRoomPercentResult = (vcrRoomPercent / 100) * roomPrice;
    roomPrice = roomPrice - vcrRoomPercentResult;
    finalVoucher = finalVoucher + vcrRoomPercentResult;
  }

  if (voucherPrice > 0) {
    if (roomPrice <= voucherPrice) {
      voucherPrice = voucherPrice - roomPrice;
      roomPrice = 0;
    } else {
      roomPrice = roomPrice - voucherPrice;
      voucherPrice = 0;
    }
    roomPrice = roomPrice - voucherPrice;
    finalVoucher = finalVoucher + voucherPrice;
  }
  if (roomPrice < 0) {
    roomPrice = 0;
  }

  roomPrice = roomPrice.round();

  serviceRoom = roomPrice * (dataCheckin.roomPrice?.servicePercent ?? 0) / 100;
  taxRoom = (roomPrice + serviceRoom) *
      ((dataCheckin.roomPrice?.taxPercent ?? 0) / 100);
  roomTotal = roomPrice + serviceRoom + taxRoom;

  //olah voucher fnb
  if (voucherFnbPercent > 0) {
    vcrFnbPercentResult = fnbTotal * (voucherFnbPercent / 100);
    fnbTotal = fnbTotal - vcrFnbPercentResult;
    finalVoucher = finalVoucher + vcrFnbPercentResult;
  }

  if ((dataVoucher != null) && itemCondition.isNotEmpty) {
    List<FnBDetail> epEnBi = dataCheckin.orderArgs?.fnb.fnbList ?? [];
    for (int i = 0; i < (dataVoucher.qty ?? 0); i++) {
      for (int j = 0; j < (epEnBi.length) && (dataVoucher.qty ?? 0) > 0; j++) {
        if (itemCondition[i] == epEnBi[j].idGlobal &&epEnBi[j].qty > 0 &&(dataVoucher.qty ?? 0) > 0) {
          vcrFnbItemResult = vcrFnbItemResult + epEnBi[j].price;
          dataVoucher.qty = (dataVoucher.qty ?? 1) - 1;
          epEnBi[j].qty--;
        }
      }
    }
  }
  finalVoucher = finalVoucher + vcrFnbItemResult;
  fnbTotal = fnbTotal - vcrFnbItemResult;

  if (voucherPrice > 0) {
    if (fnbTotal <= voucherPrice) {
      fnbTotal = 0;
    } else {
      fnbTotal = fnbTotal - voucherPrice;
    }
  }
    
  if (fnbTotal < 0) {
    fnbTotal = 0;
  }

  fnbTotal = fnbTotal.round();
  fnbTotal = fnbPrice + serviceFnb + taxFnb;
  dataCheckin.roomPrice?.roomPrice = roomPrice;
  dataCheckin.roomPrice?.serviceRoom = serviceRoom;
  dataCheckin.roomPrice?.taxRoom = taxRoom;
  dataCheckin.roomPrice?.priceTotal = roomTotal;
  dataCheckin.roomPrice?.realRoom = realRoom;

  dataCheckin.orderArgs?.fnb.fnbTotal = fnbPrice;
  dataCheckin.orderArgs?.fnb.fnbService = serviceFnb;
  dataCheckin.orderArgs?.fnb.fnbTax = taxFnb;
  dataCheckin.orderArgs?.fnb.totalAll = fnbTotal;

  if (dataCheckin.voucher != null) {
    dataCheckin.voucher?.finalValue = finalVoucher;
  }

  return dataCheckin;
}
