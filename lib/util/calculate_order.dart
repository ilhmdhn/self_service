import 'package:self_service/data/model/voucher_model.dart';
import 'package:self_service/util/order_args.dart';
import 'package:self_service/util/tools.dart';

CheckinArgs calculateOrder(CheckinArgs dataCheckin) {
  num roomPrice = 0;
  num serviceRoom = 0;
  num taxRoom = 0;
  num roomTotal = 0;

  num fnbPrice = 0;
  num serviceFnb = 0;
  num taxFnb = 0;
  num fnbTotal = 0;

  num realRoom = 0;
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

// promo room
  num promoRoomPercent = dataCheckin.promoRoom?.diskonPersen ?? 0;
  num promoRoomRupiah = dataCheckin.promoRoom?.diskonRp ?? 0;

// voucher fnb
  num voucherFnbPercent = (dataCheckin.voucher?.voucherFnbDiscount ?? 0);
  num vcrFnbPercentResult = 0;
  num vcrFnbItemResult = 0;

// promo fnb
  num promoFoodPercent = (dataCheckin.promoFood?.diskonPersen ?? 0);
  num promoFoodPercentResult = 0;
  num promoFoodRupiah = (dataCheckin.promoFood?.diskonRp ?? 0);

  if ((dataCheckin.voucher?.voucherHour ?? 0) > 0) {
    isVoucherHour = true;
    vcrMinute = dataCheckin.voucher!.voucherHour! * 60;
  }

  VoucherData? dataVoucher = dataCheckin.voucher;
  List<String> itemCondition = (dataVoucher?.itemCode ?? '')
      .split('|')
      .map((item) => item.trim())
      .toList();

  dataCheckin.roomPrice?.detail?.asMap().forEach((key, value) {
    double pricePerMinute =
        dataCheckin.roomPrice?.detail?[key].pricePerMinute ?? 0;
    int usedMinute = dataCheckin.roomPrice?.detail?[key].usedMinute ?? 0;
    dataCheckin.roomPrice?.realRoomPrice =
        (dataCheckin.roomPrice?.realRoomPrice ?? 0) + (value.roomTotal ?? 0);
    dataCheckin.roomPrice?.detail?[key].promoTotal = 0;
    dataCheckin.roomPrice?.detail?[key].promoPercent = 0;
    dataCheckin.roomPrice?.detail?[key].vcrMinute = 0;
    dataCheckin.roomPrice?.detail?[key].priceTotal =
        pricePerMinute * usedMinute;
  });

  dataCheckin.roomPrice?.detail?.asMap().forEach((index, element) {
    if (isVoucherHour && vcrMinute > 0 && (element.roomTotal ?? 0) > 0) {
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

      dataCheckin.roomPrice?.detail?[index].vcrMinute = cutMinute;
      dataCheckin.roomPrice?.detail?[index].priceTotal =
          roomTotal - voucherRoomValue;
    }
  });

  if (dataCheckin.promoRoom != null && promoRoomPercent > 0) {
    DateTime startPromo =
        convertToEndTime(dataCheckin.promoRoom?.timeStart ?? '00:00:00');
    DateTime endPromo =
        convertToEndTime(dataCheckin.promoRoom?.timeFinish ?? '23:59:59');
    int nextDay = dataCheckin.promoRoom?.dateFinish ?? 0;
    endPromo = endPromo.add(const Duration(minutes: 1));
    if (dataCheckin.promoRoom?.dateFinish == 1) {
      endPromo = endPromo.add(const Duration(days: 1));
    }
    bool addDate = false;
    int addedDate = 0;
    dataCheckin.roomPrice?.detail?.asMap().forEach((key, value) {
      bool inTimePromo = false;
      DateTime startTime = convertToEndTime(value.startTime ?? '23:59:59');
      DateTime finishTime = convertToEndTime(value.finishTime ?? '23:59:59');
      if (addDate) {
        startTime = startTime.add(const Duration(days: 1));
        finishTime = finishTime.add(const Duration(days: 1));
      }
      if (startTime.isAfter(finishTime)) {
        addDate = true;
        addedDate++;
        finishTime = finishTime.add(Duration(days: addedDate));
      }
      if ((startTime.isAfter(startPromo) ||
              startTime.isAtSameMomentAs(startPromo)) &&
          finishTime.isBefore(endPromo)) {
        inTimePromo = true;
      }

      if (nextDay == 1 && finishTime.isBefore(endPromo)) {
        inTimePromo = true;
      }
      if ((value.priceTotal ?? 0) > 0 && inTimePromo) {
        num promoPercent = dataCheckin.promoRoom?.diskonPersen ?? 0;
        if ((value.priceTotal ?? 0) > 0) {
          num totalRoom = value.priceTotal ?? 0;
          num promoValue = (totalRoom * promoPercent / 100);
          dataCheckin.roomPrice?.detail?[key].priceTotal =
              totalRoom - promoValue;
          dataCheckin.roomPrice?.detail?[key].promoTotal = promoValue;
          dataCheckin.roomPrice?.detail?[key].promoPercent =
              promoPercent.toInt();
        }
      }
    });
  }

  dataCheckin.roomPrice?.detail?.forEach((element) {
        roomPrice = roomPrice + (element.priceTotal ?? 0);
    realRoom = realRoom + ((element.pricePerMinute ?? 0) * (element.usedMinute ?? 0));F
  });

  promoRoomRupiah = dataCheckin.promoRoom?.diskonRp ?? 0;

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

  roomPrice = roomPrice - vcrRoomPrice;
  roomPrice = roomPrice - promoRoomRupiah;

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
        if (itemCondition[i] == epEnBi[j].idGlobal &&
            epEnBi[j].qty > 0 &&
            (dataVoucher.qty ?? 0) > 0) {
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

  if (dataCheckin.promoFood != null) {
    if (dataCheckin.promoFood?.syaratInventory == 1 &&
        (dataCheckin.promoFood?.inventory ?? '') != '') {
      dataCheckin.orderArgs?.fnb.fnbList.forEach((element) {
        promoFoodPercentResult = element.price * promoFoodPercent / 100;
      });
    } else {
      promoFoodPercentResult = fnbTotal * promoFoodPercent / 100;
    }
  }

  fnbTotal = fnbTotal - promoFoodPercentResult - promoFoodRupiah;
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

  if (dataCheckin.voucher != null) {
    dataCheckin.voucher?.finalValue = finalVoucher;
  }
  return dataCheckin;
}
