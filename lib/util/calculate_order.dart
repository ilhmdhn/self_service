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

  if ((dataCheckin.voucher?.voucherHour ?? 0) > 0) {
    isVoucherHour = true;
    vcrMinute = dataCheckin.voucher!.voucherHour! * 60;
  }

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
  roomPrice = roomPrice - voucherRoomValue - vcrRoomPrice;
  if (vcrRoomPercent > 0) {
    vcrRoomPercentResult = (vcrRoomPercent / 100) * roomPrice;
    roomPrice = roomPrice - vcrRoomPercentResult;
  }

  roomPrice = roomPrice.round();

  serviceRoom = roomPrice * (dataCheckin.roomPrice?.servicePercent ?? 0) / 100;
  taxRoom = (roomPrice + serviceRoom) * ((dataCheckin.roomPrice?.taxPercent ?? 0) / 100);
  roomTotal = roomPrice + serviceRoom + taxRoom;

  if (voucherFnbPercent > 0) {
    vcrFnbPercentResult = fnbTotal * (voucherFnbPercent / 100);
    fnbTotal = fnbTotal - vcrFnbPercentResult;
  }

  fnbTotal = fnbTotal.round();
  fnbTotal = fnbPrice + serviceFnb + taxFnb;
  dataCheckin.roomPrice?.roomPrice = roomPrice;
  dataCheckin.roomPrice?.serviceRoom = serviceRoom;
  dataCheckin.roomPrice?.taxRoom = taxRoom;
  dataCheckin.roomPrice?.priceTotal = roomTotal;

  dataCheckin.orderArgs?.fnb.fnbTotal = fnbPrice;
  dataCheckin.orderArgs?.fnb.fnbService = serviceFnb;
  dataCheckin.orderArgs?.fnb.fnbTax = taxFnb;
  dataCheckin.orderArgs?.fnb.totalAll = fnbTotal;

  return dataCheckin;
}
